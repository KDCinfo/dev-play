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
    /// [ GameEntry Buttons ]
    ///

    group('GameEntry Buttons', () {
      setUp(() async {
        widgetToTest = const GameEntryButtonsRow();
        wrappedWidget = PumpApp.materialApp(widgetToTest);
      });

      testWidgets('[GameEntry Buttons] renders properly.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);

        final widgetFinderButtons = find.byType(GameEntryButtonsRow);
        expect(widgetFinderButtons, findsNWidgets(1));
      });

      testWidgets('[GameEntry Buttons] has a play button.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);

        final widgetFinderButtonPlay = find.byKey(const ValueKey(AppConstants.buttonPlayKey));
        expect(widgetFinderButtonPlay, findsOneWidget);

        final buttonPlayWidget = tester.widget(widgetFinderButtonPlay) as Text;
        expect(
          buttonPlayWidget,
          isA<Text>().having(
            (t) => t.data,
            'text',
            equals(AppConstants.buttonPlayText),
          ),
        );
      });

      testWidgets('[GameEntry Buttons] has a reset button.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);

        final widgetFinderButtonReset = find.byKey(const ValueKey(AppConstants.buttonResetKey));
        expect(widgetFinderButtonReset, findsOneWidget);

        final buttonResetWidget = tester.widget(widgetFinderButtonReset) as Text;
        expect(
          buttonResetWidget,
          isA<Text>().having(
            (t) => t.data,
            'text',
            equals(AppConstants.buttonReset),
          ),
        );
      });
    });
  });
}
