import 'package:json_annotation/json_annotation.dart';

part 'monster.g.dart';

@JsonSerializable()
class Monster {
  String? id;
  String? name;
  String? description;
  String? qrCode;

  Monster({this.id, this.name, this.description, this.qrCode});

  factory Monster.fromJson(Map<String, dynamic> json) =>
      _$MonsterFromJson(json);

  Map<String, dynamic> toJson() => _$MonsterToJson(this);

  Monster copyWith({String? name, String? description}) => Monster(
    id: id,
    name: name ?? this.name,
    description: description ?? this.description,
    qrCode: qrCode,
  );
}
