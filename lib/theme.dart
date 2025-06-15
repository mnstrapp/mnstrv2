import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final baseTheme = ThemeData(useMaterial3: true);

final theme = baseTheme.copyWith(
  colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff00f0ff)),
  textTheme: GoogleFonts.silkscreenTextTheme(baseTheme.textTheme),
  primaryColor: Color(0xff00f0ff),
  primaryColorLight: Color(0xff7cf7ff),
  primaryColorDark: Color(0xff00c0ff),
  scaffoldBackgroundColor: Color(0xff00f0ff),
  appBarTheme: AppBarTheme(backgroundColor: Color(0xff00f0ff)),
);
