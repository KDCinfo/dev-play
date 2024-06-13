import 'package:dev_play_tictactuple/src/data/models/models.dart';
import 'package:dev_play_tictactuple/src/screens/game_board/game_board.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  late Widget Function({required bool isClickable}) widgetToTest;
  late Widget Function({required bool isClickable}) wrappedWidget;

  ///
  /// [ GameBoardPanelTileOverlay ]
  ///

  group('[GameBoardPanelTileOverlay] Testing:', () {
    //
    const index = 5;

    final gameDataWithPlays = GameData(
      players: [
        ...playerList,
      ],
      gameBoardData: const GameBoardData(
        edgeSize: 5,
        plays: [
          PlayerTurn(
            playerTurnId: 1,
            tileIndex: index,
            // A `playerId: 1` is found in `playerList`.
            occupiedById: 1,
          ),
        ],
      ),
    );

    setUp(() {
      widgetToTest = ({required bool isClickable}) => Scaffold(
            body: SizedBox(
              width: 200,
              height: 200,
              child: GameBoardPanelTileOverlay(
                index: index,
                currentGame: isClickable ? const GameData() : gameDataWithPlays,
                isClickableTile: isClickable,
              ),
            ),
          );
      wrappedWidget = ({required bool isClickable}) => PumpApp.materialApp(
            widgetToTest(isClickable: isClickable),
          );
    });

    group('Clickable tile', () {
      testWidgets('renders by default.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget(isClickable: true));

        final widgetFinderBoard = find.byType(GameBoardPanelTileOverlay);
        expect(widgetFinderBoard, findsOneWidget);
      });

      testWidgets('displays no LayoutBuilder or Icon.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget(isClickable: true));

        final widgetFinder = find.byType(LayoutBuilder);
        expect(widgetFinder, findsNothing);

        final iconFinder = find.byType(Icon);
        expect(iconFinder, findsNothing);
      });
    });

    group('non-clickable tile', () {
      testWidgets('displays a LayoutBuilder and an Icon.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget(isClickable: false));

        final widgetFinder = find.byType(LayoutBuilder);
        expect(widgetFinder, findsOneWidget);

        // Should find Icon as descendant of LayoutBuilder.
        final iconFinder = find.descendant(of: widgetFinder, matching: find.byType(Icon));
        expect(iconFinder, findsOneWidget);
      });
    });
  });
}
