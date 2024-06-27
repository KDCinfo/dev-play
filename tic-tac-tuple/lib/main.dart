import 'dart:developer';

import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/app_main/app_bootstrap_loader.dart';

import 'package:flutter/material.dart';

Future<void> main() async {
  final now = DateTime.now();
  if (AppConstants.canPrint) {
    log('App loaded.....: ${now.hour}:${now.minute}:${now.second}.${now.millisecond}');
  }

  WidgetsFlutterBinding.ensureInitialized();

  if (AppConstants.canPrint) {
    log('App initialized: ${now.hour}:${now.minute}:${now.second}.${now.millisecond}');
  }

  await const AppBootstrapLoader(
    /// BootParams can be used to add API keys.
    BootParameters(),
  ).start();
}
