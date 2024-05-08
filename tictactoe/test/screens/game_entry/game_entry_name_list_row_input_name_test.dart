import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/data/models/models.dart';
import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('GameEntryNameListRowInputName Testing:', () {
    late Widget widgetToTest;
    late Widget wrappedWidget;

    late PlayerData player;

    ///
    /// [ GameEntryNameListRowInputName Widget ]
    ///

    group('GameEntryNameListRowInputName Widget', () {
      setUp(() {
        player = const PlayerData(
          playerNum: 1,
        );

        widgetToTest = GameEntryNameListRowInputName(player: player);
        wrappedWidget = PumpApp.materialApp(widgetToTest);
      });

      testWidgets('[GameEntryNameListRowInputName Widget] renders.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);
        final widgetFinderBoard = find.byType(GameEntryNameListRowInputName);
        expect(widgetFinderBoard, findsOneWidget);
      });

      /// Note: Deeper individual widget tests are in their own respective test files.

      testWidgets(
        '[GameEntryNameListRowInputName Widget] has a TextFormField '
        'with a [player.label] and [hintText].',
        (WidgetTester tester) async {
          await tester.pumpWidget(wrappedWidget);
          final widgetFinderTextFormField = find.byType(TextFormField);
          expect(widgetFinderTextFormField, findsOneWidget);

          // Use specific finders to check for the 'label' and 'hintText'
          // as they are rendered in the UI.
          final labelFinder = find.descendant(
            of: widgetFinderTextFormField,
            matching: find.text(player.label),
          );
          expect(labelFinder, findsOneWidget);

          final hintTextFinder = find.descendant(
            of: widgetFinderTextFormField,
            matching: find.text(AppConstants.playerNameHintText),
          );
          expect(hintTextFinder, findsOneWidget);
        },
      );

      testWidgets('[GameEntryNameListRowInputName Widget] has a MarkerMenu.', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(wrappedWidget);
        final widgetFinderTextFormField = find.byType(TextFormField);
        final widgetFinderMarkerMenu = find.descendant(
          of: widgetFinderTextFormField,
          matching: find.byType(MarkerMenu),
        );
        expect(widgetFinderMarkerMenu, findsOneWidget);
      });
    });
  });
}
