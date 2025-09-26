import 'package:flutter/material.dart';

final baseTheme = ThemeData(useMaterial3: true);
final baseTextTheme = baseTheme.textTheme.apply(fontFamily: 'Silkscreen');

final theme = baseTheme.copyWith(
  colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff00f0ff)),
  textTheme: baseTextTheme,
  primaryColor: Color(0xff00f0ff),
  primaryColorLight: Color(0xff7cf7ff),
  primaryColorDark: Color(0xff00c0ff),
  scaffoldBackgroundColor: Color(0xff00f0ff),
  appBarTheme: AppBarTheme(backgroundColor: Color(0xff00f0ff)),
);

const tabletBreakpoint = 992;
const mobileBreakpoint = 768;
