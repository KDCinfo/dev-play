import 'package:dev_play_tictactoe/src/screens/game_entry/game_entry.dart';
import 'package:dev_play_tictactoe/src/screens/game_widgets/game_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('GameEntryNameListRow Testing:', () {
    late Widget widgetToTest;
    late Widget wrappedWidget;

    ///
    /// [ GameEntryNameListRow Widget ]
    ///

    group('GameEntryNameListRow Widget', () {
      setUp(() async {
        widgetToTest = const GameEntryNameListRow(playerNum: 1);
        wrappedWidget = PumpApp.materialApp(widgetToTest);
      });

      testWidgets('[GameEntryNameListRow Widget] renders.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);
        final widgetFinderBoard = find.byType(GameEntryNameListRow);
        expect(widgetFinderBoard, findsOneWidget);
      });

      /// Note: Deeper individual widget tests are in their own respective test files.

      testWidgets('[GameEntryNameListRow Widget] has a GameEntryNameListRowInputName.', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(wrappedWidget);
        final widgetFinderTitleRow = find.byType(GameEntryNameListRowInputName);
        expect(widgetFinderTitleRow, findsOneWidget);
      });
      testWidgets('[GameEntryNameListRow Widget] has a PlayerList.', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(wrappedWidget);
        final widgetFinderTitleRow = find.byType(PlayerList);
        expect(widgetFinderTitleRow, findsOneWidget);
      });
    });
  });
}
