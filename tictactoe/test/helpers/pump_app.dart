import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/app_provider_wrapper_bloc.dart';
import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/data/service_repositories/service_repositories.dart';
import 'package:dev_play_tictactuple/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PumpApp {
  static Widget materialAppPopScopeTest(
    Widget child,
    NavigatorObserver? mockObserver,
    GamePlayBloc? gamePlayBloc,
  ) =>
      AppProviderWrapperBloc(
        gamePlayBloc: gamePlayBloc,
        child: MaterialApp(
          themeMode: ThemeMode.light,
          theme: ThemeData(
            colorSchemeSeed: AppConstants.primaryTileColor,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorSchemeSeed: AppConstants.primaryTileColor,
          ),
          navigatorObservers: mockObserver != null ? [mockObserver] : [],
          initialRoute: '/',
          routes: {
            '/': (context) => child,
            '/play': (context) => const GameBoardScreen(),
          },
        ),
      );

  static Widget materialAppScreenTest(
    Widget child,
    NavigatorObserver? mockObserver,
  ) =>
      MaterialApp(
        themeMode: ThemeMode.light,
        theme: ThemeData(
          colorSchemeSeed: AppConstants.primaryTileColor,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorSchemeSeed: AppConstants.primaryTileColor,
        ),
        // home: Scaffold(
        //   body: child,
        // ),
        navigatorObservers: mockObserver != null ? [mockObserver] : [],
        initialRoute: '/',
        routes: {
          '/': (context) => Scaffold(body: child),
          '/play': (context) => const GameBoardScreen(),
        },
      );

  static Widget materialApp(
    Widget child,
  ) =>
      MaterialApp(
        themeMode: ThemeMode.light,
        theme: ThemeData(
          colorSchemeSeed: AppConstants.primaryTileColor,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorSchemeSeed: AppConstants.primaryTileColor,
        ),
        home: Scaffold(
          body: child,
        ),
      );

  /// Passing in the `scorebookRepository` allows tests
  /// to maintain a handle on any mocked dependencies.
  static Future<Widget> providerWrappedMaterialApp({
    required Widget child,
    required ScorebookRepository scorebookRepository,
    GameEntryBloc? gameEntryBloc,
    GamePlayBloc? gamePlayBloc,
    NavigatorObserver? mockObserver,
  }) async {
    final repositories = [
      RepositoryTypeWrapper<ScorebookRepository>(
        repository: scorebookRepository,
      ),
    ];

    return MultiRepositoryProvider(
      providers: [
        for (final repositoryWrapper in repositories)
          RepositoryProvider.value(
            value: repositoryWrapper.repository,
          ),
      ],
      child: Builder(
        builder: (context) {
          return AppProviderWrapperBloc(
            gameEntryBloc: gameEntryBloc,
            gamePlayBloc: gamePlayBloc,
            child: mockObserver != null
                ? materialAppScreenTest(
                    Builder(
                      builder: (context) {
                        return child;
                      },
                    ),
                    mockObserver,
                  )
                : materialApp(
                    Builder(
                      builder: (context) {
                        return child;
                      },
                    ),
                  ),
          );
        },
      ),
    );
  }

  static Future<Widget> providerWrappedWithNoMaterialApp({
    required Widget child,
    required ScorebookRepository scorebookRepository,
    GameEntryBloc? gameEntryBloc,
    GamePlayBloc? gamePlayBloc,
  }) async {
    final repositories = [
      RepositoryTypeWrapper<ScorebookRepository>(
        repository: scorebookRepository,
      ),
    ];

    return MultiRepositoryProvider(
      providers: [
        for (final repositoryWrapper in repositories)
          RepositoryProvider.value(
            value: repositoryWrapper.repository,
          ),
      ],
      child: Builder(
        builder: (context) {
          return AppProviderWrapperBloc(
            gameEntryBloc: gameEntryBloc,
            gamePlayBloc: gamePlayBloc,
            child: child,
          );
        },
      ),
    );
  }

  static Future<Widget> providerWrappedInternal({
    required Widget child,
    required WaitForBotBloc waitForBotBloc,
  }) async {
    return BlocProvider(
      create: (context) => waitForBotBloc,
      child: child,
    );
  }
}

/*
  /// @TODO: Set up a helper class to test different (or all) screen sizes.
  ///        Widget testing should have a wrapper around all tests (e.g. a custom PumpWidget)
  ///        that allows for a configuration to be passed in that can set and run all tests
  ///        based on various emulator sizes with varying DPRs/DPIs.

  /// Food for thought:
  /// - https://dev.to/dariodigregorio/mastering-responsive-uis-in-flutter-the-full-guide-3g6i#testing
  /// - https://dev.to/dariodigregorio/mastering-responsive-uis-in-flutter-the-full-guide-3g6i#screenbased-breakpoints

  testWidgets('[GameEntry Screen] renders.', (WidgetTester tester) async {
    ///
    /// # Device Pixel Ratio
    ///
    /// This should be set if overriding `physicalSize`.
    ///
    tester.view.devicePixelRatio = 1.0;
    // tester.view.devicePixelRatio = 2.0;
    // tester.view.devicePixelRatio = 3.0; // Default: `flutter_test`
    // tester.binding.window.devicePixelRatioTestValue = 1.0; // Old

    /// # Canvas Size
    ///
    /// Default Canvas Size: 800 x 600
    ///
    /// @NOTE: When overriding the `physicalSize`,
    ///        the `devicePixelRatio` must also be overridden.
    ///
    /// If you do not override `physicalSize`,
    ///   the framework uses logical pixels directly for layout calculations
    ///   (assuming an environment that matches typical application development scenarios).
    /// When you do not set the physical size,
    ///   Flutter doesn't need to convert between physical and logical pixels
    ///   using the DPR because it operates directly in logical pixels.
    ///
    tester.view.physicalSize = const Size(299, 599);
    // tester.view.physicalSize = const Size(599, 299);
    // tester.binding.window.physicalSizeTestValue = Size(320, 350); // Old

    /// # Resets
    ///
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    // addTearDown(tester.binding.window.clearPhysicalSizeTestValue); // Old

    await tester.pumpWidget(wrappedWidget);

    // debugDumpApp();

    final widgetFinderScreen = find.byType(GameEntryScreen);
    expect(widgetFinderScreen, findsOneWidget);
  });

  /// Testing a variety of sizes with a default DPR and manual DPR of 1.
  /// These were the dimensions that failed and passed.
  /// This is also what clued me into understanding the default device size
  ///   uses logical pixels by default, but overriding the `physicalSize`
  ///   requires the DPR to be overridden as well.
  ///
  testWidgets('[GameEntry Screen] renders.', (WidgetTester tester) async {
        // tester.view.devicePixelRatio = 1.0;
        // tester.view.physicalSize = const Size(599, 299); // 199.66 99.66
        // tester.view.physicalSize = const Size(699, 399); // 233 133
        // tester.view.physicalSize = const Size(799, 499); // 256.33 156.33
        // tester.view.physicalSize = const Size(899, 599); // 299.66 199.66
        // tester.view.physicalSize = const Size(999, 699); // 333 233
        // tester.view.physicalSize = const Size(1099, 699); // 366.33 233
        // tester.view.physicalSize = const Size(1199, 699); // 399.66 233 // 32 over
        // tester.view.physicalSize = const Size(1259, 699); // 419.66 233 // 12 over
        // tester.view.physicalSize = const Size(1271, 699); // 423.66 233 // 7.6 over
        // tester.view.physicalSize = const Size(1292, 699); // 430.66 233 // 0.583 over
        // tester.view.physicalSize = const Size(1293, 699); // 431 233 // 0.25 over

        // tester.view.physicalSize = const Size(1294, 299); // 16 over
        // tester.view.physicalSize = const Size(1294, 340); // 2.7 over
        // tester.view.physicalSize = const Size(1294, 342); // 2 over
        // tester.view.physicalSize = const Size(1294, 345); // 1 over
        // tester.view.physicalSize = const Size(1294, 347); // 0.33 over

        // Minimal passing size for DPR 3 vs DPR 1
        // - DPR 3:   1294, 348
        // - DPR 1:    432, 116
        // - Default:  800, 600 <-- 800 600
        tester.view.physicalSize = const Size(800, 600); // Default // 266.66 200
        // tester.view.physicalSize = const Size(1294, 348); // 0 over // DPR 3
        // tester.view.physicalSize = const Size(432, 116); // 0 over  // DPR 1

        // tester.view.physicalSize = const Size(1294, 350); // 0 over

        // tester.view.physicalSize = const Size(1294, 699); // 431.33 233 // 0 over
        // tester.view.physicalSize = const Size(1295, 699); // 431.66 233 // 0 over
        // tester.view.physicalSize = const Size(1298, 699); // 432.66 233 // 0 over
        // tester.view.physicalSize = const Size(1299, 699); // 433 233 // 0 over
        // tester.view.physicalSize = const Size(1200, 600);
  });
*/
