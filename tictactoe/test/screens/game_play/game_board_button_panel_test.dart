import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/screens/game_play/game_board_button_panel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('[GameBoardButtonPanel] Tests:', () {
    late Widget widgetToTest;
    late Widget wrappedWidget;

    ///
    /// [ GameBoard Button Panel ]
    ///

    const buttonReturn = AppConstants.buttonReturnHome;
    const buttonReturnKey = Key(AppConstants.buttonReturnHomeKey);
    const buttonReturnMsg = AppConstants.buttonReturnHomeMsg;

    group('GameBoard Button Panel', () {
      setUp(() {
        widgetToTest = const GameBoardButtonPanel();
        wrappedWidget = PumpApp.materialApp(widgetToTest);
      });

      testWidgets('[GameBoard Button Panel] renders.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);

        final widgetFinderBoard = find.byType(GameBoardButtonPanel);
        expect(widgetFinderBoard, findsOneWidget);
      });

      testWidgets('[GameBoard Button Panel] should display the correct labels.', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(wrappedWidget);

        expect(find.text(buttonReturn), findsOneWidget);
        expect(find.byKey(buttonReturnKey), findsOneWidget);
        expect(find.text(buttonReturnMsg), findsOneWidget);
      });
    });
  });
}
