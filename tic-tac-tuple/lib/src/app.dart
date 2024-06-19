import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
      ],
      // The appTitle is defined in .arb files found in the localization directory.
      onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,

      // themeMode: ThemeMode.system,
      theme: ThemeData(
        colorSchemeSeed: AppConstants.primaryTileColor,
        textTheme: TextTheme(
          headlineSmall: AppConstants.headlineSmallTextStyle,
          headlineMedium: AppConstants.headlineMediumTextStyle,
          headlineLarge: AppConstants.headlineLargeTextStyle,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: AppConstants.primaryTileColor,
        textTheme: TextTheme(
          headlineSmall: AppConstants.headlineSmallTextStyle,
          headlineMedium: AppConstants.headlineMediumTextStyle,
          headlineLarge: AppConstants.headlineLargeTextStyle,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const GameEntryScreen(),
        '/play': (context) => const GameBoardScreen(),
      },
    );
  }
}
