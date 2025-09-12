import 'dart:convert';
import 'dart:developer';
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
class ManageRequest {
  final String qrCode;
  final String name;
  final int currentHealth;
  final int maxHealth;
  final int currentAttack;
  final int maxAttack;
  final int currentDefense;
  final int maxDefense;
  final int currentIntelligence;
  final int maxIntelligence;
  final int currentSpeed;
  final int maxSpeed;
  final int currentMagic;
  final int maxMagic;

  ManageRequest({
    required this.qrCode,
    required this.name,
    required this.currentHealth,
    required this.maxHealth,
    required this.currentAttack,
    required this.maxAttack,
    required this.currentDefense,
    required this.maxDefense,
    required this.currentIntelligence,
    required this.maxIntelligence,
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

  Future<String?> createMonster(Monster monster) async {
    final auth = ref.read(authProvider);
    final request = ManageRequest(
      qrCode: monster.qrCode ?? '',
      name: monster.name ?? '',
      currentHealth: monster.currentHealth ?? 10,
      maxHealth: monster.maxHealth ?? 10,
      currentAttack: monster.currentAttack ?? 10,
      maxAttack: monster.maxAttack ?? 10,
      currentDefense: monster.currentDefense ?? 10,
      maxDefense: monster.maxDefense ?? 10,
      currentIntelligence: monster.currentIntelligence ?? 10,
      maxIntelligence: monster.maxIntelligence ?? 10,
      currentSpeed: monster.currentSpeed ?? 10,
      maxSpeed: monster.maxSpeed ?? 10,
      currentMagic: monster.currentMagic ?? 10,
      maxMagic: monster.maxMagic ?? 10,
    );
    // TODO: Implement createMonster
    // final response = await http.post(
    //   Uri.parse(endpoints.collect),
    //   body: jsonEncode(request.toJson()),
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Authorization': 'Bearer ${auth.value?.token}',
    //   },
    // );
    // final body = jsonDecode(response.body);
    // final manageResponse = ManageResponse.fromJson(body);

    // if (manageResponse.error != null) {
    //   state = AsyncError(
    //     Exception('Failed to save monster: ${manageResponse.error}'),
    //     StackTrace.current,
    //   );
    //   return manageResponse.error;
    // }

    // if (response.statusCode == HttpStatus.ok) {
    //   state = AsyncData(manageResponse.mnstr);
    //   ref.read(sessionUserProvider.notifier).refresh();
    //   return null;
    // }
  }
}
