import 'package:flutter/material.dart';

Color lightenColor(Color color, [double amount = 0.3]) {
  return HSLColor.fromColor(color)
      .withLightness((HSLColor.fromColor(color).lightness + amount).clamp(0, 1))
      .toColor();
}

Color darkenColor(Color color, [double amount = 0.5]) {
  return HSLColor.fromColor(color)
      .withLightness((HSLColor.fromColor(color).lightness - amount).clamp(0, 1))
      .toColor();
}
