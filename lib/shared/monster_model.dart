import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import '../models/monster.dart';

class MonsterModel {
  String? id;
  String? name;
  String? qrCode;
  Color? color;
  int? head;
  int? horns;
  int? arms;
  int? legs;
  int? tail;

  MonsterModel({
    this.id,
    this.name,
    this.qrCode,
    this.color,
    this.head,
    this.horns,
    this.arms,
    this.legs,
    this.tail,
  });

  static MonsterModel fromQRCode(String qrCode) {
    final hash = sha1.convert(utf8.encode(qrCode));
    final parts = hash.bytes;
    final color = Color.fromRGBO(parts[5], parts[10], parts[15], 100);
    final head = parts
        .sublist(0, 1)
        .reduce((value, element) => value + element);
    final horns = parts
        .sublist(2, 6)
        .reduce((value, element) => value + element);
    final arms = parts
        .sublist(7, 8)
        .reduce((value, element) => value + element);
    final legs = parts
        .sublist(9, 10)
        .reduce((value, element) => value + element);
    final tail = parts
        .sublist(11, 15)
        .reduce((value, element) => value + element);

    return MonsterModel(
      qrCode: qrCode,
      color: color,
      head: head % 2,
      horns: horns % 4,
      arms: arms % 2,
      legs: legs % 2,
      tail: tail % 4,
    );
  }

  Map<MonsterPart, Widget?> get monsterParts =>
      MonsterParts(monster: this).monsterParts;

  Monster toMonster() => Monster(id: id, name: name, qrCode: qrCode);

  static MonsterModel fromMonster(Monster monster) {
    try {
      if (monster.qrCode == null) {
        return MonsterModel();
      }
      MonsterModel model = MonsterModel.fromQRCode(monster.qrCode!);
      model.id = monster.id;
      model.name = monster.name;
      return model;
    } catch (e) {
      log('[fromMonster] error: $e');
      return MonsterModel();
    }
  }
}

const scale = 1.7;

class MonsterParts {
  MonsterParts({required this.monster});

  MonsterModel monster;

  Widget get head {
    if (monster.head == 0) {
      return Image.asset(
        'assets/mnstr_parts/head_1.png',
        scale: scale,
        color: monster.color,
        colorBlendMode: BlendMode.srcATop,
      );
    }
    return Image.asset(
      'assets/mnstr_parts/head_2.png',
      scale: scale,
      color: monster.color,
      colorBlendMode: BlendMode.srcATop,
    );
  }

  Widget? get horns {
    switch (monster.horns) {
      case 0:
        return Image.asset(
          'assets/mnstr_parts/horns_short.png',
          scale: scale,
          color: monster.color,
          colorBlendMode: BlendMode.srcATop,
        );
      case 1:
        return Image.asset(
          'assets/mnstr_parts/horns_spiraled.png',
          scale: scale,
          color: monster.color,
          colorBlendMode: BlendMode.srcATop,
        );
      case 2:
        return Image.asset(
          'assets/mnstr_parts/horns_striped.png',
          scale: scale,
          color: monster.color,
          colorBlendMode: BlendMode.srcATop,
        );
    }
    return null;
  }

  Widget get arms {
    if (monster.arms == 0) {
      return Image.asset(
        'assets/mnstr_parts/arms_two.png',
        scale: scale,
        color: monster.color,
        colorBlendMode: BlendMode.srcATop,
      );
    }
    return Image.asset(
      'assets/mnstr_parts/arms_four.png',
      scale: scale,
      color: monster.color,
      colorBlendMode: BlendMode.srcATop,
    );
  }

  Widget get legs {
    if (monster.legs == 0) {
      return Image.asset(
        'assets/mnstr_parts/legs_long.png',
        scale: scale,
        color: monster.color,
        colorBlendMode: BlendMode.srcATop,
      );
    }
    return Image.asset(
      'assets/mnstr_parts/legs_short.png',
      scale: scale,
      color: monster.color,
      colorBlendMode: BlendMode.srcATop,
    );
  }

  Widget? get tail {
    switch (monster.horns) {
      case 0:
        return Image.asset(
          'assets/mnstr_parts/tail_long.png',
          scale: scale,
          color: monster.color,
          colorBlendMode: BlendMode.srcATop,
        );
      case 1:
        return Image.asset(
          'assets/mnstr_parts/tail_twins.png',
          scale: scale,
          color: monster.color,
          colorBlendMode: BlendMode.srcATop,
        );
      case 2:
        return Image.asset(
          'assets/mnstr_parts/tail_stripes.png',
          scale: scale,
          color: monster.color,
          colorBlendMode: BlendMode.srcATop,
        );
    }
    return null;
  }

  Image get body => Image.asset(
    'assets/mnstr_parts/body_base.png',
    scale: scale,
    color: monster.color,
    colorBlendMode: BlendMode.srcATop,
  );

  Map<MonsterPart, Widget?> get monsterParts {
    return {
      MonsterPart.horns: horns,
      MonsterPart.head: head,
      MonsterPart.body: body,
      MonsterPart.arms: arms,
      MonsterPart.legs: legs,
      MonsterPart.tail: tail,
    };
  }
}

enum MonsterPart { horns, head, body, arms, legs, tail }
