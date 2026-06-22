import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:mnstrv2/proto/session.pbgrpc.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth.dart';
import 'local_storage.dart';
import 'session_users.dart';
import '../config/endpoints.dart' as endpoints;
import 'sync.dart';

final authProvider = NotifierProvider<AuthNotifier, Auth?>(
  () => AuthNotifier(),
);

class AuthNotifier extends Notifier<Auth?> {
  Auth? auth;

  AuthNotifier({this.auth});

  @override
  Auth? build() {
    return auth;
  }

  Future<String?> login(String email, String password) async {
    final request = LoginRequest(email: email, password: password);
    final channel = ClientChannel(
      endpoints.apiHost,
      port: endpoints.apiPort,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    try {
      final response = await SessionServiceClient(channel).login(request);
      debugPrint(response.toString());
      final auth = Auth(
        id: response.session.id,
        token: response.session.token,
        userID: response.session.user.id,
      );
      setAuth(auth);
      await saveAuth(auth);
      return null;
    } catch (e) {
      debugPrint('login error: $e');
      return "There was an error logging in";
    }
  }

  Future<String?> logout() async {
    final auth = await getAuth();

    await removeAuth();
    await removeSessionUser();
    await savePreviouslySynced(false);
    await LocalStorage.clearMnstrs();

    state = null;

    if (auth == null) {
      return null;
    }

    final request = LogoutRequest(token: auth.token);
    final channel = ClientChannel(
      endpoints.apiHost,
      port: endpoints.apiPort,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    final response = await SessionServiceClient(channel).logout(request);
    if (response.success) {
      await removeAuth();
      await removeSessionUser();
      await savePreviouslySynced(false);
      await LocalStorage.clearMnstrs();
      state = null;
      return null;
    }
    return "There was an error logging out";
  }

  void setAuth(Auth auth) {
    state = auth;
    this.auth = auth;
  }

  Future<void> ensureAuth() async {
    final auth = await getAuth();
    if (auth != null) {
      setAuth(auth);
    }
  }
}

enum AuthKey { auth, user }

Future<void> saveAuth(Auth auth) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(AuthKey.auth.name, jsonEncode(auth.toJson()));
}

Future<Auth?> getAuth() async {
  final prefs = await SharedPreferences.getInstance();
  final auth = prefs.getString(AuthKey.auth.name);
  return auth != null ? Auth.fromJson(jsonDecode(auth)) : null;
}

Future<void> removeAuth() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(AuthKey.auth.name);
}
