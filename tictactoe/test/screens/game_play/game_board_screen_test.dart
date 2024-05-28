import 'package:dev_play_tictactuple/src/data/models/models.dart';
import 'package:dev_play_tictactuple/src/data/service_repositories/service_repositories.dart';
import 'package:dev_play_tictactuple/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('GamePlay GameBoard Screen Testing:', () {
    late Widget widgetToTest;
    late Widget wrappedWidget;
    late ScorebookRepository mockScorebookRepository;

    ///
    /// [ GameBoard Screen ]
    ///

    group('GameBoard Screen', () {
      setUp(() async {
        mockScorebookRepository = MockScorebookRepository();
        widgetToTest = const GameBoardScreen();
        wrappedWidget = await PumpApp.providerWrappedMaterialApp(
          child: widgetToTest,
          scorebookRepository: mockScorebookRepository,
        );
        when(() => mockScorebookRepository.scorebookDataStream)
            .thenAnswer((_) => Stream.value(const ScorebookData()));
      });

      group('rendering', () {
        testWidgets('[GameBoard Screen] renders by default.', (WidgetTester tester) async {
          await tester.pumpWidget(wrappedWidget);
          final widgetFinderBoard = find.byType(GameBoardScreen);
          expect(widgetFinderBoard, findsOneWidget);
        });

        // Testing for Portrait and Landscape.
        //
        // Minimal passing sizes for DPR 1 vs. DPR 3.
        // tester.view.physicalSize = const Size(432, 116); // 0 over  // DPR 1
        // tester.view.physicalSize = const Size(1294, 348); // 0 over // DPR 3
        // tester.view.physicalSize = const Size(800, 600); // Without DPR: 266.66 200
        //
        testWidgets('[GameBoard Screen] renders portrait.', (WidgetTester tester) async {
          tester.view.devicePixelRatio = 1.0; // Must be set with `physicalSize`.
          tester.view.physicalSize = const Size(299, 599);

          await tester.pumpWidget(wrappedWidget);
          final widgetFinderScreen = find.byType(GameBoardScreen);
          expect(widgetFinderScreen, findsOneWidget);

          addTearDown(tester.view.resetDevicePixelRatio);
          addTearDown(tester.view.resetPhysicalSize);
        });

        testWidgets('[GameBoard Screen] renders landscape.', (WidgetTester tester) async {
          tester.view.devicePixelRatio = 1.0;
          tester.view.physicalSize = const Size(599, 299);

          await tester.pumpWidget(wrappedWidget);
          final widgetFinderScreen = find.byType(GameBoardScreen);
          expect(widgetFinderScreen, findsOneWidget);

          addTearDown(tester.view.resetDevicePixelRatio);
          addTearDown(tester.view.resetPhysicalSize);
        });
      });

      /// Note: Deeper individual widget tests are in their own respective test files.

      group('sub elements:', () {
        testWidgets('[GameBoard Screen] has a title.', (WidgetTester tester) async {
          await tester.pumpWidget(wrappedWidget);
          final widgetFinderTitleRow = find.byType(GameTitleRow);
          expect(widgetFinderTitleRow, findsOneWidget);
        });
        testWidgets('[GameBoard Screen] has a GameBoard Panel.', (WidgetTester tester) async {
          await tester.pumpWidget(wrappedWidget);
          final widgetFinderBoardPanel = find.byType(GameBoardPanel);
          expect(widgetFinderBoardPanel, findsOneWidget);
        });
      });
    });
  });
}
