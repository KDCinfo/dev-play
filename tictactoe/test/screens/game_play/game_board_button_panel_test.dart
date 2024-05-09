import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/screens/game_play/game_board_button_panel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

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

        final widgetFinderBoardButtonPanel = find.byType(GameBoardButtonPanel);
        expect(widgetFinderBoardButtonPanel, findsOneWidget);
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

    // Navigation group
    group('Navigation:', () {
      setUp(() {
        registerFallbackValue(MockRoute());
      });

      testWidgets(
        '[GameBoard Button Panel] should pop.',
        (
          WidgetTester tester,
        ) async {
          await tester.pumpWidget(wrappedWidget);

          final widgetFinderBoardButtonPanel = find.byType(GameBoardButtonPanel);
          expect(widgetFinderBoardButtonPanel, findsOneWidget);

          final buttonFinder = find.descendant(
            of: widgetFinderBoardButtonPanel,
            matching: find.byType(TextButton),
          );
          expect(buttonFinder, findsOneWidget);

          // onPressed: () {
          //   Navigator.pop(context);
          // },
          await tester.tap(buttonFinder);
          await tester.pumpAndSettle();
        },
        // @TODO: Testing this will be done with a mocked Bloc.
        skip: true,
      );
    });
  });
}
