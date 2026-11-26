import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';

import '../config/endpoints.dart' as endpoints;
import '../proto/battles.pbgrpc.dart' as proto;
import 'auth.dart';

/// Why a battle call failed, in terms the UI can act on.
enum BattleErrorKind {
  unauthenticated,
  notFound,
  permissionDenied,
  failedPrecondition,
  invalidArgument,
  unavailable,
  unknown,
}

/// A failed battle call. [message] is safe to show to the player.
class BattleException implements Exception {
  final BattleErrorKind kind;
  final String message;

  const BattleException(this.kind, this.message);

  factory BattleException.fromGrpc(GrpcError error) {
    final kind = switch (error.code) {
      StatusCode.unauthenticated => BattleErrorKind.unauthenticated,
      StatusCode.notFound => BattleErrorKind.notFound,
      StatusCode.permissionDenied => BattleErrorKind.permissionDenied,
      StatusCode.failedPrecondition => BattleErrorKind.failedPrecondition,
      StatusCode.invalidArgument => BattleErrorKind.invalidArgument,
      StatusCode.unavailable ||
      StatusCode.deadlineExceeded => BattleErrorKind.unavailable,
      _ => BattleErrorKind.unknown,
    };
    final serverMessage = error.message ?? '';
    final message = switch (kind) {
      // The server's own text is written for players for these codes.
      BattleErrorKind.notFound ||
      BattleErrorKind.permissionDenied ||
      BattleErrorKind.failedPrecondition ||
      BattleErrorKind.invalidArgument when serverMessage.isNotEmpty =>
        serverMessage,
      _ => defaultMessage(kind),
    };
    return BattleException(kind, message);
  }

  static String defaultMessage(BattleErrorKind kind) => switch (kind) {
    BattleErrorKind.unauthenticated =>
      'Your session has expired. Please log in again.',
    BattleErrorKind.notFound => 'That battle or player no longer exists.',
    BattleErrorKind.permissionDenied => 'You are not allowed to do that.',
    BattleErrorKind.failedPrecondition => 'You cannot do that right now.',
    BattleErrorKind.invalidArgument => 'That request was not valid.',
    BattleErrorKind.unavailable => 'Lost connection to the battle server.',
    BattleErrorKind.unknown => 'Something went wrong. Please try again.',
  };

  @override
  String toString() => 'BattleException($kind): $message';
}

/// The state of the `Join` event stream.
enum BattleConnection { disconnected, connecting, connected, reconnecting }

/// One gRPC channel to the battle service: the `Join` event stream with
/// automatic reconnects, and the unary battle actions.
///
/// Every call sends the current session token from [token].
class BattleClient {
  BattleClient({
    required ClientChannel channel,
    required this.token,
    this.retryDelays = const [
      Duration(seconds: 1),
      Duration(seconds: 2),
      Duration(seconds: 5),
      Duration(seconds: 10),
    ],
    this.callTimeout = const Duration(seconds: 15),
  }) : _channel = channel,
       _client = proto.BattleServiceClient(channel);

  final ClientChannel _channel;
  final proto.BattleServiceClient _client;

  /// The current session token, read before every call.
  final String? Function() token;

  /// Waits between reconnect attempts; the last one repeats.
  final List<Duration> retryDelays;

  /// Deadline for each unary call.
  final Duration callTimeout;

  final _events = StreamController<proto.BattleEvent>.broadcast();
  final _connectionChanges = StreamController<BattleConnection>.broadcast();
  final _streamErrors = StreamController<BattleException>.broadcast();

  StreamSubscription<proto.BattleEvent>? _subscription;
  Timer? _retryTimer;
  BattleConnection _connection = BattleConnection.disconnected;
  int _attempt = 0;
  bool _wanted = false;
  bool _disposed = false;

  /// Lobby and battle events from the `Join` stream.
  Stream<proto.BattleEvent> get events => _events.stream;

  /// Changes to [connection].
  Stream<BattleConnection> get connectionChanges => _connectionChanges.stream;

  /// Why the event stream dropped. An `unauthenticated` error stops
  /// reconnecting; anything else is retried.
  Stream<BattleException> get streamErrors => _streamErrors.stream;

  BattleConnection get connection => _connection;

  /// Opens the event stream and keeps it open until [disconnect].
  void connect() {
    if (_disposed) {
      return;
    }
    _wanted = true;
    if (_subscription != null || _retryTimer != null) {
      return;
    }
    _attempt = 0;
    _open();
  }

  /// Closes the event stream. The server treats this as leaving the lobby.
  Future<void> disconnect() async {
    _wanted = false;
    _retryTimer?.cancel();
    _retryTimer = null;
    final subscription = _subscription;
    _subscription = null;
    await subscription?.cancel();
    _setConnection(BattleConnection.disconnected);
  }

  Future<void> dispose() async {
    if (_disposed) {
      return;
    }
    await disconnect();
    _disposed = true;
    await _events.close();
    await _connectionChanges.close();
    await _streamErrors.close();
    await _channel.shutdown();
  }

  void _open() {
    _retryTimer = null;
    final token = this.token();
    if (token == null || token.isEmpty) {
      _stop(
        const BattleException(
          BattleErrorKind.unauthenticated,
          'Please log in to battle.',
        ),
      );
      return;
    }
    _setConnection(
      _attempt == 0
          ? BattleConnection.connecting
          : BattleConnection.reconnecting,
    );
    final stream = _client.join(proto.JoinBattleQueueRequest(token: token));
    _subscription = stream.listen(
      (event) {
        if (_connection != BattleConnection.connected) {
          _attempt = 0;
          _setConnection(BattleConnection.connected);
        }
        if (!_events.isClosed) {
          _events.add(event);
        }
      },
      onError: (Object error) => _onStreamClosed(error),
      onDone: () => _onStreamClosed(null),
      cancelOnError: true,
    );
  }

  void _onStreamClosed(Object? error) {
    _subscription = null;
    if (!_wanted || _disposed) {
      _setConnection(BattleConnection.disconnected);
      return;
    }
    final exception = switch (error) {
      null => null,
      GrpcError() => BattleException.fromGrpc(error),
      _ => const BattleException(
        BattleErrorKind.unavailable,
        'Lost connection to the battle server.',
      ),
    };
    if (exception?.kind == BattleErrorKind.unauthenticated) {
      _stop(exception!);
      return;
    }
    if (exception != null) {
      debugPrint('[BattleClient] event stream dropped: $error');
      _streamErrors.add(exception);
    }
    final delay = retryDelays[math.min(_attempt, retryDelays.length - 1)];
    _attempt++;
    _setConnection(BattleConnection.reconnecting);
    _retryTimer = Timer(delay, _open);
  }

  void _stop(BattleException exception) {
    _wanted = false;
    if (!_streamErrors.isClosed) {
      _streamErrors.add(exception);
    }
    _setConnection(BattleConnection.disconnected);
  }

  void _setConnection(BattleConnection connection) {
    if (_connection == connection) {
      return;
    }
    _connection = connection;
    if (!_connectionChanges.isClosed) {
      _connectionChanges.add(connection);
    }
  }

  Future<T> _call<T>(
    Future<T> Function(String token, CallOptions options) call,
  ) async {
    final token = this.token();
    if (token == null || token.isEmpty) {
      throw const BattleException(
        BattleErrorKind.unauthenticated,
        'Please log in to battle.',
      );
    }
    try {
      return await call(token, CallOptions(timeout: callTimeout));
    } on GrpcError catch (error) {
      throw BattleException.fromGrpc(error);
    }
  }

  Future<void> leave() => _call(
    (token, options) => _client.leave(
      proto.LeaveBattleQueueRequest(token: token),
      options: options,
    ),
  );

  /// Everyone in the lobby except the caller.
  Future<List<proto.BattleStatus>> listPlayers() async {
    final response = await _call(
      (token, options) => _client.listPlayers(
        proto.ListBattlePlayersRequest(token: token),
        options: options,
      ),
    );
    return response.statuses;
  }

  /// Challenges [opponentId]; returns the challenge id.
  Future<String> challenge(String opponentId) async {
    final response = await _call(
      (token, options) => _client.challenge(
        proto.ChallengeRequest(token: token, opponentId: opponentId),
        options: options,
      ),
    );
    return response.challengeId;
  }

  Future<void> cancelChallenge({
    required String challengeId,
    required String opponentId,
  }) => _call(
    (token, options) => _client.cancelChallenge(
      proto.CancelChallengeRequest(
        token: token,
        challengeId: challengeId,
        opponentId: opponentId,
      ),
      options: options,
    ),
  );

  Future<proto.BattleState> acceptChallenge({
    required String challengeId,
    required String challengerId,
  }) async {
    final response = await _call(
      (token, options) => _client.acceptChallenge(
        proto.AcceptChallengeRequest(
          token: token,
          challengeId: challengeId,
          challengerId: challengerId,
        ),
        options: options,
      ),
    );
    return response.state;
  }

  Future<void> rejectChallenge({
    required String challengeId,
    required String challengerId,
  }) => _call(
    (token, options) => _client.rejectChallenge(
      proto.RejectChallengeRequest(
        token: token,
        challengeId: challengeId,
        challengerId: challengerId,
      ),
      options: options,
    ),
  );

  Future<proto.BattleState> chooseMnstr({
    required String battleId,
    required String mnstrId,
  }) async {
    final response = await _call(
      (token, options) => _client.chooseMnstr(
        proto.ChooseMnstrRequest(
          token: token,
          battleId: battleId,
          mnstrId: mnstrId,
        ),
        options: options,
      ),
    );
    return response.state;
  }

  Future<proto.TurnResponse> attack(String battleId) => _call(
    (token, options) => _client.attack(
      proto.TurnRequest(token: token, battleId: battleId),
      options: options,
    ),
  );

  Future<proto.TurnResponse> defend(String battleId) => _call(
    (token, options) => _client.defend(
      proto.TurnRequest(token: token, battleId: battleId),
      options: options,
    ),
  );

  Future<proto.TurnResponse> magic(String battleId) => _call(
    (token, options) => _client.magic(
      proto.TurnRequest(token: token, battleId: battleId),
      options: options,
    ),
  );

  Future<proto.GameEnded> escape(String battleId) async {
    final response = await _call(
      (token, options) => _client.escape(
        proto.EscapeRequest(token: token, battleId: battleId),
        options: options,
      ),
    );
    return response.gameEnded;
  }

  Future<proto.BattleState> rejoin(String battleId) async {
    final response = await _call(
      (token, options) => _client.rejoin(
        proto.RejoinRequest(token: token, battleId: battleId),
        options: options,
      ),
    );
    return response.state;
  }
}

/// The channel to the battle service. HTTP/2 keepalive pings keep the
/// long-lived `Join` stream from being dropped by idle proxies.
ClientChannel createBattleChannel() => ClientChannel(
  endpoints.apiHost,
  port: endpoints.apiPort,
  options: const ChannelOptions(
    credentials: ChannelCredentials.insecure(),
    keepAlive: ClientKeepAliveOptions(
      pingInterval: Duration(seconds: 30),
      timeout: Duration(seconds: 10),
    ),
  ),
);

final battleClientProvider = Provider<BattleClient>((ref) {
  final client = BattleClient(
    channel: createBattleChannel(),
    token: () => ref.read(authProvider)?.token,
  );
  ref.onDispose(client.dispose);
  return client;
});
