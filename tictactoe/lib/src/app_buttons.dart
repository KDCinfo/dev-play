import 'dart:developer';

import 'package:dev_play_tictactoe/theme/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppButtons extends StatelessWidget {
  const AppButtons({
    super.key,
  });

  void runTap() {
    log('Tapped');
  }

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
        useMaterial3: true,
        colorScheme: lightColorScheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF800000),
            foregroundColor: const Color(0xFFFFDDDD),
            disabledBackgroundColor: const Color(0xFFFFDDDD),
            disabledForegroundColor: const Color(0xFF800000),
            shadowColor: Colors.brown,
          ),
        ),
      ),

      home: SafeArea(
        child: Scaffold(
          body: Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: const BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(
                            color: Colors.grey,
                            width: 0,
                          ),
                        ),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                runTap();
                              },
                              child: const ButtonUp(),
                            ),
                            const ButtonSpacer(),
                            InkWell(
                              onTap: () {
                                runTap();
                              },
                              child: const ButtonUp(),
                            ),
                            const ButtonSpacer(),
                            InkWell(
                              onTap: () {
                                runTap();
                              },
                              child: const ButtonDown(),
                            ),
                            const ButtonSpacer(),
                            InkWell(
                              onTap: () {
                                runTap();
                              },
                              child: const ButtonDown(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: const BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(
                            color: Colors.grey,
                            width: 0,
                          ),
                        ),
                        // border: Border.all(
                        //   color: Colors.grey,
                        //   width: 1,
                        // ),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                runTap();
                              },
                              child: const ButtonUp(),
                            ),
                            const ButtonSpacer(),
                            InkWell(
                              onTap: () {
                                runTap();
                              },
                              child: const ButtonDown(),
                            ),
                            const ButtonSpacer(),
                            InkWell(
                              onTap: () {
                                runTap();
                              },
                              child: const ButtonDown(),
                            ),
                            const ButtonSpacer(),
                            InkWell(
                              onTap: () {
                                runTap();
                              },
                              child: const ButtonDown(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ElevatedButton(
                    //   onPressed: () {},
                    //   child: const Text('Button'),
                    // ),
                    const SizedBox(height: 16),
                    const Text(
                      'Hello',
                    ),
                    const SizedBox(height: 16),
                    Form(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.appTitle,
                        ),
                        initialValue: 'World',
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
      // onGenerateRoute: (RouteSettings routeSettings) {
      //   return MaterialPageRoute<void>(
      //     settings: routeSettings,
      //     builder: (BuildContext context) {
      //       switch (routeSettings.name) {
      //         // case SettingsView.routeName:
      //         //   return SettingsView(controller: settingsController);
      //         // case SampleItemDetailsView.routeName:
      //         //   return const SampleItemDetailsView();
      //         // case SampleItemListView.routeName:
      //         default:
      //           return SafeArea(
      //             child: Scaffold(
      //               body: Padding(
      //                 padding: const EdgeInsets.all(16),
      //                 child: SingleChildScrollView(
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       const SizedBox(height: 16),
      //                       InkWell(
      //                         onTap: () {
      //                           Navigator.of(context).pushNamed('/settings');
      //                         },
      //                         child: Container(
      //                           padding: const EdgeInsets.all(16),
      //                           decoration: const BoxDecoration(
      //                             borderRadius: BorderRadius.all(
      //                               Radius.circular(10),
      //                             ),
      //                             boxShadow: [
      //                               BoxShadow(
      //                                 color: Colors.blue,
      //                               ),
      //                               BoxShadow(
      //                                 color: Colors.green,
      //                                 spreadRadius: -12.0,
      //                                 blurRadius: 12.0,
      //                               ),
      //                             ],
      //                           ),
      //                           child: const Text('Settings'),
      //                         ),
      //                       ),
      //                       // ElevatedButton(
      //                       //   onPressed: () {},
      //                       //   child: const Text('Button'),
      //                       // ),
      //                       const Text(
      //                         'Hello',
      //                       ),
      //                       const SizedBox(height: 16),
      //                       Form(
      //                         child: TextFormField(
      //                           decoration: InputDecoration(
      //                             labelText: AppLocalizations.of(context)!.appTitle,
      //                           ),
      //                           initialValue: 'World',
      //                         ),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           );
      //       }
      //     },
      //   );
      // },
    );
  }
}

class ButtonUp extends StatelessWidget {
  const ButtonUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF800000).withOpacity(0.5),
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
          ),
          BoxShadow(
            offset: Offset(2.0, 2.0),
            color: Color(0xFF800000),
            spreadRadius: -1.0,
            blurRadius: 4.0,
          ),
        ],
      ),
      child: const Text(
        'Settings',
        style: TextStyle(
          color: Color(0xFFFFDDDD),
        ),
      ),
    );
  }
}

class ButtonDown extends StatelessWidget {
  const ButtonDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.brown,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF400000),
          ),
          BoxShadow(
            offset: Offset(3.0, 3.0),
            color: Color(0xFF800000),
            spreadRadius: -4.0,
            blurRadius: 6.0,
          ),
        ],
      ),
      child: const Text(
        'Settings',
        style: TextStyle(
          color: Color(0xFFFFDDDD),
        ),
      ),
    );
  }
}

class ButtonSpacer extends StatelessWidget {
  const ButtonSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(
          width: 1.5,
          height: 50,
          child: ColoredBox(
            color: Colors.white,
          ),
        ),
        // SizedBox(
        //   width: 1,
        //   height: 50,
        //   child: ColoredBox(
        //     color: Colors.teal,
        //   ),
        // ),
        // SizedBox(
        //   width: 1,
        //   height: 50,
        //   child: ColoredBox(
        //     color: Colors.white,
        //   ),
        // ),
      ],
    );
  }
}
