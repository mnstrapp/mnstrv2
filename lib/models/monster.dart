import '../shared/monster_model.dart';

enum Stat { health, attack, defense, speed, magic, intelligence }

class Monster {
  String? id;
  String? userId;
  String? mnstrName;
  String? mnstrDescription;
  String? mnstrQrCode;
  int? currentLevel;
  int? currentExperience;
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
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? archivedAt;
  int? experienceToNextLevel;

  Monster({
    this.id,
    this.userId,
    this.mnstrName,
    this.mnstrDescription,
    this.mnstrQrCode,
    this.currentLevel,
    this.currentExperience,
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
    this.createdAt,
    this.updatedAt,
    this.archivedAt,
    this.experienceToNextLevel,
  });

  factory Monster.fromJson(Map<String, dynamic> json) {
    return Monster(
      id: json['id'],
      userId: json['userId'],
      mnstrName: json['mnstrName'],
      mnstrDescription: json['mnstrDescription'],
      mnstrQrCode: json['mnstrQrCode'],
      currentLevel: json['currentLevel'],
      currentExperience: json['currentExperience'],
      currentHealth: json['currentHealth'],
      maxHealth: json['maxHealth'],
      currentAttack: json['currentAttack'],
      maxAttack: json['maxAttack'],
      currentDefense: json['currentDefense'],
      maxDefense: json['maxDefense'],
      currentIntelligence: json['currentIntelligence'],
      maxIntelligence: json['maxIntelligence'],
      currentSpeed: json['currentSpeed'],
      maxSpeed: json['maxSpeed'],
      currentMagic: json['currentMagic'],
      maxMagic: json['maxMagic'],
      experienceToNextLevel: json['experienceToNextLevel'],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt']),
      archivedAt: json['archivedAt'] == null
          ? null
          : DateTime.parse(json['archivedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'mnstrName': mnstrName,
    'mnstrDescription': mnstrDescription,
    'mnstrQrCode': mnstrQrCode,
    'currentLevel': currentLevel,
    'currentExperience': currentExperience,
    'currentHealth': currentHealth,
    'maxHealth': maxHealth,
    'currentAttack': currentAttack,
    'maxAttack': maxAttack,
    'currentDefense': currentDefense,
    'maxDefense': maxDefense,
    'currentIntelligence': currentIntelligence,
    'maxIntelligence': maxIntelligence,
    'currentSpeed': currentSpeed,
    'maxSpeed': maxSpeed,
    'currentMagic': currentMagic,
    'maxMagic': maxMagic,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'archivedAt': archivedAt?.toIso8601String(),
    'experienceToNextLevel': experienceToNextLevel,
  };

  Monster copyWith({
    String? userId,
    String? mnstrName,
    String? mnstrDescription,
    int? currentLevel,
    int? currentExperience,
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
    int? experienceToNextLevel,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? archivedAt,
  }) => Monster(
    id: id,
    userId: userId ?? this.userId,
    mnstrName: mnstrName ?? this.mnstrName,
    mnstrDescription: mnstrDescription ?? this.mnstrDescription,
    mnstrQrCode: mnstrQrCode,
    currentLevel: currentLevel ?? this.currentLevel,
    currentExperience: currentExperience ?? this.currentExperience,
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
    experienceToNextLevel: experienceToNextLevel ?? this.experienceToNextLevel,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    archivedAt: archivedAt ?? this.archivedAt,
  );

  MonsterModel toMonsterModel() => MonsterModel.fromMonster(this);

  static Monster fromMonsterModel(MonsterModel model) => Monster(
    id: model.id,
    userId: model.userId,
    mnstrName: model.name,
    mnstrQrCode: model.qrCode,
  );
}
