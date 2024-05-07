import 'package:dev_play_tictactoe/src/models/app_data_fake.dart';
import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PlayerList Testing:', () {
    late Widget widgetToTest;
    late Widget wrappedWidget;

    ///
    /// [ PlayerList Widget ]
    ///

    group('PlayerList Widget', () {
      setUp(() async {
        widgetToTest = const PlayerList();
        wrappedWidget = PumpApp.materialApp(widgetToTest);
      });

      testWidgets('[PlayerList Widget] renders.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);
        final widgetFinderBoard = find.byType(PlayerList);
        expect(widgetFinderBoard, findsOneWidget);
      });

      testWidgets(
          '[PlayerList Widget] has [DropdownMenu] '
          'and correct [DropdownMenuEntry] labels.', (
        WidgetTester tester,
      ) async {
        /// @TODO: This will change to be a `when` stub when bloc is implemented.
        final playerList = AppDataFake.fakePlayerList3;

        await tester.pumpWidget(wrappedWidget);
        final widgetFinderDropdownMenuEntry = find.byType(DropdownMenu<int>);
        expect(widgetFinderDropdownMenuEntry, findsOneWidget);

        final labelFinderFirst = find.descendant(
          of: widgetFinderDropdownMenuEntry,
          matching: find.text(playerList.first.playerName),
        );
        expect(labelFinderFirst, findsOneWidget);

        final labelFinderLast = find.descendant(
          of: widgetFinderDropdownMenuEntry,
          matching: find.text(playerList.last.playerName),
        );
        expect(labelFinderLast, findsOneWidget);
      });
    });
  });
}
