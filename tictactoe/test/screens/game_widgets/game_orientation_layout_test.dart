import 'package:dev_play_tictactoe/src/data/models/models.dart';
import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('[GameOrientationLayout] Testing:', () {
    late Widget widgetToTest;
    late Widget wrappedWidget;

    ///
    /// [ GameOrientationLayout: GameEntry Screen ]
    ///

    group('[GameEntry Layout] Screen', () {
      setUp(() {
        widgetToTest = const GameOrientationLayout(
          orientationScreen: OrientationScreenGameEntry(),
        );
        wrappedWidget = PumpApp.materialApp(widgetToTest);
      });

      testWidgets('[GameOrientationLayout] renders.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);

        final widgetFinderBoard = find.byType(GameOrientationLayout);
        expect(widgetFinderBoard, findsOneWidget);
      });

      /// Note: Deeper individual widget tests are in their own respective test files.

      testWidgets('[GameEntryLayout] renders a [GameEntryLayoutPortrait].', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(wrappedWidget);

        // Because the default canvas size is 800x600, despite being
        // a landscape layout by definition, the available height is
        // still greater than 300, so the portrait layout is rendered.
        //
        // final availableHeight = checkConstraints.maxHeight - 60 - 40 - 10;
        // return availableHeight < 300 // + 110 == 410

        final widgetFinderBoard = find.byType(GameEntryLayoutPortrait);
        expect(widgetFinderBoard, findsOneWidget);
      });

      testWidgets('[GameEntryLayout] renders a [GameEntryLayoutLandscape].', (
        WidgetTester tester,
      ) async {
        tester.view.devicePixelRatio = 1.0; // Must be set with `physicalSize`.

        // Testing for landscape: [400] - 60 - 40 - 10 = 290 [< 300]
        tester.view.physicalSize = const Size(800, 400);

        await tester.pumpWidget(wrappedWidget);
        final widgetFinderBoard = find.byType(GameEntryLayoutLandscape);
        expect(widgetFinderBoard, findsOneWidget);

        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.view.resetPhysicalSize);
      });
    });

    ///
    /// [ GameOrientationLayout: GameBoard Screen ]
    ///

    group('[GameBoard Layout] Screen', () {
      setUp(() {
        widgetToTest = const GameOrientationLayout(
          orientationScreen: OrientationScreenGameBoard(),
        );
        wrappedWidget = PumpApp.materialApp(widgetToTest);
      });

      testWidgets('[GameOrientationLayout] renders.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);

        final widgetFinderBoard = find.byType(GameOrientationLayout);
        expect(widgetFinderBoard, findsOneWidget);
      });

      /// Note: Deeper individual widget tests are in their own respective test files.

      testWidgets('[GameBoardLayout] renders a [GameBoardLayoutPortrait].', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(wrappedWidget);

        // Because the default canvas size is 800x600, despite being
        // a landscape layout by definition, the available height is
        // still greater than 300, so the portrait layout is rendered.
        //
        // final availableHeight = checkConstraints.maxHeight - 60 - 40 - 10;
        // return availableHeight < 300 // + 110 == 410

        final widgetFinderBoard = find.byType(GameBoardLayoutPortrait);
        expect(widgetFinderBoard, findsOneWidget);

        // The fallback `edgeSize` for `GameBoardPanel` is 3x3.
        final widgetFinderTile = find.byType(GameBoardPanelTile);
        expect(widgetFinderTile, findsNWidgets(9));
      });

      testWidgets('[GameBoardLayout] renders a [GameBoardLayoutLandscape].', (
        WidgetTester tester,
      ) async {
        tester.view.devicePixelRatio = 1.0; // Must be set with `physicalSize`.

        // Testing for landscape: [400] - 60 - 40 - 10 = 290 [< 300]
        tester.view.physicalSize = const Size(400, 350);

        await tester.pumpWidget(wrappedWidget);
        final widgetFinderBoard = find.byType(GameBoardLayoutLandscape);
        expect(widgetFinderBoard, findsOneWidget);

        // The fallback `edgeSize` for `GameBoardPanel` is 3x3.
        final widgetFinderTile = find.byType(GameBoardPanelTile);
        expect(widgetFinderTile, findsNWidgets(9));

        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.view.resetPhysicalSize);
      });
    });
  });
}
