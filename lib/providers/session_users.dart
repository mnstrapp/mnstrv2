import 'dart:convert';
import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';
import 'package:mnstrv2/utils/graphql.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/endpoints.dart' as endpoints;
import '../models/user.dart';
import 'auth.dart';

final sessionUserProvider = AsyncNotifierProvider<SessionUserNotifier, User?>(
  () => SessionUserNotifier(),
);

class SessionUserNotifier extends AsyncNotifier<User?> {
  User? user;

  SessionUserNotifier({this.user});

  @override
  Future<User?> build() async {
    return user;
  }

  Future<String?> register({
    required String email,
    required String password,
    required String displayName,
    required String qrCode,
  }) async {
    final document = r'''
mutation register(
  $email: String!,
  $password: String!,
  $displayName: String!,
  $qrCode: String!
) {
  users {
    register(
      email: $email,
      password: $password,
      displayName: $displayName,
      qrCode: $qrCode
    ) {
      id
      displayName
    }
  }
}
''';

    final variables = {
      'email': email,
      'password': password,
      'displayName': displayName,
      'qrCode': qrCode,
    };

    try {
      final response = await graphql(
        url: endpoints.baseUrl,
        query: document,
        variables: variables,
      );

      if (response['errors'] != null) {
        log('[register] errors: ${response['errors']}');
        return "There was an error registering the user";
      }

      return null;
    } catch (e, stackTrace) {
      log('[register] catch error: $e');
      log('[register] catch stackTrace: $stackTrace');
      return "There was an error registering the user";
    }
  }

  void setUser(User user) {
    state = AsyncData(user);
  }

  Future<void> logout() async {
    await removeSessionUser();
    state = AsyncData(null);
  }

  Future<String?> refresh() async {
    final auth = await getAuth();

    if (auth == null) {
      return "There was an error refreshing the user";
    }

    final document = r'''
{
  users {
    my {
      id
      email
      displayName
      qrCode
      experienceLevel
      experiencePoints
      experienceToNextLevel
      coins
    }
  }
}
''';

    final headers = {'Authorization': 'Bearer ${auth.token}'};

    try {
      final response = await graphql(
        url: endpoints.baseUrl,
        query: document,
        headers: headers,
      );

      if (response['errors'] != null) {
        log('[refresh] errors: ${response['errors']}');
        return "There was an error refreshing the user";
      }

      final user = User.fromJson(response['data']['users']['my']);
      state = AsyncData(user);
      await saveSessionUser(user);

      return null;
    } catch (e, stackTrace) {
      log('[refresh] catch error: $e');
      log('[refresh] catch stackTrace: $stackTrace');
      return "There was an error refreshing the user";
    }
  }
}

class ForgotPasswordNotifier extends Notifier<String?> {
  @override
  String? build() {
    return null;
  }

  Future<String?> forgotPassword({
    required String email,
    required String qrCode,
  }) async {
    final document = r'''
query forgotPassword($email: String!, $qrCode: String!) {
  users {
    forgotPassword(email: $email, qrCode: $qrCode)
    }
}
''';

    final variables = {'email': email, 'qrCode': qrCode};

    try {
      final response = await graphql(
        url: endpoints.baseUrl,
        query: document,
        variables: variables,
      );

      if (response['errors'] != null) {
        log('[forgotPassword] errors: ${response['errors']}');
        return "There was an error resetting the password";
      }

      state = response['data']['users']['forgotPassword'];
      return null;
    } catch (e, stackTrace) {
      log('[forgotPassword] catch error: $e');
      log('[forgotPassword] catch stackTrace: $stackTrace');
      return "There was an error resetting the password";
    }
  }

  Future<String?> resetPassword({required String password}) async {
    final id = state;
    final document = r'''
mutation resetPassword($id: String!, $password: String!) {
  users {
    resetPassword(id: $id, password: $password)
    }
}
''';

    final variables = {'id': id, 'password': password};

    try {
      final response = await graphql(
        url: endpoints.baseUrl,
        query: document,
        variables: variables,
      );

      if (response['errors'] != null) {
        log('[resetPassword] errors: ${response['errors']}');
        return "There was an error resetting the password";
      }

      state = null;
      return null;
    } catch (e, stackTrace) {
      log('[resetPassword] catch error: $e');
      log('[resetPassword] catch stackTrace: $stackTrace');
      return "There was an error resetting the password";
    }
  }
}

final forgotPasswordProvider =
    NotifierProvider<ForgotPasswordNotifier, String?>(
      () => ForgotPasswordNotifier(),
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
