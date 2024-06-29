import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/screens/game_widgets/game_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[WaitForBotIndicator] Testing:', () {
    testWidgets('shows progress indicator when waiting on bot.', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: WaitForBotIndicator(waitingOnBot: true),
        ),
      );

      final progressIndicatorFinder = find.byType(LinearProgressIndicator);
      expect(progressIndicatorFinder, findsOneWidget);
      expect(progressIndicatorFinder.hitTestable(), findsOneWidget);
    });

    testWidgets('hides progress indicator when not waiting on bot.', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: WaitForBotIndicator(waitingOnBot: false),
        ),
      );

      final progressIndicatorFinder = find.byType(LinearProgressIndicator);
      // expect(progressIndicatorFinder, findsNothing);
      // Check if visible
      expect(progressIndicatorFinder.hitTestable(), findsNothing);
    });

    testWidgets('ignores pointer events when waiting on bot.', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: WaitForBotIndicator(waitingOnBot: true),
        ),
      );

      final ignorePointerFinderKey = find.byKey(AppConstants.ignorePointerKey);
      expect(ignorePointerFinderKey, findsOneWidget);

      final ignorePointerWidget = tester.widget<IgnorePointer>(ignorePointerFinderKey);
      expect(ignorePointerWidget.ignoring, false);
    });

    testWidgets(
      'does not ignore pointer events when not waiting on bot.',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: WaitForBotIndicator(waitingOnBot: false),
          ),
        );

        final ignorePointerFinderKey = find.byKey(AppConstants.ignorePointerKey);
        expect(ignorePointerFinderKey, findsOneWidget);

        final ignorePointerWidget = tester.widget<IgnorePointer>(ignorePointerFinderKey);
        expect(ignorePointerWidget.ignoring, true);
      },
    );
  });
}
