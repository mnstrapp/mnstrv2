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

final manageEditProvider = AsyncNotifierProvider<ManageEditNotifier, Monster?>(
  () => ManageEditNotifier(),
);

@JsonSerializable()
class ManageEditRequest {
  final String? name;
  final String? description;

  ManageEditRequest({this.name, this.description});

  factory ManageEditRequest.fromJson(Map<String, dynamic> json) =>
      _$ManageEditRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ManageEditRequestToJson(this);
}

@JsonSerializable()
class ManageEditResponse {
  final String? error;
  final Monster? mnstr;

  ManageEditResponse({this.error, this.mnstr});

  factory ManageEditResponse.fromJson(Map<String, dynamic> json) =>
      _$ManageEditResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ManageEditResponseToJson(this);
}

class ManageEditNotifier extends AsyncNotifier<Monster?> {
  @override
  Future<Monster?> build() async {
    return null;
  }

  Future<ManageEditResponse> editMonster(Monster monster) async {
    final auth = ref.read(authProvider);
    final response = await http.put(
      Uri.parse('${endpoints.manage}/${monster.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${auth.value?.token}',
      },
      body: jsonEncode(
        ManageEditRequest(
          name: monster.name,
          description: monster.description,
        ).toJson(),
      ),
    );
    final body = jsonDecode(response.body);
    final manageResponse = ManageEditResponse.fromJson(body);

    if (response.statusCode == HttpStatus.ok) {
      state = AsyncData(manageResponse.mnstr);
      ref.read(manageProvider.notifier).getMonsters();
      return manageResponse;
    } else {
      state = AsyncError(
        Exception('Failed to edit monster: ${manageResponse.error}'),
        StackTrace.current,
      );
      return manageResponse;
    }
  }
}
