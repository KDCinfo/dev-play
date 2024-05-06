import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

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

      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF800000),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: const Color(0xFF800000),
      ),

      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              // case SettingsView.routeName:
              //   return SettingsView(controller: settingsController);
              // case SampleItemDetailsView.routeName:
              //   return const SampleItemDetailsView();
              // case SampleItemListView.routeName:
              // default:
              //   return const GameEntryScreen();
              default:
                return const GameBoardScreen();
            }
          },
        );
      },
    );
  }
}
