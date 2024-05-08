import 'dart:developer';

import 'package:dev_play_tictactoe/src/app.dart';

import 'package:flutter/material.dart';

  /// Logging will be enabled when not in production.
  const isProd = false;

  final now = DateTime.now();
  if (!isProd) {
    log('App loaded.....: ${now.hour}:${now.minute}:${now.second}.${now.millisecond}');
  }

  WidgetsFlutterBinding.ensureInitialized();

  if (!isProd) {
    log('App initialized: ${now.hour}:${now.minute}:${now.second}.${now.millisecond}');
  }

void main() {
  runApp(const MyApp());
}
