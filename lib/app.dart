import 'package:flutter/material.dart';
import 'home/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff00f0ff)),
        primaryColor: Color(0xff00f0ff),
        primaryColorLight: Color(0xff7cf7ff),
        primaryColorDark: Color(0xff00c0ff),
        scaffoldBackgroundColor: Color(0xff00f0ff),
        appBarTheme: AppBarTheme(backgroundColor: Color(0xff00f0ff)),
      ),
    );
  }
}
