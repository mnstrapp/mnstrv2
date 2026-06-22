import 'dart:convert';

import 'package:grpc/grpc.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/endpoints.dart' as endpoints;
import '../models/user.dart';
import '../proto/users.pbgrpc.dart' as proto_user;
import '../proto/session.pbgrpc.dart' as proto_session;
import 'auth.dart';

final sessionUserProvider = NotifierProvider<SessionUserNotifier, User?>(
  () => SessionUserNotifier(),
);

class SessionUserNotifier extends Notifier<User?> {
  User? user;

  SessionUserNotifier({this.user});

  @override
  User? build() {
    return user;
  }

  Future<String?> register({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final request = proto_session.RegisterRequest(
      email: email,
      password: password,
      displayName: displayName,
    );
    final channel = ClientChannel(
      endpoints.apiHost,
      port: endpoints.apiPort,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    try {
      final response = await proto_session.SessionServiceClient(
        channel,
      ).register(request);
      if (response.success) {
        return null;
      }
      return "There was an error registering the user";
    } catch (e) {
      debugPrint('register error: $e');
      return "There was an error registering the user";
    }
  }

  Future<String?> verifyEmail({
    required String code,
  }) async {
    final request = proto_session.VerifyEmailRequest(
      code: code,
    );
    final channel = ClientChannel(
      endpoints.apiHost,
      port: endpoints.apiPort,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    try {
      final response = await proto_session.SessionServiceClient(
        channel,
      ).verifyEmail(request);
      if (response.success) {
        return null;
      }
      return "There was an error verifying the email";
    } catch (e) {
      debugPrint('verifyEmail error: $e');
      return "There was an error verifying the email";
    }
  }

  void setUser(User user) {
    state = user;
  }

  Future<void> logout() async {
    await removeSessionUser();
    state = null;
  }

  Future<String?> refresh() async {
    final auth = await getAuth();

    if (auth == null) {
      return "There was an error refreshing the user";
    }

    final request = proto_user.MyUserRequest(token: auth.token);
    final channel = ClientChannel(
      endpoints.apiHost,
      port: endpoints.apiPort,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    final response = await proto_user.UserServiceClient(
      channel,
    ).myUser(request);
    final user = User.fromProto(response.user);
    state = user;
    await saveSessionUser(user);
    return null;
  }
}

class ForgotPasswordNotifier extends Notifier<String?> {
  @override
  String? build() {
    return null;
  }

  Future<String?> forgotPassword({required String email}) async {
    final request = proto_session.ForgotPasswordRequest(email: email);
    final channel = ClientChannel(
      endpoints.apiHost,
      port: endpoints.apiPort,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    try {
      final response = await proto_session.SessionServiceClient(
        channel,
      ).forgotPassword(request);
      if (response.success) {
        return null;
      }
      return "There was an error resetting the password";
    } catch (e) {
      debugPrint('forgotPassword error: $e');
      return "There was an error resetting the password";
    }
  }
}

class ResetPasswordNotifier extends Notifier<String?> {
  @override
  String? build() {
    return null;
  }

  Future<String?> resetPassword({required String password}) async {
    if (state == null) {
      return "There was an error resetting the password";
    }

    final request = proto_session.ResetPasswordRequest(
      code: state,
      password: password,
    );
    final channel = ClientChannel(
      endpoints.apiHost,
      port: endpoints.apiPort,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    try {
      final response = await proto_session.SessionServiceClient(
        channel,
      ).resetPassword(request);
      if (response.success) {
        return null;
      }
      return "There was an error resetting the password";
    } catch (e) {
      debugPrint('resetPassword error: $e');
      return "There was an error resetting the password";
    }
  }

  Future<String?> verifyCode({required String code}) async {
    final request = proto_session.VerifyEmailRequest(code: code);
    final channel = ClientChannel(
      endpoints.apiHost,
      port: endpoints.apiPort,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    try {
      final response = await proto_session.SessionServiceClient(
        channel,
      ).verifyEmail(request);
      if (response.success) {
        state = code;
        return null;
      }
      return "There was an error verifying the code";
    } catch (e) {
      debugPrint('verifyCode error: $e');
      return "There was an error verifying the code";
    }
  }
}

final forgotPasswordProvider =
    NotifierProvider<ForgotPasswordNotifier, String?>(
      () => ForgotPasswordNotifier(),
    );

final resetPasswordProvider = NotifierProvider<ResetPasswordNotifier, String?>(
  () => ResetPasswordNotifier(),
);

enum UserKey { user }

Future<void> saveSessionUser(User user) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(UserKey.user.name, jsonEncode(user.toJson()));
}

Future<User?> getSessionUser() async {
  final prefs = await SharedPreferences.getInstance();
  final user = prefs.getString(UserKey.user.name);
  return user != null ? User.fromJson(jsonDecode(user)) : null;
}

Future<void> removeSessionUser() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(UserKey.user.name);
}
