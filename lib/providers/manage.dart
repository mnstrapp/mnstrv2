import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

import '../config/endpoints.dart' as endpoints;
import '../providers/auth.dart';
import '../models/monster.dart';

part 'manage.g.dart';

@JsonSerializable()
class ManageResponse {
  final String? error;

  @JsonKey(name: 'mnstrs')
  final List<Monster>? monsters;

  ManageResponse({this.error, this.monsters});

  factory ManageResponse.fromJson(Map<String, dynamic> json) =>
      _$ManageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ManageResponseToJson(this);
}

final manageProvider = AsyncNotifierProvider<ManageNotifier, List<Monster>>(
  () => ManageNotifier(),
);

class ManageNotifier extends AsyncNotifier<List<Monster>> {
  @override
  Future<List<Monster>> build() async {
    return [];
  }

  Future<void> getMonsters() async {
    final auth = ref.read(authProvider);
    final response = await http.get(
      Uri.parse(endpoints.manage),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${auth.value?.token}',
      },
    );
    final body = jsonDecode(response.body);
    final manageResponse = ManageResponse.fromJson(body);

    if (response.statusCode == HttpStatus.ok) {
      state = AsyncData(manageResponse.monsters ?? []);
    } else {
      state = AsyncError(
        Exception('Failed to get monsters: ${manageResponse.error}'),
        StackTrace.current,
      );
    }
  }
}
