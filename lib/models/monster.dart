import 'package:json_annotation/json_annotation.dart';
import '../shared/monster_model.dart';

part 'monster.g.dart';

enum Stat { health, attack, defense, speed, magic, intelligence }

@JsonSerializable()
class Monster {
  String? id;
  String? name;
  String? description;
  String? qrCode;
  int? level;
  int? experience;
  int? currentHealth;
  int? maxHealth;
  int? currentAttack;
  int? maxAttack;
  int? currentDefense;
  int? maxDefense;
  int? currentIntelligence;
  int? maxIntelligence;
  int? currentSpeed;
  int? maxSpeed;
  int? currentMagic;
  int? maxMagic;

  Monster({
    this.id,
    this.name,
    this.description,
    this.qrCode,
    this.level,
    this.experience,
    this.currentHealth,
    this.maxHealth,
    this.currentAttack,
    this.maxAttack,
    this.currentDefense,
    this.maxDefense,
    this.currentIntelligence,
    this.maxIntelligence,
    this.currentSpeed,
    this.maxSpeed,
    this.currentMagic,
    this.maxMagic,
  });

  factory Monster.fromJson(Map<String, dynamic> json) =>
      _$MonsterFromJson(json);

  Map<String, dynamic> toJson() => _$MonsterToJson(this);

  Monster copyWith({
    String? name,
    String? description,
    int? level,
    int? experience,
    int? currentHealth,
    int? maxHealth,
    int? currentAttack,
    int? maxAttack,
    int? currentDefense,
    int? maxDefense,
    int? currentIntelligence,
    int? maxIntelligence,
    int? currentSpeed,
    int? maxSpeed,
    int? currentMagic,
    int? maxMagic,
  }) => Monster(
    id: id,
    name: name ?? this.name,
    description: description ?? this.description,
    qrCode: qrCode,
    level: level ?? this.level,
    experience: experience ?? this.experience,
    currentHealth: currentHealth ?? this.currentHealth,
    maxHealth: maxHealth ?? this.maxHealth,
    currentAttack: currentAttack ?? this.currentAttack,
    maxAttack: maxAttack ?? this.maxAttack,
    currentDefense: currentDefense ?? this.currentDefense,
    maxDefense: maxDefense ?? this.maxDefense,
    currentIntelligence: currentIntelligence ?? this.currentIntelligence,
    maxIntelligence: maxIntelligence ?? this.maxIntelligence,
    currentSpeed: currentSpeed ?? this.currentSpeed,
    maxSpeed: maxSpeed ?? this.maxSpeed,
    currentMagic: currentMagic ?? this.currentMagic,
    maxMagic: maxMagic ?? this.maxMagic,
  );

  MonsterModel toMonsterModel() => MonsterModel.fromMonster(this);

  static Monster fromMonsterModel(MonsterModel model) =>
      Monster(id: model.id, name: model.name, qrCode: model.qrCode);
}
