import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:riverpod/riverpod.dart';

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
  @override
  Future<User?> build() async {
    return null;
  }

  Future<void> register(RegistrationRequest request) async {
    final response = await http.post(
      Uri.parse(endpoints.register),
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
}
