import 'package:json_annotation/json_annotation.dart';

import '../proto/users.pb.dart' as proto;

part 'user.g.dart';

@JsonSerializable()
class User {
  String? id;
  String? displayName;
  String? email;
  String? phone;
  int? experienceLevel;
  int? experiencePoints;
  int? experienceToNextLevel;
  int? coins;

  User({
    this.id,
    this.displayName,
    this.email,
    this.phone,
    this.experienceLevel,
    this.experiencePoints,
    this.experienceToNextLevel,
    this.coins,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromProto(proto.User user) => User(
    id: user.id,
    displayName: user.displayName,
    email: user.email,
    phone: user.phone,
    experienceLevel: user.experienceLevel,
    experiencePoints: user.experiencePoints,
    experienceToNextLevel: user.experienceToNextLevel,
    coins: user.coins,
  );
}
