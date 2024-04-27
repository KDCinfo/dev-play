import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('GameEntry Testing:', () {
    late Widget widgetToTest;
    late Widget wrappedWidget;

    ///
    /// [ GameEntry Screen ]
    ///

    group('GameEntry Screen', () {
      setUp(() async {
        widgetToTest = const GameEntryScreen();
        wrappedWidget = PumpApp.materialApp(widgetToTest);
      });

      testWidgets('[GameEntry Screen] renders.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);
        final widgetFinderScreen = find.byType(GameEntryScreen);
        expect(widgetFinderScreen, findsOneWidget);
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
