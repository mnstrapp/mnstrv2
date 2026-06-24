import 'package:riverpod/riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';

import '../config/endpoints.dart' as endpoints;
import '../models/user.dart';
import 'auth.dart';

import '../proto/session.pb.dart' as proto_session;
import '../proto/session.pbgrpc.dart' as proto_session_grpc;

final userProvider = AsyncNotifierProvider<UserNotifier, User?>(
  () => UserNotifier(),
);

class UserNotifier extends AsyncNotifier<User?> {
  UserNotifier();

  @override
  Future<User?> build() async {
    return null;
  }

  Future<String?> deleteAccount() async {
    final auth = ref.read(authProvider);

    if (auth == null) {
      return "There was an error deleting the account";
    }

    try {
      final request = proto_session.UnregisterRequest(token: auth.token);
      final channel = ClientChannel(
        endpoints.apiHost,
        port: endpoints.apiPort,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );
      final response = await proto_session_grpc.SessionServiceClient(
        channel,
      ).unregister(request);
      if (response.success) {
        return null;
      }
      return "Failed to delete account";
    } catch (e, stackTrace) {
      debugPrint('deleteAccount error: $e, $stackTrace');
      return "Failed to delete account";
    }
  }
}
