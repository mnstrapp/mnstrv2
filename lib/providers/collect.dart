import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth.dart';
import '../models/monster.dart';
import '../config/endpoints.dart' as endpoints;

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
    } else {
      state = AsyncError(
        Exception('Failed to collect monster: ${collectResponse.error}'),
        StackTrace.current,
      );
    }
  }
}
