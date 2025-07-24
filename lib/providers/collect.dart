import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth.dart';
import '../models/monster.dart';
import '../config/endpoints.dart' as endpoints;
import '../providers/session_users.dart';

part 'collect.g.dart';

final collectProvider = AsyncNotifierProvider<CollectNotifier, Monster?>(
  () => CollectNotifier(),
);

@JsonSerializable()
class CollectRequest {
  final String qrCode;

  CollectRequest({required this.qrCode});

  factory CollectRequest.fromJson(Map<String, dynamic> json) =>
      _$CollectRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CollectRequestToJson(this);
}

@JsonSerializable()
class CollectResponse {
  final String? error;
  final Monster? mnstr;

  CollectResponse({this.error, this.mnstr});

  factory CollectResponse.fromJson(Map<String, dynamic> json) =>
      _$CollectResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CollectResponseToJson(this);
}

@JsonSerializable()
class ManageRequest {
  final String name;
  final int currentHealth;
  final int maxHealth;
  final int currentAttack;
  final int maxAttack;
  final int currentDefense;
  final int maxDefense;
  final int currentSpeed;
  final int maxSpeed;
  final int currentMagic;
  final int maxMagic;

  ManageRequest({
    required this.name,
    required this.currentHealth,
    required this.maxHealth,
    required this.currentAttack,
    required this.maxAttack,
    required this.currentDefense,
    required this.maxDefense,
    required this.currentSpeed,
    required this.maxSpeed,
    required this.currentMagic,
    required this.maxMagic,
  });

  factory ManageRequest.fromJson(Map<String, dynamic> json) =>
      _$ManageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ManageRequestToJson(this);
}

@JsonSerializable()
class ManageResponse {
  final String? error;
  final Monster? mnstr;

  ManageResponse({this.error, this.mnstr});

  factory ManageResponse.fromJson(Map<String, dynamic> json) =>
      _$ManageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ManageResponseToJson(this);
}

class CollectNotifier extends AsyncNotifier<Monster?> {
  @override
  Future<Monster?> build() async {
    return null;
  }

  Future<void> collect(String qrCode) async {
    final auth = ref.read(authProvider);
    final response = await http.post(
      Uri.parse(endpoints.collect),
      body: jsonEncode(CollectRequest(qrCode: qrCode).toJson()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${auth.value?.token}',
      },
    );
    final body = jsonDecode(response.body);
    final collectResponse = CollectResponse.fromJson(body);

    if (response.statusCode == HttpStatus.ok) {
      state = AsyncData(collectResponse.mnstr);
      ref.read(sessionUserProvider.notifier).refresh();
    } else {
      state = AsyncError(
        Exception('Failed to collect monster: ${collectResponse.error}'),
        StackTrace.current,
      );
    }
  }

  Future<void> saveMonster(Monster monster) async {
    final auth = ref.read(authProvider);
    final request = ManageRequest(
      name: monster.name ?? '',
      currentHealth: monster.currentHealth ?? 0,
      maxHealth: monster.maxHealth ?? 0,
      currentAttack: monster.currentAttack ?? 0,
      maxAttack: monster.maxAttack ?? 0,
      currentDefense: monster.currentDefense ?? 0,
      maxDefense: monster.maxDefense ?? 0,
      currentSpeed: monster.currentSpeed ?? 0,
      maxSpeed: monster.maxSpeed ?? 0,
      currentMagic: monster.currentMagic ?? 0,
      maxMagic: monster.maxMagic ?? 0,
    );
    final response = await http.put(
      Uri.parse('${endpoints.manage}/${monster.id}'),
      body: jsonEncode(request.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${auth.value?.token}',
      },
    );
    final body = jsonDecode(response.body);
    final manageResponse = ManageResponse.fromJson(body);

    if (response.statusCode == HttpStatus.ok) {
      state = AsyncData(manageResponse.mnstr);
      ref.read(sessionUserProvider.notifier).refresh();
    } else {
      state = AsyncError(
        Exception('Failed to save monster: ${manageResponse.error}'),
        StackTrace.current,
      );
    }
  }
}
