import 'package:bloc_test/bloc_test.dart';

import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';
import 'package:dev_play_tictactuple/src/data/service_repositories/service_repositories.dart';
import 'package:dev_play_tictactuple/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('[GameEntryScreen] Testing:', () {
    late Widget widgetToTest;
    late Widget wrappedWidget;
    late ScorebookRepository mockScorebookRepository;
    late GameEntryBloc mockGameEntryBloc;
    late GamePlayBloc mockGamePlayBloc;
    late NavigatorObserver mockObserver;

    setUpAll(() {
      // Create a dummy instance of `Route<dynamic>` to satisfy the `Navigator`.
      registerFallbackValue(FakeRoute());
    });

    ///
    /// [ GameEntry Screen ]
    ///

    group('setUp for', () {
      setUp(() async {
        mockObserver = MockNavigatorObserver();
        mockScorebookRepository = MockScorebookRepository();
        mockGameEntryBloc = MockGameEntryBloc();
        mockGamePlayBloc = MockGamePlayBloc();

        widgetToTest = const GameEntryScreen();
        wrappedWidget = await PumpApp.providerWrappedMaterialApp(
          scorebookRepository: mockScorebookRepository,
          gameEntryBloc: mockGameEntryBloc,
          gamePlayBloc: mockGamePlayBloc,
          mockObserver: mockObserver,
          child: widgetToTest,
        );

        when(() => mockGameEntryBloc.state).thenReturn(const GameEntryState());
        when(() => mockGamePlayBloc.state).thenReturn(const GamePlayState());
      });

      group('rendering', () {
        testWidgets('by default.', (WidgetTester tester) async {
          await tester.pumpWidget(wrappedWidget);
          final widgetFinderScreen = find.byType(GameEntryScreen);
          expect(widgetFinderScreen, findsOneWidget);
        });

        // Testing for Portrait and Landscape.
        //
        // Minimal passing sizes for DPR 1 vs. DPR 3.
        // tester.view.physicalSize = const Size(432, 116); // 0 over  // DPR 1
        // tester.view.physicalSize = const Size(1294, 348); // 0 over // DPR 3
        // tester.view.physicalSize = const Size(800, 600); // Without DPR: 266.66 200
        //
        testWidgets('for portrait.', (WidgetTester tester) async {
          tester.view.devicePixelRatio = 1.0; // Must be set with `physicalSize`.
          tester.view.physicalSize = const Size(299, 599);

          await tester.pumpWidget(wrappedWidget);
          final widgetFinderScreen = find.byType(GameEntryScreen);
          expect(widgetFinderScreen, findsOneWidget);

          addTearDown(tester.view.resetDevicePixelRatio);
          addTearDown(tester.view.resetPhysicalSize);
        });

        testWidgets('for landscape.', (WidgetTester tester) async {
          tester.view.devicePixelRatio = 1.0;
          tester.view.physicalSize = const Size(599, 299);

          await tester.pumpWidget(wrappedWidget);
          final widgetFinderScreen = find.byType(GameEntryScreen);
          expect(widgetFinderScreen, findsOneWidget);

          addTearDown(tester.view.resetDevicePixelRatio);
          addTearDown(tester.view.resetPhysicalSize);
        });
      });

      /// Note: Deeper individual widget tests are in their own respective test files.

      group('checking widget existence', () {
        testWidgets('for a title.', (WidgetTester tester) async {
          await tester.pumpWidget(wrappedWidget);
          final widgetFinderTitleRow = find.byType(GameTitleRow);
          expect(widgetFinderTitleRow, findsOneWidget);
        });
        testWidgets('for a player list.', (WidgetTester tester) async {
          await tester.pumpWidget(wrappedWidget);
          final widgetFinderNameList = find.byType(GameEntryNameList);
          expect(widgetFinderNameList, findsOneWidget);
        });
        testWidgets('for board size controls.', (WidgetTester tester) async {
          await tester.pumpWidget(wrappedWidget);
          final widgetFinderBoardSize = find.byType(GameEntryBoardSizeRow);
          expect(widgetFinderBoardSize, findsOneWidget);
        });
        testWidgets('for buttons.', (WidgetTester tester) async {
          await tester.pumpWidget(wrappedWidget);
          final widgetFinderButtons = find.byType(GameEntryButtonsRow);
          expect(widgetFinderButtons, findsOneWidget);
        });
      });

      group('checking BlocListener', () {
        testWidgets('for GamePlayBloc.', (WidgetTester tester) async {
          // The `GamePlayBloc` is updated when `GameEntryBloc` starts the game by
          // sending a `GameData` with a `gameId > -1` to the `ScorebookRepository` stream.
          await tester.pumpWidget(wrappedWidget);
          final widgetFinderBlocListener = find.byType(BlocListener<GamePlayBloc, GamePlayState>);
          expect(widgetFinderBlocListener, findsOneWidget);
        });

        testWidgets('calls Navigator.didPush when GamePlayState changes.', (tester) async {
          whenListen(
            mockGamePlayBloc,
            Stream.fromIterable([
              const GamePlayState(),
              const GamePlayState(currentGame: GameData(gameId: 1)),
            ]),
          );
          await tester.pumpWidget(wrappedWidget);
          await tester.pumpAndSettle();

          // Capture the mockObserver call.
          //
          // Explaining `captureAny()`: The method `didPush` has two parameters:
          // 1) the route being pushed, and 2) the route being replaced (if any).
          // This is why you will see a pattern of four entries where the
          // second entry of each pair appears to be `null`, because it’s
          // capturing the second argument (the route being replaced),
          // which is `null` in the case where no previous route is replaced.

          // Verify and capture routes
          final captured = verify(() => mockObserver.didPush(captureAny(), any())).captured;
          final routeNames = captured
              .map<String>(
                (route) =>
                    (route as MaterialPageRoute).settings.name == null ? '' : route.settings.name!,
              )
              .toList();

          // Print routes for debugging
          // routeNames.forEach(print);

          // Assert specific navigation occurred.
          expect(routeNames, contains('/'));
          expect(routeNames, contains('/play'));
        });

        testWidgets('calls Navigator when GamePlayState does not change.', (tester) async {
          whenListen(
            mockGamePlayBloc,
            Stream.fromIterable([
              const GamePlayState(), // currentGame: GameData(gameId: -1)),
              const GamePlayState(), // currentGame: GameData(gameId: -1)),
            ]),
          );
          await tester.pumpWidget(wrappedWidget);
          await tester.pumpAndSettle();

          // Verify and capture routes
          final captured = verify(() => mockObserver.didPush(captureAny(), any())).captured;
          final routeNames = captured
              .map<String>(
                (route) =>
                    (route as MaterialPageRoute).settings.name == null ? '' : route.settings.name!,
              )
              .toList();

          verifyNever(() => mockObserver.didPop(captureAny(), any()));

          // // Print routes for debugging
          // routeNames.forEach(print);

          // Assert specific navigation did not occur.
          expect(routeNames, contains('/'));
          expect(routeNames, isNot(contains('/play')));
        });

        testWidgets('calls Navigator.didPop when gameId is set back to -1.', (tester) async {
          whenListen(
            mockGamePlayBloc,
            Stream.fromIterable([
              // const GamePlayState(), // State pushes '/' by default with: GameData(gameId: -1)),
              const GamePlayState(currentGame: GameData(gameId: 1)), // '/play' is then pushed.
              const GamePlayState(), // GameData(gameId: -1)), // This triggers the pop.
            ]),
          );
          await tester.pumpWidget(wrappedWidget);
          await tester.pumpAndSettle();

          // Verify and capture routes
          final capturedPop = verify(() => mockObserver.didPop(captureAny(), any())).captured;
          final routeNamesPopped = capturedPop
              .map<String>(
                (route) =>
                    (route as MaterialPageRoute).settings.name == null ? '' : route.settings.name!,
              )
              .toList();

          // Print routes for debugging
          // routeNamesPopped.forEach(print);

          // Assert specific navigation did not occur.
          expect(routeNamesPopped, contains('/play'));
        });
      });
    });
  });
}
