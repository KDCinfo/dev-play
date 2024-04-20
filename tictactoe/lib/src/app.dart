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

      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,

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
              default:
                return const Center(child: Text('Hello'));
            }
          },
        );
      },
    );
  }
}
