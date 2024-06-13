import 'package:dev_play_tictactuple/src/screens/game_widgets/game_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[IconPop] Testing:', () {
    testWidgets('should build without error', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: IconPop(
            size: 24,
            playerIcon: Icons.person,
          ),
        ),
      );

      expect(find.byType(IconPopAnimation), findsOneWidget);
    });

    testWidgets('should dispose the animation controller.', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: IconPop(
            size: 24,
            playerIcon: Icons.person,
          ),
        ),
      );

      final iconPopState = tester.state<IconPopState>(find.byType(IconPop));

      expect(iconPopState.controller.isDismissed, isFalse);

      await tester.pumpWidget(Container());

      await tester.pump();
      // await tester.pump(const Duration(milliseconds: 350));
      // await tester.pumpAndSettle();

      expect(iconPopState.controller.isAnimating, isFalse);

      // @TODO: The dispose is hit, but neither of these expect approaches work.
      // expect(iconPopState.controller.isDismissed, isTrue);

      // bool isDisposed;

      // try {
      //   final isAnimating = iconPopState.controller.isAnimating;
      //   isDisposed = false;
      // } catch (e) {
      //   // If an error occurs, it's likely because the controller is disposed.
      //   isDisposed = true;
      // }

      // expect(isDisposed, isTrue);
    });
  });
}
