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

  factory Monster.fromDb(Map<String, Object?> data) {
    return Monster(
      id: data['id'] as String?,
      userId: data['user_id'] as String?,
      mnstrName: data['mnstr_name'] as String?,
      mnstrDescription: data['mnstr_description'] as String?,
      mnstrQrCode: data['mnstr_qr_code'] as String?,
      currentLevel: data['current_level'] as int?,
      currentExperience: data['current_experience'] as int?,
      currentHealth: data['current_health'] as int?,
      maxHealth: data['max_health'] as int?,
      currentAttack: data['current_attack'] as int?,
      maxAttack: data['max_attack'] as int?,
      currentDefense: data['current_defense'] as int?,
      maxDefense: data['max_defense'] as int?,
      currentIntelligence: data['current_intelligence'] as int?,
      maxIntelligence: data['max_intelligence'] as int?,
      currentSpeed: data['current_speed'] as int?,
      maxSpeed: data['max_speed'] as int?,
      currentMagic: data['current_magic'] as int?,
      maxMagic: data['max_magic'] as int?,
      experienceToNextLevel: data['experience_to_next_level'] as int?,
      createdAt: data['created_at'] == null
          ? null
          : DateTime.parse(data['created_at'] as String),
      updatedAt: data['updated_at'] == null
          ? null
          : DateTime.parse(data['updated_at'] as String),
      archivedAt: data['archived_at'] == null
          ? null
          : DateTime.parse(data['archived_at'] as String),
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

  Map<String, Object?> toDb() => {
    'id': id,
    'user_id': userId,
    'mnstr_name': mnstrName,
    'mnstr_description': mnstrDescription,
    'mnstr_qr_code': mnstrQrCode,
    'current_level': currentLevel,
    'current_experience': currentExperience,
    'current_health': currentHealth,
    'max_health': maxHealth,
    'current_attack': currentAttack,
    'max_attack': maxAttack,
    'current_defense': currentDefense,
    'max_defense': maxDefense,
    'current_intelligence': currentIntelligence,
    'max_intelligence': maxIntelligence,
    'current_speed': currentSpeed,
    'max_speed': maxSpeed,
    'current_magic': currentMagic,
    'max_magic': maxMagic,
    'experience_to_next_level': experienceToNextLevel,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'archived_at': archivedAt?.toIso8601String(),
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

  static Monster fromSync(Monster sync, Monster local) => Monster(
    id: sync.id,
    userId: local.userId ?? sync.userId,
    mnstrName: local.mnstrName ?? sync.mnstrName,
    mnstrDescription: local.mnstrDescription ?? sync.mnstrDescription,
    mnstrQrCode: local.mnstrQrCode ?? sync.mnstrQrCode,
    currentLevel:
        (local.currentLevel != null &&
            sync.currentLevel != null &&
            local.currentLevel! > sync.currentLevel!)
        ? local.currentLevel
        : sync.currentLevel,
    currentExperience:
        (local.currentExperience != null &&
            sync.currentExperience != null &&
            local.currentExperience! > sync.currentExperience!)
        ? local.currentExperience
        : sync.currentExperience,
    currentHealth:
        (local.currentHealth != null &&
            sync.currentHealth != null &&
            local.currentHealth! > sync.currentHealth!)
        ? local.currentHealth
        : sync.currentHealth,
    maxHealth:
        (local.maxHealth != null &&
            sync.maxHealth != null &&
            local.maxHealth! > sync.maxHealth!)
        ? local.maxHealth
        : sync.maxHealth,
    currentAttack:
        (local.currentAttack != null &&
            sync.currentAttack != null &&
            local.currentAttack! > sync.currentAttack!)
        ? local.currentAttack
        : sync.currentAttack,
    maxAttack:
        (local.maxAttack != null &&
            sync.maxAttack != null &&
            local.maxAttack! > sync.maxAttack!)
        ? local.maxAttack
        : sync.maxAttack,
    currentDefense:
        (local.currentDefense != null &&
            sync.currentDefense != null &&
            local.currentDefense! > sync.currentDefense!)
        ? local.currentDefense
        : sync.currentDefense,
    maxDefense:
        (local.maxDefense != null &&
            sync.maxDefense != null &&
            local.maxDefense! > sync.maxDefense!)
        ? local.maxDefense
        : sync.maxDefense,
    currentIntelligence:
        (local.currentIntelligence != null &&
            sync.currentIntelligence != null &&
            local.currentIntelligence! > sync.currentIntelligence!)
        ? local.currentIntelligence
        : sync.currentIntelligence,
    maxIntelligence:
        (local.maxIntelligence != null &&
            sync.maxIntelligence != null &&
            local.maxIntelligence! > sync.maxIntelligence!)
        ? local.maxIntelligence
        : sync.maxIntelligence,
    currentSpeed:
        (local.currentSpeed != null &&
            sync.currentSpeed != null &&
            local.currentSpeed! > sync.currentSpeed!)
        ? local.currentSpeed
        : sync.currentSpeed,
    maxSpeed:
        (local.maxSpeed != null &&
            sync.maxSpeed != null &&
            local.maxSpeed! > sync.maxSpeed!)
        ? local.maxSpeed
        : sync.maxSpeed,
    currentMagic:
        (local.currentMagic != null &&
            sync.currentMagic != null &&
            local.currentMagic! > sync.currentMagic!)
        ? local.currentMagic
        : sync.currentMagic,
    maxMagic:
        (local.maxMagic != null &&
            sync.maxMagic != null &&
            local.maxMagic! > sync.maxMagic!)
        ? local.maxMagic
        : sync.maxMagic,
    experienceToNextLevel:
        local.experienceToNextLevel ?? sync.experienceToNextLevel,
    createdAt: local.createdAt!.isAfter(sync.createdAt!)
        ? local.createdAt
        : sync.createdAt,
    updatedAt: local.updatedAt!.isAfter(sync.updatedAt!)
        ? local.updatedAt
        : sync.updatedAt,
    archivedAt: local.archivedAt ?? sync.archivedAt,
  );
}
