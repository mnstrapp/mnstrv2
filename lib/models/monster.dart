import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class Monster {
  String? id;
  String? name;
  Color? color;
  int? head;
  int? horns;
  int? arms;
  int? legs;
  int? tail;

  Monster({
    this.id,
    this.name,
    this.color,
    this.head,
    this.horns,
    this.arms,
    this.legs,
    this.tail,
  });

  static Monster fromQRCode(String qrCode) {
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

    return Monster(
      color: color,
      head: head % 2,
      horns: horns % 4,
      arms: arms % 2,
      legs: legs % 2,
      tail: tail % 4,
    );
  }

  Map<MonsterPart, Image?> get monsterParts =>
      MonsterParts(monster: this).monsterParts;
}

const scale = 1.7;

class MonsterParts {
  MonsterParts({required this.monster});

  Monster monster;

  Image get head {
    if (monster.head == 0) {
      return Image.asset('assets/mnstr_parts/head_1.png', scale: scale);
    }
    return Image.asset('assets/mnstr_parts/head_2.png', scale: scale);
  }

  Image? get horns {
    switch (monster.horns) {
      case 0:
        return Image.asset('assets/mnstr_parts/horns_short.png', scale: scale);
      case 1:
        return Image.asset(
          'assets/mnstr_parts/horns_spiraled.png',
          scale: scale,
        );
      case 2:
        return Image.asset(
          'assets/mnstr_parts/horns_striped.png',
          scale: scale,
        );
    }
    return null;
  }

  Image get arms {
    if (monster.arms == 0) {
      return Image.asset('assets/mnstr_parts/arms_two.png', scale: scale);
    }
    return Image.asset('assets/mnstr_parts/arms_four.png', scale: scale);
  }

  Image get legs {
    if (monster.legs == 0) {
      return Image.asset('assets/mnstr_parts/legs_long.png', scale: scale);
    }
    return Image.asset('assets/mnstr_parts/legs_short.png', scale: scale);
  }

  Image? get tail {
    switch (monster.horns) {
      case 0:
        return Image.asset('assets/mnstr_parts/tail_long.png', scale: scale);
      case 1:
        return Image.asset('assets/mnstr_parts/tail_twins.png', scale: scale);
      case 2:
        return Image.asset('assets/mnstr_parts/tail_stripes.png', scale: scale);
    }
    return null;
  }

  Image get body =>
      Image.asset('assets/mnstr_parts/body_base.png', scale: scale);

  Map<MonsterPart, Image?> get monsterParts {
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
