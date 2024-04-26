import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

void main() {
  group('GameEntry Testing:', () {
    late Widget widgetToTest;
    late Widget wrappedWidget;

    group('GameEntry Title', () {
      setUp(() async {
        widgetToTest = const GameEntryScreen();
        wrappedWidget = PumpApp.materialApp(widgetToTest);
      });

      testWidgets('[GameEntry Title] has a title.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);

        final widgetFinderTitleRow = find.byType(GameEntryTitleRow);
        expect(widgetFinderTitleRow, findsOneWidget);

        final widgetFinderTitleText = find.byKey(const ValueKey(AppConstants.appTitleKey));
        expect(widgetFinderTitleText, findsOneWidget);

        final appTitleWidget = tester.widget(widgetFinderTitleText) as Text;
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

    group('GameEntry Player Name List', () {
      setUp(() async {
        widgetToTest = const GameEntryScreen();
        wrappedWidget = PumpApp.materialApp(widgetToTest);
      });

      testWidgets('[GameEntry Player Name List] has a player list.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);

        final widgetFinderNameList = find.byType(GameEntryNameList);
        expect(widgetFinderNameList, findsOneWidget);

        final widgetFinderNameListRow = find.byType(GameEntryNameListRow);
        expect(widgetFinderNameListRow, findsNWidgets(4));
      });
    });
  });
}
