import 'package:dev_play_tictactuple/src/screens/game_board/game_board.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  late Widget widgetToTest;
  late Widget wrappedWidget;

  ///
  /// [ GamePanel Tile ]
  ///

  group('[GameBoardPanelTile] Testing:', () {
    //
    const index = 5;

    setUp(() {
      widgetToTest = const GameBoardPanelTile(index);
      wrappedWidget = PumpApp.materialApp(widgetToTest);
    });

    testWidgets('renders by default.', (WidgetTester tester) async {
      await tester.pumpWidget(wrappedWidget);
      final widgetFinderBoard = find.byType(GameBoardPanelTile);
      expect(widgetFinderBoard, findsOneWidget);
    });

    testWidgets('has correct decoration', (WidgetTester tester) async {
      await tester.pumpWidget(wrappedWidget);
      final decoratedBoxFinder = find.byType(DecoratedBox);
      expect(decoratedBoxFinder, findsOneWidget);
    });
  });
}
