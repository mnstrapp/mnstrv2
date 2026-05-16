import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import '../models/monster.dart';
import '../main.dart';

class MonsterModel {
  String? id;
  String? userId;
  String? name;
  String? qrCode;
  Color? color;
  int? head;
  int? horns;
  int? arms;
  int? legs;
  int? tail;
  double scale;
  bool backside;

  MonsterModel({
    this.id,
    this.userId,
    this.name,
    this.qrCode,
    this.color,
    this.head,
    this.horns,
    this.arms,
    this.legs,
    this.tail,
    this.scale = 1.0,
    this.backside = false,
  });

  static MonsterModel fromQRCode(String qrCode, {double scale = 1.0}) {
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
      scale: scale,
    );
  }

  Map<MonsterPart, Widget?> monsterParts({
    double scale = 1.0,
    required Size size,
    bool backside = false,
  }) => MonsterParts(
    monster: this,
    scale: scale,
    size: size,
    backside: backside,
  ).monsterParts;

  Monster toMonster() =>
      Monster(id: id, userId: userId, mnstrName: name, mnstrQrCode: qrCode);

  static MonsterModel fromMonster(Monster monster, {double scale = 1.0}) {
    try {
      if (monster.mnstrQrCode == null) {
        return MonsterModel();
      }
      MonsterModel model = MonsterModel.fromQRCode(monster.mnstrQrCode!);
      model.id = monster.id;
      model.userId = monster.userId;
      model.name = monster.mnstrName;
      return model;
    } catch (e, stackTrace) {
      debugPrint('fromMonster error: $e, $stackTrace');
      return MonsterModel();
    }
  }
}

class MonsterParts {
  final double scale;
  final Size size;
  final bool backside;

  MonsterParts({
    required this.monster,
    this.scale = 1.0,
    required this.size,
    this.backside = false,
  });

  MonsterModel monster;

  Widget get head {
    final factor = scale / 2;
    final width = size.width * factor;
    final height = size.height * factor;
    final headImage = monster.head == 0
        ? (backside
              ? AssetImage('assets/mnstr_parts/head_1-back.png')
              : AssetImage('assets/mnstr_parts/head_1.png'))
        : (backside
              ? AssetImage('assets/mnstr_parts/head_2-back.png')
              : AssetImage('assets/mnstr_parts/head_2.png'));
    return Image(
      key: UniqueKey(),
      image: headImage,
      width: width,
      height: height,
      color: monster.color,
      colorBlendMode: BlendMode.srcATop,
    );
  }

  Widget? get horns {
    final factor = scale / 2;
    final width = size.width * factor;
    final height = size.height * factor;
    final hornsImage = switch (monster.horns) {
      0 => AssetImage('assets/mnstr_parts/horns_short.png'),
      1 => AssetImage('assets/mnstr_parts/horns_spiraled.png'),
      2 => AssetImage('assets/mnstr_parts/horns_striped.png'),
      _ => AssetImage('assets/mnstr_parts/horns_short.png'),
    };
    return Image(
      key: UniqueKey(),
      image: hornsImage,
      width: width,
      height: height,
      color: monster.color,
      colorBlendMode: BlendMode.srcATop,
    );
  }

  Widget get arms {
    final factor = scale / 2;
    final width = size.width * factor;
    final height = size.height * factor;
    final armsImage = monster.arms == 0
        ? AssetImage('assets/mnstr_parts/arms_two.png')
        : AssetImage('assets/mnstr_parts/arms_four.png');
    return Image(
      key: UniqueKey(),
      image: armsImage,
      width: width,
      height: height,
      color: monster.color,
      colorBlendMode: BlendMode.srcATop,
    );
  }

  Widget get legs {
    final factor = scale / 2;
    final width = size.width * factor;
    final height = size.height * factor;
    final legsImage = monster.legs == 0
        ? AssetImage('assets/mnstr_parts/legs_long.png')
        : AssetImage('assets/mnstr_parts/legs_short.png');
    return Image(
      key: UniqueKey(),
      image: legsImage,
      width: width,
      height: height,
      color: monster.color,
      colorBlendMode: BlendMode.srcATop,
    );
  }

  Widget? get tail {
    final factor = scale / 2;
    final width = size.width * factor;
    final height = size.height * factor;
    final tailImage = monster.tail == 0
        ? AssetImage('assets/mnstr_parts/tail_long.png')
        : monster.tail == 1
        ? AssetImage('assets/mnstr_parts/tail_twins.png')
        : AssetImage('assets/mnstr_parts/tail_stripes.png');
    return Image(
      key: UniqueKey(),
      image: tailImage,
      width: width,
      height: height,
      color: monster.color,
      colorBlendMode: BlendMode.srcATop,
    );
  }

  Widget get body {
    final factor = scale / 2;
    final width = size.width * factor;
    final height = size.height * factor;
    final bodyImage = AssetImage('assets/mnstr_parts/body_base.png');
    return Image(
      key: UniqueKey(),
      image: bodyImage,
      width: width,
      height: height,
      color: monster.color,
      colorBlendMode: BlendMode.srcATop,
    );
  }

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
