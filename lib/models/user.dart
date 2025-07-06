import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String? id;
  String? displayName;
  String? qrCode;
  int? experienceLevel;
  int? experiencePoints;
  int? experienceToNextLevel;

  User({
    this.id,
    this.displayName,
    this.qrCode,
    this.experienceLevel,
    this.experiencePoints,
    this.experienceToNextLevel,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
