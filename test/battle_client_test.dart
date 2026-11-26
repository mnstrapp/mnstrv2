import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:mnstrv2/providers/battle.dart';
import 'package:mnstrv2/proto/battles.pbgrpc.dart' as proto;

/// An in-process battle server the tests drive by hand.
class FakeBattleService extends proto.BattleServiceBase {
  final joinTokens = <String>[];
  final joins = <StreamController<proto.BattleEvent>>[];
  final joinCanceled = <Completer<void>>[];
  final requests = <Object>[];
  GrpcError? unaryError;

  @override
  Stream<proto.BattleEvent> join(
    ServiceCall call,
    proto.JoinBattleQueueRequest request,
  ) {
    joinTokens.add(request.token);
    final canceled = Completer<void>();
    final controller = StreamController<proto.BattleEvent>(
      onCancel: () {
        if (!canceled.isCompleted) canceled.complete();
      },
    );
    joins.add(controller);
    joinCanceled.add(canceled);
    return controller.stream;
  }

  Future<T> _answer<T>(Object request, T response) async {
    requests.add(request);
    final error = unaryError;
    if (error != null) {
      throw error;
    }
    return response;
  }

  @override
  Future<proto.LeaveBattleQueueResponse> leave(
    ServiceCall call,
    proto.LeaveBattleQueueRequest request,
  ) => _answer(request, proto.LeaveBattleQueueResponse(success: true));

  @override
  Future<proto.ListBattlePlayersResponse> listPlayers(
    ServiceCall call,
    proto.ListBattlePlayersRequest request,
  ) => _answer(
    request,
    proto.ListBattlePlayersResponse(
      statuses: [proto.BattleStatus(userId: 'other')],
    ),
  );

  @override
  Future<proto.ChallengeResponse> challenge(
    ServiceCall call,
    proto.ChallengeRequest request,
  ) => _answer(request, proto.ChallengeResponse(challengeId: 'challenge-1'));

  @override
  Future<proto.CancelChallengeResponse> cancelChallenge(
    ServiceCall call,
    proto.CancelChallengeRequest request,
  ) => _answer(request, proto.CancelChallengeResponse(success: true));

  @override
  Future<proto.AcceptChallengeResponse> acceptChallenge(
    ServiceCall call,
    proto.AcceptChallengeRequest request,
  ) => _answer(
    request,
    proto.AcceptChallengeResponse(
      state: proto.BattleState(battleId: 'battle-1'),
    ),
  );

  @override
  Future<proto.RejectChallengeResponse> rejectChallenge(
    ServiceCall call,
    proto.RejectChallengeRequest request,
  ) => _answer(request, proto.RejectChallengeResponse(success: true));

  @override
  Future<proto.ChooseMnstrResponse> chooseMnstr(
    ServiceCall call,
    proto.ChooseMnstrRequest request,
  ) => _answer(
    request,
    proto.ChooseMnstrResponse(
      state: proto.BattleState(battleId: request.battleId),
    ),
  );

  proto.TurnResponse _turn(proto.BattleTurnAction action) => proto.TurnResponse(
    result: proto.TurnResult(action: action, hit: true, damage: 4),
    state: proto.BattleState(battleId: 'battle-1', turnUserId: 'other'),
  );

  @override
  Future<proto.TurnResponse> attack(
    ServiceCall call,
    proto.TurnRequest request,
  ) => _answer(
    request,
    _turn(proto.BattleTurnAction.BATTLE_TURN_ACTION_ATTACK),
  );

  @override
  Future<proto.TurnResponse> defend(
    ServiceCall call,
    proto.TurnRequest request,
  ) => _answer(
    request,
    _turn(proto.BattleTurnAction.BATTLE_TURN_ACTION_DEFEND),
  );

  @override
  Future<proto.TurnResponse> magic(
    ServiceCall call,
    proto.TurnRequest request,
  ) => _answer(request, _turn(proto.BattleTurnAction.BATTLE_TURN_ACTION_MAGIC));

  @override
  Future<proto.EscapeResponse> escape(
    ServiceCall call,
    proto.EscapeRequest request,
  ) => _answer(
    request,
    proto.EscapeResponse(
      gameEnded: proto.GameEnded(winnerId: 'other', escaped: true),
    ),
  );

  @override
  Future<proto.RejoinResponse> rejoin(
    ServiceCall call,
    proto.RejoinRequest request,
  ) => _answer(
    request,
    proto.RejoinResponse(state: proto.BattleState(battleId: request.battleId)),
  );
}

proto.BattleEvent event(String id) => proto.BattleEvent(
  id: id,
  playerJoined: proto.PlayerJoined(status: proto.BattleStatus(userId: id)),
);

Future<T> next<T>(Stream<T> stream, bool Function(T) test) =>
    stream.firstWhere(test).timeout(const Duration(seconds: 5));

Future<void> eventually(bool Function() condition) async {
  final deadline = DateTime.now().add(const Duration(seconds: 5));
  while (!condition()) {
    if (DateTime.now().isAfter(deadline)) {
      throw TimeoutException('condition not met');
    }
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
}

void main() {
  late Server server;
  late FakeBattleService service;
  late BattleClient client;
  String? token;

  setUp(() async {
    service = FakeBattleService();
    server = Server.create(services: [service]);
    await server.serve(address: InternetAddress.loopbackIPv4, port: 0);
    token = 'token-1';
    client = BattleClient(
      channel: ClientChannel(
        InternetAddress.loopbackIPv4.address,
        port: server.port!,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      ),
      token: () => token,
      retryDelays: const [Duration(milliseconds: 20)],
      callTimeout: const Duration(seconds: 5),
    );
  });

  tearDown(() async {
    await client.dispose();
    await server.shutdown();
  });

  group('Join stream', () {
    test('forwards events and reports the connection', () async {
      final states = <BattleConnection>[];
      client.connectionChanges.listen(states.add);
      final received = <String>[];
      client.events.listen((e) => received.add(e.id));

      client.connect();
      await eventually(() => service.joins.length == 1);
      expect(service.joinTokens, ['token-1']);

      service.joins.first.add(event('a'));
      service.joins.first.add(event('b'));
      await eventually(() => received.length == 2);

      expect(received, ['a', 'b']);
      expect(client.connection, BattleConnection.connected);
      expect(states, [BattleConnection.connecting, BattleConnection.connected]);
    });

    test('connecting twice opens one stream', () async {
      client.connect();
      client.connect();
      await eventually(() => service.joins.isNotEmpty);
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(service.joins, hasLength(1));
    });

    test('reconnects when the stream is unavailable', () async {
      final errors = <BattleException>[];
      client.streamErrors.listen(errors.add);
      client.connect();
      await eventually(() => service.joins.length == 1);
      service.joins.first.add(event('a'));
      await next(
        client.connectionChanges,
        (c) => c == BattleConnection.connected,
      );

      final reconnecting = next(
        client.connectionChanges,
        (c) => c == BattleConnection.reconnecting,
      );
      service.joins.first.addError(GrpcError.unavailable('events stopped'));
      await service.joins.first.close();
      await reconnecting;

      await eventually(() => service.joins.length == 2);
      service.joins.last.add(event('b'));
      final e = await next(client.events, (e) => e.id == 'b');
      expect(e.id, 'b');
      expect(client.connection, BattleConnection.connected);
      expect(errors.single.kind, BattleErrorKind.unavailable);
    });

    test('reconnects when the server ends the stream', () async {
      client.connect();
      await eventually(() => service.joins.length == 1);
      await service.joins.first.close();
      await eventually(() => service.joins.length == 2);
    });

    test('stops on an unauthenticated stream', () async {
      final errors = <BattleException>[];
      client.streamErrors.listen(errors.add);
      client.connect();
      await eventually(() => service.joins.length == 1);
      service.joins.first.addError(
        GrpcError.unauthenticated('Invalid session'),
      );
      await service.joins.first.close();

      await eventually(() => errors.isNotEmpty);
      await eventually(
        () => client.connection == BattleConnection.disconnected,
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(service.joins, hasLength(1));
      expect(errors.single.kind, BattleErrorKind.unauthenticated);
    });

    test('does not connect without a session', () async {
      token = null;
      final error = next(client.streamErrors, (_) => true);
      client.connect();
      expect((await error).kind, BattleErrorKind.unauthenticated);
      expect(client.connection, BattleConnection.disconnected);
      expect(service.joins, isEmpty);
    });

    test('disconnect closes the stream and does not reconnect', () async {
      client.connect();
      await eventually(() => service.joins.length == 1);
      service.joins.first.add(event('a'));
      await next(
        client.connectionChanges,
        (c) => c == BattleConnection.connected,
      );

      await client.disconnect();
      await service.joinCanceled.first.future.timeout(
        const Duration(seconds: 5),
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(client.connection, BattleConnection.disconnected);
      expect(service.joins, hasLength(1));
    });
  });

  group('actions', () {
    test('send the token and the request fields', () async {
      expect(await client.challenge('other'), 'challenge-1');
      await client.cancelChallenge(challengeId: 'c1', opponentId: 'other');
      final accepted = await client.acceptChallenge(
        challengeId: 'c2',
        challengerId: 'other',
      );
      await client.rejectChallenge(challengeId: 'c3', challengerId: 'other');
      final chosen = await client.chooseMnstr(
        battleId: 'battle-1',
        mnstrId: 'm1',
      );
      final attack = await client.attack('battle-1');
      final defend = await client.defend('battle-1');
      final magic = await client.magic('battle-1');
      final escaped = await client.escape('battle-1');
      final rejoined = await client.rejoin('battle-1');
      final players = await client.listPlayers();
      await client.leave();

      expect(accepted.battleId, 'battle-1');
      expect(chosen.battleId, 'battle-1');
      expect(
        attack.result.action,
        proto.BattleTurnAction.BATTLE_TURN_ACTION_ATTACK,
      );
      expect(
        defend.result.action,
        proto.BattleTurnAction.BATTLE_TURN_ACTION_DEFEND,
      );
      expect(
        magic.result.action,
        proto.BattleTurnAction.BATTLE_TURN_ACTION_MAGIC,
      );
      expect(magic.state.turnUserId, 'other');
      expect(escaped.escaped, isTrue);
      expect(rejoined.battleId, 'battle-1');
      expect(players.single.userId, 'other');

      final requests = service.requests;
      expect(requests, hasLength(12));
      expect(
        requests.map((r) => (r as dynamic).token as String).toSet(),
        {'token-1'},
      );
      expect((requests[0] as proto.ChallengeRequest).opponentId, 'other');
      final cancel = requests[1] as proto.CancelChallengeRequest;
      expect([cancel.challengeId, cancel.opponentId], ['c1', 'other']);
      final accept = requests[2] as proto.AcceptChallengeRequest;
      expect([accept.challengeId, accept.challengerId], ['c2', 'other']);
      final reject = requests[3] as proto.RejectChallengeRequest;
      expect([reject.challengeId, reject.challengerId], ['c3', 'other']);
      final choose = requests[4] as proto.ChooseMnstrRequest;
      expect([choose.battleId, choose.mnstrId], ['battle-1', 'm1']);
      expect((requests[5] as proto.TurnRequest).battleId, 'battle-1');
      expect((requests[8] as proto.EscapeRequest).battleId, 'battle-1');
      expect((requests[9] as proto.RejoinRequest).battleId, 'battle-1');
    });

    test('map gRPC errors for the UI', () async {
      final cases = {
        GrpcError.failedPrecondition('It is not your turn'): (
          BattleErrorKind.failedPrecondition,
          'It is not your turn',
        ),
        GrpcError.notFound('Battle not found'): (
          BattleErrorKind.notFound,
          'Battle not found',
        ),
        GrpcError.permissionDenied('You are not in this battle'): (
          BattleErrorKind.permissionDenied,
          'You are not in this battle',
        ),
        GrpcError.invalidArgument('You cannot challenge yourself'): (
          BattleErrorKind.invalidArgument,
          'You cannot challenge yourself',
        ),
        GrpcError.unauthenticated('Invalid session'): (
          BattleErrorKind.unauthenticated,
          'Your session has expired. Please log in again.',
        ),
        GrpcError.internal('Error updating battle'): (
          BattleErrorKind.unknown,
          'Something went wrong. Please try again.',
        ),
      };
      for (final MapEntry(key: error, value: (kind, message))
          in cases.entries) {
        service.unaryError = error;
        await expectLater(
          client.attack('battle-1'),
          throwsA(
            isA<BattleException>()
                .having((e) => e.kind, 'kind', kind)
                .having((e) => e.message, 'message', message),
          ),
        );
      }
    });

    test('fail without a session and never call the server', () async {
      token = null;
      await expectLater(
        client.listPlayers(),
        throwsA(
          isA<BattleException>().having(
            (e) => e.kind,
            'kind',
            BattleErrorKind.unauthenticated,
          ),
        ),
      );
      expect(service.requests, isEmpty);
    });
  });

  group('BattleException.fromGrpc', () {
    test('falls back to a default message', () {
      final error = BattleException.fromGrpc(GrpcError.notFound());
      expect(error.kind, BattleErrorKind.notFound);
      expect(
        error.message,
        BattleException.defaultMessage(BattleErrorKind.notFound),
      );
    });

    test('treats deadlines as connection problems', () {
      expect(
        BattleException.fromGrpc(GrpcError.deadlineExceeded('slow')).kind,
        BattleErrorKind.unavailable,
      );
    });
  });
}
