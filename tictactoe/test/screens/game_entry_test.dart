import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

void main() {
  group('GameEntry Testing:', () {
    late Widget widgetToTest;
    late Widget wrappedWidget;

    setUp(() async {
      widgetToTest = const GameEntry();
      wrappedWidget = PumpApp.materialApp(widgetToTest);
    });

    testWidgets('GameEntry has a title.', (WidgetTester tester) async {
      await tester.pumpWidget(wrappedWidget);

      final appTitleFinder = find.byKey(const ValueKey(AppConstants.appTitleKey));
      expect(appTitleFinder, findsOneWidget);

      final appTitleWidget = tester.widget(appTitleFinder) as Text;
      expect(appTitleWidget, isA<Text>());

      expect(
        appTitleWidget,
        isA<Text>().having(
          (t) => t.data,
          'text',
          equals(AppConstants.appTitle),
        ),
      );
    });
  });
}
