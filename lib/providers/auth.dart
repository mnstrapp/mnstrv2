import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/auth.dart';
import '../models/user.dart';
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
  @override
  Future<Auth?> build() async {
    return null;
  }

  Future<void> login(LoginRequest request) async {
    final response = await http.post(
      Uri.parse(endpoints.auth),
      body: jsonEncode(request.toJson()),
    );

    final body = jsonDecode(response.body);
    final requestResponse = LoginResponse.fromJson(body);

    if (response.statusCode == HttpStatus.ok) {
      state = AsyncData(requestResponse.auth);
    } else {
      state = AsyncError(
        Exception('Failed to login: ${requestResponse.error}'),
        StackTrace.current,
      );
    }
  }
}
