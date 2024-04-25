import 'package:dev_play_tictactoe/src/app.dart';
import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MyWidget', () {
    testWidgets('MyWidget has a MaterialApp', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      final materialAppFinder = find.byType(MaterialApp);

      expect(materialAppFinder, findsOneWidget);
    });

    testWidgets('MyWidget has a GameEntry', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      final materialAppFinder = find.byType(GameEntry);

      expect(materialAppFinder, findsOneWidget);
    });
  });
}
