import 'package:dev_play_tictactoe/src/screens/game_play/game_play.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('GamePlay GamePanel Tile Testing:', () {
    late Widget widgetToTest;
    late Widget wrappedWidget;

    ///
    /// [ GamePanel Tile ]
    ///

    group('GamePanel Tile', () {
      //
      const int index = 5;

      setUp(() async {
        widgetToTest = const GameBoardPanelTile(index);
        wrappedWidget = PumpApp.materialApp(widgetToTest);
      });

      testWidgets('[GamePanel Tile] renders by default.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);
        final widgetFinderBoard = find.byType(GameBoardPanelTile);
        expect(widgetFinderBoard, findsOneWidget);
      });

      testWidgets('[GameBoardPanelTile] displays correct index', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);
        final textFinder = find.text('$index');
        expect(textFinder, findsOneWidget);
      });

      testWidgets('[GameBoardPanelTile] has correct decoration', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);
        final decoratedBoxFinder = find.byType(DecoratedBox);
        expect(decoratedBoxFinder, findsOneWidget);
      });
    });
  });
}
