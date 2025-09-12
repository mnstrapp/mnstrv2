import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable()
class Auth {
  String? id;
  @JsonKey(name: 'session_token')
  String? token;
  @JsonKey(name: 'user_id')
  String? userID;
  @JsonKey(name: 'expires_at')
  DateTime? expiresAt;

  Auth({this.id, this.token, this.userID, this.expiresAt});

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);
  Map<String, dynamic> toJson() => _$AuthToJson(this);
}
