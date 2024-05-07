import 'package:dev_play_tictactoe/src/app.dart';
import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MyWidget', () {
    late Widget widgetToTest;

    setUp(() {
      widgetToTest = const MyApp();
    });

    testWidgets('[MyWidget] has a MaterialApp', (WidgetTester tester) async {
      await tester.pumpWidget(widgetToTest);
      final materialAppFinder = find.byType(MaterialApp);

      expect(materialAppFinder, findsOneWidget);
    });

    testWidgets('[MyWidget] has either a GameEntry or GameBoard', (WidgetTester tester) async {
      await tester.pumpWidget(widgetToTest);
      final materialAppFinderEntry = find.byType(GameEntryScreen);
      final materialAppFinderBoard = find.byType(GameBoardScreen);

      // Ensure that only one of the two screens is present, not both:
      final foundEntry = tester.any(materialAppFinderEntry);
      final foundBoard = tester.any(materialAppFinderBoard);

      // Ensure that exactly one of these is true.
      expect(
        foundEntry != foundBoard,
        isTrue,
        reason: 'Should find exactly one of GameEntry or GameBoard',
      );
    });
  });
}
