import 'package:dev_play_tictactuple/src/screens/game_widgets/game_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[IconPopAnimation] Testing:', () {
    testWidgets('should render correctly.', (WidgetTester tester) async {
      final controller = AnimationController(
        vsync: tester,
        duration: const Duration(seconds: 1),
      );
      final widget = IconPopAnimation(
        size: 50,
        playerIcon: Icons.play_arrow,
        controller: controller,
      );

      await tester.pumpWidget(MaterialApp(home: widget));
      await tester.pump(const Duration(seconds: 1));

      final iconFinder = find.byIcon(Icons.play_arrow);
      expect(iconFinder, findsOneWidget);

      final opacityFinder = find.byType(FadeTransition);
      expect(opacityFinder, findsOneWidget);

      final scaleFinder = find.byType(ScaleTransition);
      expect(scaleFinder, findsOneWidget);
    });

    testWidgets('should animate correctly.', (WidgetTester tester) async {
      final controller = AnimationController(
        vsync: tester,
        duration: const Duration(seconds: 1),
      );
      final widget = IconPopAnimation(
        size: 50,
        playerIcon: Icons.play_arrow,
        controller: controller,
      );

      await tester.pumpWidget(MaterialApp(home: widget));

      expect(find.byType(FadeTransition), findsOneWidget);
      expect(find.byType(ScaleTransition), findsOneWidget);
    });
  });
}
