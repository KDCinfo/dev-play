import 'package:dev_play_tictactoe/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactoe/src/data/service_repositories/service_repositories.dart';
import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('GameEntry Testing:', () {
    late Widget widgetToTest;
    late Widget wrappedWidget;
    late ScorebookRepository mockScorebookRepository;
    late GameEntryBloc mockGameEntryBloc;
    late GamePlayBloc mockGamePlayBloc;

    ///
    /// [ GameEntry Screen ]
    ///

    group('GameEntry Screen', () {
      setUp(() async {
        mockScorebookRepository = MockScorebookRepository();
        mockGameEntryBloc = MockGameEntryBloc();
        mockGamePlayBloc = MockGamePlayBloc();

        widgetToTest = const GameEntryScreen();
        wrappedWidget = await PumpApp.providerWrappedMaterialApp(
          scorebookRepository: mockScorebookRepository,
          gameEntryBloc: mockGameEntryBloc,
          gamePlayBloc: mockGamePlayBloc,
          child: widgetToTest,
        );

        when(() => mockGameEntryBloc.state).thenReturn(const GameEntryState());
        when(() => mockGamePlayBloc.state).thenReturn(const GamePlayState());
      });

      group('rendering', () {
        testWidgets('[GameEntry Screen] renders by default.', (WidgetTester tester) async {
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
        testWidgets('[GameEntry Screen] renders portrait.', (WidgetTester tester) async {
          tester.view.devicePixelRatio = 1.0; // Must be set with `physicalSize`.
          tester.view.physicalSize = const Size(299, 599);

          await tester.pumpWidget(wrappedWidget);
          final widgetFinderScreen = find.byType(GameEntryScreen);
          expect(widgetFinderScreen, findsOneWidget);

          addTearDown(tester.view.resetDevicePixelRatio);
          addTearDown(tester.view.resetPhysicalSize);
        });

        testWidgets('[GameEntry Screen] renders landscape.', (WidgetTester tester) async {
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

      testWidgets('[GameEntry Screen] has a title.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);
        final widgetFinderTitleRow = find.byType(GameTitleRow);
        expect(widgetFinderTitleRow, findsOneWidget);
      });
      testWidgets('[GameEntry Screen] has a player list.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);
        final widgetFinderNameList = find.byType(GameEntryNameList);
        expect(widgetFinderNameList, findsOneWidget);
      });
      testWidgets('[GameEntry Screen] has board size controls.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);
        final widgetFinderBoardSize = find.byType(GameEntryBoardSizeRow);
        expect(widgetFinderBoardSize, findsOneWidget);
      });
      testWidgets('[GameEntry Screen] has buttons.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);
        final widgetFinderButtons = find.byType(GameEntryButtonsRow);
        expect(widgetFinderButtons, findsOneWidget);
      });
    });
  });
}
