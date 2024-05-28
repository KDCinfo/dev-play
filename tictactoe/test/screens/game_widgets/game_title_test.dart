import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('GameWidget Testing:', () {
    late Widget widgetToTest;
    late Widget wrappedWidget;

    ///
    /// [ GameWidget Title ]
    ///

    group('GameWidget Title', () {
      setUp(() {
        widgetToTest = const GameTitleRow();
        wrappedWidget = PumpApp.materialApp(widgetToTest);
      });

      testWidgets('[GameWidget Title] has a title.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);

        final widgetFinderTitleText = find.byKey(const ValueKey(AppConstants.appTitleKey));
        expect(widgetFinderTitleText, findsOneWidget);

        final appTitleWidget = tester.widget(widgetFinderTitleText) as Text;
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
  });
}
