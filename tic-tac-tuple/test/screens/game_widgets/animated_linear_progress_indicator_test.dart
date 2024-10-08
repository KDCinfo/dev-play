import 'package:dev_play_tictactuple/src/screens/game_widgets/game_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Widget widgetToTest;
  late Widget wrappedWidget;

  group('[AnimatedLinearProgressIndicator] Testing:', () {
    setUp(() {
      widgetToTest = const AnimatedLinearProgressIndicator();
      wrappedWidget = MaterialApp(
        home: Scaffold(
          body: widgetToTest,
        ),
      );
    });

    group('renders', () {
      testWidgets('by default.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);

        final widgetFinderScreen = find.byType(AnimatedLinearProgressIndicator);

        expect(widgetFinderScreen, findsOneWidget);
      });
    });
  });
}
