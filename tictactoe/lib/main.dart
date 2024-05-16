import 'dart:developer';

import 'package:base_services/base_services.dart';

import 'package:dev_play_tictactoe/src/app.dart';
import 'package:dev_play_tictactoe/src/data/data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
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

  /// APIs
  ///
  final sharedPrefsApi = await SharedPrefsApi.init();
  final secureStorageApi = FlutterSecureStorageApi();

  /// Services and Repositories
  ///
  final storageApi = StorageServiceImpl(
    localStorageApi: sharedPrefsApi,
    localSecureStorageApi: secureStorageApi,
    canPrint: !isProd,
  );

  final scorebookRepository = ScorebookRepository(
    storageService: storageApi,
  );

  runApp(
    RepositoryProvider.value(
      value: scorebookRepository,
      child: const MyApp(),
    ),
  );
}
