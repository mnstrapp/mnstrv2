import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth.dart';
import '../models/user.dart';
import '../utils/graphql.dart';
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

  Future<String?> verify(Auth auth) async {
    final document = r'''
{
  session {
    verify {
      id
    }
  }
}
''';

    final variables = {'token': auth.token};

    try {
      final response = await graphql(
        url: endpoints.baseUrl,
        query: document,
        variables: variables,
      );

      if (response['errors'] != null) {
        logout();
        return "There was an error verifying the auth";
      }

      return null;
    } catch (e, stackTrace) {
      logout();
      Sentry.captureException(e, stackTrace: stackTrace);
      return "There was an error verifying the auth";
    }
  }

  Future<String?> login(String email, String password) async {
    final document = r'''
mutation login($email: String!, $password:String!) {
  session {
    login(email: $email, password: $password) {
      id
      userId
      sessionToken
      expiresAt
      user {
        id
        email
        displayName
        email
        phone
        experienceLevel
        experiencePoints
        experienceToNextLevel
        coins
      }
    }
  }
}
''';

    final variables = {'email': email, 'password': password};

    try {
      final response = await graphql(
        url: endpoints.baseUrl,
        query: document,
        variables: variables,
      );

      if (response['errors'] != null) {
        debugPrint('[login] Error: ${response['errors']}');
        return "There was an error logging in";
      }

      final auth = Auth.fromJson(response['data']['session']['login']);
      final user = User.fromJson(response['data']['session']['login']['user']);

      state = auth;
      ref.read(sessionUserProvider.notifier).setUser(user);
      await saveAuth(auth);
      await saveSessionUser(user);

      return null;
    } catch (e, stackTrace) {
      debugPrint('[login] Error: $e');
      Sentry.captureException(e, stackTrace: stackTrace);
      return "There was an error logging in";
    }
  }

  Future<String?> logout() async {
    final auth = await getAuth();

    await removeAuth();
    await removeSessionUser();
    state = null;

    if (auth == null) {
      return null;
    }

    final document = r'''
mutation logout {
  session {
    logout
  }
}
''';

    try {
      final response = await graphql(
        url: endpoints.baseUrl,
        query: document,
        headers: {'Authorization': 'Bearer ${auth.token}'},
      );

      if (response['errors'] != null) {
        return "There was an error logging out";
      }

      return null;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return "There was an error logging out";
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
