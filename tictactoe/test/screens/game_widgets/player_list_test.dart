import 'dart:developer';

import 'package:dev_play_tictactoe/src/app_constants.dart';
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

    final fakePlayerList = [
      'Player 1',
      AppConstants.playerBotName,
    ];

    group('PlayerList Widget', () {
      setUp(() {
        widgetToTest = PlayerList(
          playerList: fakePlayerList,
          onSelected: (int? value) {
            log('Selected: ${value ?? 'null'}');
          },
        );
        wrappedWidget = PumpApp.materialApp(widgetToTest);
      });

      testWidgets('[PlayerList Widget] renders.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);
        final widgetFinderBoard = find.byType(PlayerList);
        expect(widgetFinderBoard, findsOneWidget);
      });

      testWidgets(
        '[PlayerList Widget] has [DropdownMenu] '
        'and correct [DropdownMenuEntry] labels.',
        (WidgetTester tester) async {
          await tester.pumpWidget(wrappedWidget);
          final widgetFinderDropdownMenuEntry = find.byType(DropdownMenu<int>);
          expect(widgetFinderDropdownMenuEntry, findsOneWidget);

          final labelFinderFirst = find.descendant(
            of: widgetFinderDropdownMenuEntry,
            matching: find.text(fakePlayerList.firstOrNull ?? 'Oops'),
          );
          expect(labelFinderFirst, findsOneWidget);

          final labelFinderLast = find.descendant(
            of: widgetFinderDropdownMenuEntry,
            matching: find.text(fakePlayerList.lastOrNull ?? 'Oops'),
          );
          expect(labelFinderLast, findsOneWidget);
        },
      );

      testWidgets(
        '[PlayerList Widget] onSelected prints the selected value.',
        (WidgetTester tester) async {
          await tester.pumpWidget(wrappedWidget);
          final widgetFinderDropdownMenuEntry = find.byType(DropdownMenu<int>);
          expect(widgetFinderDropdownMenuEntry, findsOneWidget);

          await tester.tap(find.byType(DropdownMenu<int>));
          await tester.pumpAndSettle();
        },
        skip: true,
      );
    });
  });
}
