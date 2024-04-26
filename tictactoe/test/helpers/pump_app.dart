import 'package:flutter/material.dart';

abstract class PumpApp {
  static Widget materialApp(Widget child) => MaterialApp(
        themeMode: ThemeMode.light,
        theme: ThemeData(
          colorSchemeSeed: const Color(0xFF800000),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorSchemeSeed: const Color(0xFF800000),
        ),
        home: Scaffold(
          body: child,
        ),
      );
}
