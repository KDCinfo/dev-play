import 'package:dev_play_tictactoe/src/screens/game_board/game_board.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('GameBoardPlayerPanel', () {
    late Widget widgetToTest;
    late Widget wrappedWidget;

    ///
    /// [ GameBoard Player Panel ]
    ///

    group('GameBoard Player Panel', () {
      setUp(() {
        widgetToTest = const GameBoardPlayerPanel();
        wrappedWidget = PumpApp.materialApp(widgetToTest);
      });

      testWidgets('[GameBoard Player Panel] renders.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);
        final widgetFinderBoard = find.byType(GameBoardPlayerPanel);
        expect(widgetFinderBoard, findsOneWidget);

        final widgetFinderPanelTitle = find.byType(GameBoardPlayerPanelTitle);
        expect(widgetFinderPanelTitle, findsOneWidget);

        final widgetFinderPanelNames = find.byType(GameBoardPlayerPanelNames);
        expect(widgetFinderPanelNames, findsOneWidget);
      });

      testWidgets('[GameBoard Player Panel] should display the correct player count', (
        WidgetTester tester,
      ) async {
        const playerCount = 2;
        const playerTitle = 'Players: [ $playerCount ]';

        await tester.pumpWidget(wrappedWidget);

        expect(find.text(playerTitle), findsOneWidget);
      });

      testWidgets('[GameBoard Player Panel] should display the correct player names', (
        WidgetTester tester,
      ) async {
        const players = <String>['John', 'Jane'];

        await tester.pumpWidget(wrappedWidget);

        expect(find.text('[ ${players.elementAtOrNull(0) ?? 'Oops'} ]'), findsOneWidget);
        expect(find.text('[ ${players.elementAtOrNull(1) ?? 'Oops'} ]'), findsOneWidget);
      });

      testWidgets('[GameBoard Player Panel] should highlight the current player', (
        WidgetTester tester,
      ) async {
        /// Current player (player 0) should be bold.
        /// @TODO: This is currently hard coded in the `GameBoardPlayerPanelNames` widget.
        const currentPlayer = 0;
        const players = <String>['John', 'Jane'];

        await tester.pumpWidget(wrappedWidget);

        final player1Text = tester.widget<Text>(
          find.text('[ ${players.elementAtOrNull(currentPlayer) ?? 'Oops'} ]'),
        );
        final player2Text = tester.widget<Text>(
          find.text('[ ${players.elementAtOrNull(1) ?? 'Oops'} ]'),
        );

        expect(player1Text.style?.fontWeight, equals(FontWeight.bold));
        expect(player2Text.style?.fontWeight, equals(FontWeight.normal));
      });
    });
  });
}
