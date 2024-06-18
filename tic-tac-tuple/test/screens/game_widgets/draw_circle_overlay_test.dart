import 'package:dev_play_tictactuple/src/screens/game_widgets/game_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[DrawCircleOverlay] Testing:', () {
    testWidgets('successfully creates a circle overlay.', (
      WidgetTester tester,
    ) async {
      // Create a MaterialApp to provide context and an Overlay.
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              return TextButton(
                onPressed: () {
                  DrawCircleOverlay(
                    context: context,
                    globalPosition: const Offset(100, 100),
                    radius: 50,
                    index: 123,
                    color: Colors.green,
                  );
                },
                child: const Text('Show Overlay'),
              );
            },
          ),
        ),
      );

      // Tap the button to trigger the overlay.
      await tester.tap(find.text('Show Overlay'));

      // Necessary to rebuild the UI and show the overlay.
      await tester.pump();

      // Check if the overlay is displayed.

      // Check for index and button Text.
      expect(find.byType(Text), findsNWidgets(2));

      // Check for text within the overlay.
      expect(find.text('123'), findsOneWidget);

      // This ensures the decoration is applied as expected.
      expect(
        find.byWidgetPredicate((Widget widget) {
          return widget is Container &&
              widget.decoration ==
                  const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  );
        }),
        findsOneWidget,
      );

      // Check positions.
      final box = tester.renderObject(find.byType(Container)) as RenderBox;

      // Diameter = radius * 2
      expect(box.size.width, 100);
      expect(box.size.height, 100);

      // Position minus radius.
      expect(box.localToGlobal(Offset.zero), const Offset(50, 50));
    });
  });
}
