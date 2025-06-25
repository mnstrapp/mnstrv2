import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/endpoints.dart' as endpoints;
import '../models/user.dart';

part 'users.g.dart';

final userProvider = AsyncNotifierProvider<UserNotifier, User?>(
  () => UserNotifier(),
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

class UserNotifier extends AsyncNotifier<User?> {
  User? user;

  UserNotifier({this.user});

  @override
  Future<User?> build() async {
    return user;
  }

  Future<void> register(RegistrationRequest request) async {
    final response = await http.post(
      Uri.parse(endpoints.users),
      body: jsonEncode(request.toJson()),
    );

    final body = jsonDecode(response.body);
    final requestResponse = RegistrationResponse.fromJson(body);

    if (response.statusCode == HttpStatus.ok) {
      state = AsyncData(requestResponse.user);
    } else {
      state = AsyncError(
        Exception('Failed to register user: ${requestResponse.error}'),
        StackTrace.current,
      );
    }
  }

  void setUser(User user) {
    state = AsyncData(user);
  }

  Future<void> logout() async {
    await removeUser();
    state = AsyncData(null);
  }
}

enum UserKey { user }

Future<void> saveUser(User user) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(UserKey.user.name, jsonEncode(user.toJson()));
}

Future<User?> getUser() async {
  final prefs = await SharedPreferences.getInstance();
  final user = prefs.getString(UserKey.user.name);
  return user != null ? User.fromJson(jsonDecode(user)) : null;
}

Future<void> removeUser() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(UserKey.user.name);
}
