import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth.dart';
import '../models/user.dart';
import '../utils/graphql.dart';
import 'session_users.dart';
import '../config/endpoints.dart' as endpoints;

part 'auth.g.dart';

final authProvider = AsyncNotifierProvider<AuthNotifier, Auth?>(
  () => AuthNotifier(),
);

@JsonSerializable()
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class LoginResponse {
  String? error;
  @JsonKey(name: 'session')
  Auth? auth;
  @JsonKey(name: 'user')
  User? user;

  LoginResponse({this.error, this.auth});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

class AuthNotifier extends AsyncNotifier<Auth?> {
  Auth? auth;

  AuthNotifier({this.auth});

  @override
  Future<Auth?> build() async {
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
        log('[verify] errors: ${response['errors']}');
        logout();
        return "There was an error verifying the auth";
      }

      return null;
    } catch (e, stackTrace) {
      log('[verify] catch error: $e');
      log('[verify] catch stackTrace: $stackTrace');
      logout();
      return "There was an error verifying the auth";
    }
  }

  Future<void> login(LoginRequest request) async {
    // TODO: Implement login
    // final response = await http.post(
    //   Uri.parse(endpoints.auth),
    //   body: jsonEncode(request.toJson()),
    // );

    // final body = jsonDecode(response.body);
    // final requestResponse = LoginResponse.fromJson(body);

    // if (response.statusCode == HttpStatus.ok) {
    //   state = AsyncData(requestResponse.auth);
    //   ref.read(sessionUserProvider.notifier).setUser(requestResponse.user!);
    //   await saveAuth(requestResponse.auth!);
    //   await saveSessionUser(requestResponse.user!);
    // } else {
    //   state = AsyncError(
    //     Exception('Failed to login: ${requestResponse.error}'),
    //     StackTrace.current,
    //   );
    // }
  }

  Future<void> logout() async {
    await removeAuth();
    await removeSessionUser();
    state = AsyncData(null);
    // TODO: Implement logout
    // await ref.read(sessionUserProvider.notifier).logout();
    // final response = await http.delete(
    //   Uri.parse(endpoints.auth),
    //   headers: {'Authorization': 'Bearer ${auth?.token}'},
    // );

    // if (response.statusCode == HttpStatus.ok) {
    //   state = AsyncData(null);
    // } else {
    //   state = AsyncError(Exception('Failed to logout'), StackTrace.current);
    // }
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
