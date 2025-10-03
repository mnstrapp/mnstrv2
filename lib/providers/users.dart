import 'package:json_annotation/json_annotation.dart';
import 'package:riverpod/riverpod.dart';

import '../config/endpoints.dart';
import '../models/user.dart';
import '../utils/graphql.dart';
import 'auth.dart';

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

  Future<String?> deleteAccount() async {
    final auth = ref.read(authProvider);

    if (auth.value == null) {
      return "There was an error deleting the account";
    }

    final document = r'''
        mutation unregister {
          users {
            unregister
          }
        }
      ''';

    final headers = {
      'Authorization': 'Bearer ${auth.value?.token}',
    };

    try {
      final response = await graphql(
        url: baseUrl,
        query: document,
        headers: headers,
      );

      if (response['data']['users']['unregister']) {
        return null;
      } else {
        return "Failed to delete account";
      }
    } catch (e) {
      return "Failed to delete account";
    }
  }
}
