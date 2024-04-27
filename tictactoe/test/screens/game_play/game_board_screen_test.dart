import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('GamePlay GameBoard Screen Testing:', () {
    late Widget widgetToTest;
    late Widget wrappedWidget;

    ///
    /// [ GameBoard Screen ]
    ///

    group('GameBoard Screen', () {
      setUp(() async {
        widgetToTest = const GameBoardScreen();
        wrappedWidget = PumpApp.materialApp(widgetToTest);
      });

      testWidgets('[GameBoard Screen] renders.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);
        final widgetFinderBoard = find.byType(GameBoardScreen);
        expect(widgetFinderBoard, findsOneWidget);
      });

      /// Note: Deeper individual widget tests are in their own respective test files.

      testWidgets('[GameBoard Screen] has a title.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);
        final widgetFinderTitleRow = find.byType(GameTitleRow);
        expect(widgetFinderTitleRow, findsOneWidget);
      });
    });
  });
}
