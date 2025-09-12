import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:mnstrv2/utils/graphql.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/endpoints.dart' as endpoints;
import '../models/user.dart';

part 'session_users.g.dart';

final sessionUserProvider = AsyncNotifierProvider<SessionUserNotifier, User?>(
  () => SessionUserNotifier(),
);

@JsonSerializable()
class RegistrationRequest {
  final String qrCode;
  final String displayName;
  final String email;
  final String password;

  RegistrationRequest({
    required this.qrCode,
    required this.displayName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$RegistrationRequestToJson(this);
}

@JsonSerializable()
class RegistrationResponse {
  String? error;
  User? user;

  RegistrationResponse({this.error, this.user});

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) =>
      _$RegistrationResponseFromJson(json);
}

@JsonSerializable()
class UserResponse {
  String? error;
  User? user;

  UserResponse({this.error, this.user});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}

class SessionUserNotifier extends AsyncNotifier<User?> {
  User? user;

  SessionUserNotifier({this.user});

  @override
  Future<User?> build() async {
    return user;
  }

  Future<String?> register(RegistrationRequest request) async {
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
      'email': request.email,
      'password': request.password,
      'displayName': request.displayName,
      'qrCode': request.qrCode,
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

  Future<void> refresh() async {
    // TODO: Implement refresh
    // final user = await getSessionUser();
    // final response = await http.get(
    //   Uri.parse('${endpoints.users}/${user?.id}'),
    // );

    // final body = jsonDecode(response.body);
    // final requestResponse = UserResponse.fromJson(body);

    // if (response.statusCode == HttpStatus.ok) {
    //   state = AsyncData(requestResponse.user);
    // } else {
    //   state = AsyncError(
    //     Exception('Failed to refresh user: ${requestResponse.error}'),
    //     StackTrace.current,
    //   );
    // }
  }
}

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
