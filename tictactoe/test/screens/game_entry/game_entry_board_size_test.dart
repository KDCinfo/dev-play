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
    /// [ GameEntry Board Size ]
    ///

    group('GameEntry Board Size', () {
      setUp(() async {
        widgetToTest = const GameEntryBoardSizeRow();
        wrappedWidget = PumpApp.materialApp(widgetToTest);
      });

      testWidgets('[GameEntry Board Size] renders properly.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);

        /// [ Board Size Row ]
        ///
        final widgetFinderBoardSize = find.byType(GameEntryBoardSizeRow);
        expect(widgetFinderBoardSize, findsNWidgets(1));
      });

      testWidgets('[GameEntry Board Size] has a title.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);

        /// [ Board Size Label ]
        ///
        final widgetFinderBoardSizeLabel = find.byKey(
          const ValueKey(AppConstants.boardSizeLabelKey),
        );
        expect(widgetFinderBoardSizeLabel, findsOneWidget);

        final boardSizeLabelWidget = tester.widget(widgetFinderBoardSizeLabel) as Text;
        expect(
          boardSizeLabelWidget,
          isA<Text>().having(
            (t) => t.data,
            'text',
            equals(AppConstants.boardSizeLabel),
          ),
        );
      });

      testWidgets('[GameEntry Board Size] has a slider.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);

        /// [ Board Size Slider ]
        ///
        const boardSizes = AppConstants.boardSizes;

        for (var labelIndex = 0; labelIndex < boardSizes.length; labelIndex++) {
          final widgetFinderSliderLabel = find.byKey(
            Key(AppConstants.sliderLabelKey(labelIndex)),
          );
          expect(widgetFinderSliderLabel, findsOneWidget);

          final sliderLabelWidget = tester.widget(widgetFinderSliderLabel) as Text;
          expect(
            sliderLabelWidget,
            isA<Text>().having(
              (t) => t.data,
              'text',
              equals(boardSizes[labelIndex]),
            ),
          );
        }
      });
    });
  });
}
