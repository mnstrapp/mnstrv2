import 'dart:convert';

import 'package:mnstrv2/utils/graphql.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/endpoints.dart' as endpoints;
import '../models/user.dart';
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
    final document = r'''
mutation register(
  $email: String!,
  $password: String!,
  $displayName: String!,
) {
  users {
    register(
      email: $email,
      password: $password,
      displayName: $displayName,
    ) {
      id
      displayName
      email
      experienceLevel
      experiencePoints
      experienceToNextLevel
      coins
    }
  }
}
''';

    final variables = {
      'email': email,
      'password': password,
      'displayName': displayName,
    };

    try {
      final response = await graphql(
        url: endpoints.baseUrl,
        query: document,
        variables: variables,
      );

      if (response['errors'] != null) {
        return "There was an error registering the user";
      }
      final user = User.fromJson(response['data']['users']['register']);

      state = user;
      return null;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return "There was an error registering the user";
    }
  }

  Future<String?> verifyEmail({
    required String id,
    required String code,
  }) async {
    final document = r'''
mutation verifyEmail($id: String!, $code: String!) {
  users {
    verifyEmail(id: $id, code: $code)
  }
}
''';

    final variables = {'id': id, 'code': code};

    try {
      final response = await graphql(
        url: endpoints.baseUrl,
        query: document,
        variables: variables,
      );

      if (response['errors'] != null) {
        return "There was an error verifying the email";
      }

      if (response['data']['users']['verifyEmail'] != true) {
        return "There was an error verifying the email";
      }

      return null;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
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

    final document = r'''
{
  users {
    my {
      id
      email
      displayName
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
        return "There was an error refreshing the user";
      }

      final user = User.fromJson(response['data']['users']['my']);
      state = user;
      await saveSessionUser(user);

      return null;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return "There was an error refreshing the user";
    }
  }
}

class ForgotPasswordNotifier extends Notifier<String?> {
  @override
  String? build() {
    return null;
  }

  Future<String?> forgotPassword({required String email}) async {
    final document = r'''
query forgotPassword($email: String!) {
  users {
    forgotPassword(email: $email)
    }
}
''';

    final variables = {'email': email};

    try {
      final response = await graphql(
        url: endpoints.baseUrl,
        query: document,
        variables: variables,
      );

      if (response['errors'] != null) {
        return "There was an error resetting the password";
      }

      state = response['data']['users']['forgotPassword'];
      return null;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return "There was an error resetting the password";
    }
  }

  Future<String?> verifyCode({required String code}) async {
    final userId = state;
    if (userId == null) {
      return "There was an error verifying the code";
    }

    final document = r'''
mutation verifyEmail($id: String!, $code: String!) {
  users {
    verifyEmail(id: $id, code: $code)
    }
}
''';

    final variables = {'id': userId, 'code': code};

    try {
      final response = await graphql(
        url: endpoints.baseUrl,
        query: document,
        variables: variables,
      );

      if (response['errors'] != null) {
        return "There was an error verifying the code";
      }

      return null;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return "There was an error verifying the code";
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
        return "There was an error resetting the password";
      }

      state = null;
      return null;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
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
