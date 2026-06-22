import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable()
class Auth {
  String? id;
  @JsonKey(name: 'sessionToken')
  String? token;
  String? userID;

  Auth({this.id, this.token, this.userID});

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);
  Map<String, dynamic> toJson() => _$AuthToJson(this);
}
