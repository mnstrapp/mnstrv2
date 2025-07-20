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

  ManageRequest({required this.name});

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

  Future<void> setName({
    required String name,
    required String monsterId,
  }) async {
    final auth = ref.read(authProvider);
    final response = await http.put(
      Uri.parse('${endpoints.manage}/$monsterId'),
      body: jsonEncode(ManageRequest(name: name).toJson()),
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
        Exception('Failed to set name: ${manageResponse.error}'),
        StackTrace.current,
      );
    }
  }
}
