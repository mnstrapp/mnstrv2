import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../config/endpoints.dart' as endpoints;
import '../providers/auth.dart';
import '../models/monster.dart';
import '../utils/graphql.dart';

part 'manage.g.dart';

@JsonSerializable()
class ManageResponse {
  final String? error;

  @JsonKey(name: 'mnstrs')
  final List<Monster>? monsters;

  @JsonKey(name: 'mnstr')
  final Monster? monster;

  ManageResponse({this.error, this.monsters, this.monster});

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

  Future<String?> getMonsters() async {
    final auth = ref.read(authProvider);

    if (auth.value == null) {
      return "Invalid login";
    }

    final document = r'''
    query getMonsters {
      mnstrs {
        list {
          id
          name
          description
          qrCode
          currentLevel
          currentExperience
          currentHealth
          maxHealth
          currentAttack
          maxAttack
          currentDefense
          maxDefense
          currentIntelligence
          maxIntelligence
          currentSpeed
          maxSpeed
          currentMagic
          maxMagic
        }
      }
    }
    ''';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${auth.value?.token}',
    };

    try {
      final response = await graphql(
        url: endpoints.baseUrl,
        query: document,
        headers: headers,
      );

      if (response['errors'] != null) {
        return "There was an error getting the monsters";
      }

      final monsters = <Monster>[];
      for (var e in response['data']['mnstrs']['list']) {
        monsters.add(Monster.fromJson(e as Map<String, dynamic>));
      }
      state = AsyncData(monsters);
      return null;
    } catch (e, stackTrace) {
      log('[getMonsters] catch error: $e');
      log('[getMonsters] catch stackTrace: $stackTrace');
      return "There was an error getting the monsters";
    }
  }
}

final manageGetByQRProvider =
    AsyncNotifierProvider<ManageGetByQRNotifier, Monster?>(
      () => ManageGetByQRNotifier(),
    );

class ManageGetByQRNotifier extends AsyncNotifier<Monster?> {
  @override
  Future<Monster?> build() async {
    return null;
  }

  Future<String?> get(String qrCode) async {
    final auth = ref.read(authProvider);

    if (auth.value == null) {
      return "There was an error getting the monster by QR code";
    }

    final document = r'''
    query getMonsterByQRCode($qrCode: String!) {
      mnstrs {
        qrCode(qrCode: $qrCode) {
          id
          name
          description
          qrCode
          currentLevel
          currentExperience
          currentHealth
          maxHealth
          currentAttack
          maxAttack
          currentDefense
          maxDefense
          currentIntelligence
          maxIntelligence
          currentSpeed
          maxSpeed
          currentMagic
          maxMagic
        }
      }
    }
    ''';

    final variables = {'qrCode': qrCode};

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${auth.value?.token}',
    };

    try {
      final response = await graphql(
        url: endpoints.baseUrl,
        query: document,
        variables: variables,
        headers: headers,
      );

      if (response['errors'] != null) {
        return "There was an error getting the monster by QR code";
      }

      if (response['data']['mnstrs']['qrCode'] == null) {
        return "Monster not found";
      }

      final monster = Monster.fromJson(response['data']['mnstrs']['qrCode']);

      state = AsyncData(monster);

      return null;
    } catch (e) {
      return "There was an error getting the monster by QR code";
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
    // TODO: Implement editMonster
    // final auth = ref.read(authProvider);
    // final response = await http.put(
    //   Uri.parse('${endpoints.manage}/${monster.id}'),
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Authorization': 'Bearer ${auth.value?.token}',
    //   },
    //   body: jsonEncode(
    //     ManageEditRequest(
    //       name: monster.name,
    //       description: monster.description,
    //     ).toJson(),
    //   ),
    // );
    // final body = jsonDecode(response.body);
    // final manageResponse = ManageEditResponse.fromJson(body);

    // if (response.statusCode == HttpStatus.ok) {
    //   state = AsyncData(manageResponse.mnstr);
    //   ref.read(manageProvider.notifier).getMonsters();
    //   return manageResponse;
    // } else {
    //   state = AsyncError(
    //     Exception('Failed to edit monster: ${manageResponse.error}'),
    //     StackTrace.current,
    //   );
    //   return manageResponse;
    // }
    throw Exception('Not implemented');
  }
}
