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
class UserResponse {
  String? error;
  User? user;

  UserResponse({this.error, this.user});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}

class UserNotifier extends AsyncNotifier<User?> {
  UserNotifier();

  @override
  Future<User?> build() async {
    return null;
  }

  Future<void> getUser(String id) async {
    // TODO: Implement getUser
    // final response = await http.get(Uri.parse('${endpoints.users}/$id'));

    // final body = jsonDecode(response.body);
    // final userResponse = UserResponse.fromJson(body);

    // if (response.statusCode == HttpStatus.ok) {
    //   state = AsyncData(userResponse.user);
    // } else {
    //   state = AsyncError(
    //     Exception('Failed to get user: ${userResponse.error}'),
    //     StackTrace.current,
    //   );
    // }
  }
}
