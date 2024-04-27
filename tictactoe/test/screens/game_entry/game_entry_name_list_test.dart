import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('GameEntry Testing:', () {
    late Widget widgetToTest;
    late Widget wrappedWidget;

    ///
    /// [ Player Name List ]
    ///

    group('GameEntry Player Name List', () {
      setUp(() async {
        widgetToTest = const GameEntryNameList();
        wrappedWidget = PumpApp.materialApp(widgetToTest);
      });

      testWidgets('[GameEntry Name List] has 1-4 Rows.', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(wrappedWidget);

        final widgetFinderNameList = find.byType(GameEntryNameList);
        expect(widgetFinderNameList, findsOneWidget);

        final widgetFinderNameListRow = find.descendant(
          of: widgetFinderNameList,
          matching: find.byType(GameEntryNameListRow),
        );

        /// @TODO: This will change to '1' when the app is further developed.
        expect(widgetFinderNameListRow, findsNWidgets(4));
      });

      /// For each row:
      ///   Test that there are 3 elements,
      ///   and the 2nd element needs an additional test for Markers.
      /// @TODO: This will require feeding the `GameEntryNameList` an int [1-4]
      ///   and testing the resulting number of rows.
      /// For now we'll just be testing Row #1.

      testWidgets('[GameEntry Name List] [1] has a proper label.', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(wrappedWidget);

        const rowNumber = 1;

        final playerLabel = AppConstants.playerLabel(rowNumber);

        final widgetFinderNameList = find.byType(GameEntryNameList);
        final widgetFinderNameListRow = find.descendant(
          of: widgetFinderNameList,
          matching: find.byType(GameEntryNameListRow).first,
        );
        final widgetFinderNameListLabel = find.descendant(
          of: widgetFinderNameListRow,
          matching: find.byType(Text).first,
        );
        expect(widgetFinderNameListLabel, findsOneWidget);

        final playerLabelWidget = tester.widget(widgetFinderNameListLabel) as Text;
        expect(
          playerLabelWidget,
          isA<Text>().having(
            (t) => t.data,
            'text',
            equals(playerLabel),
          ),
        );
      });

      testWidgets('[GameEntry Name List] [4] has a proper label.', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(wrappedWidget);

        const rowNumber = 4;

        final playerLabel = AppConstants.playerLabel(rowNumber);

        final widgetFinderNameList = find.byType(GameEntryNameList);
        final widgetFinderNameListRow = find.descendant(
          of: widgetFinderNameList,
          matching: find.byType(GameEntryNameListRow).last,
        );
        final widgetFinderNameListLabel = find
            .descendant(
              of: widgetFinderNameListRow,
              matching: find.byType(Text),
            )
            .first;
        expect(
          widgetFinderNameListLabel,
          findsOneWidget,
        );

        final playerLabelWidget = tester.widget(widgetFinderNameListLabel) as Text;
        expect(
          playerLabelWidget,
          isA<Text>().having(
            (t) => t.data,
            'text',
            equals(playerLabel),
          ),
        );
      });

      testWidgets('[GameEntry Name List] [1] has an InputName.', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(wrappedWidget);

        final widgetFinderNameList = find.byType(GameEntryNameList);
        final widgetFinderNameListRow = find.descendant(
          of: widgetFinderNameList,
          matching: find.byType(GameEntryNameListRow).first,
        );
        final widgetFinderNameListInputName = find.descendant(
          of: widgetFinderNameListRow,
          matching: find.byType(GameEntryNameListRowInputName),
        );
        expect(widgetFinderNameListInputName, findsOneWidget);
      });

      testWidgets('[GameEntry Name List] [1] has a PlayerNameList.', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(wrappedWidget);

        final widgetFinderNameList = find.byType(GameEntryNameList);
        final widgetFinderNameListRow = find.descendant(
          of: widgetFinderNameList,
          matching: find.byType(GameEntryNameListRow).first,
        );
        final widgetFinderNameListPlayerNameList = find.descendant(
          of: widgetFinderNameListRow,
          matching: find.byType(GameEntryNameListRowInputName),
        );
        expect(widgetFinderNameListPlayerNameList, findsOneWidget);
      });
    });
  });
}
