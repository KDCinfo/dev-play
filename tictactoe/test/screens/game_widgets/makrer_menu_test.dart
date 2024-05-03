import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('GameWidget Testing:', () {
    late Widget widgetToTest;
    late Widget wrappedWidget;

    ///
    /// [ GameWidget Marker Menu ]
    ///

    group('GameWidget Marker Menu', () {
      setUp(() async {
        widgetToTest = MarkerMenu();
        wrappedWidget = PumpApp.materialApp(widgetToTest);
      });

      testWidgets('[GameWidget Marker Menu] has an IconButton.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);

        final widgetFinderIconButton = find.byType(IconButton);
        expect(widgetFinderIconButton, findsOneWidget);

        // Tap button
        await tester.tap(widgetFinderIconButton);
        await tester.pumpAndSettle();

        // AppConstants.markerIconList has 5 elements,
        // but the first is not shown because it is only
        // used for empty inputs.
        final widgetFinderIconButtonRow = find.descendant(
          of: widgetFinderIconButton,
          matching: find.byType(Text),
        );
        expect(widgetFinderIconButtonRow, findsNWidgets(4));
      });
    });
  });
}
