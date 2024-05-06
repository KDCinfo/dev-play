import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('GamePlay GameBoard Panel Testing:', () {
    late Widget widgetToTest;
    late Widget wrappedWidget;

    ///
    /// [ GamePlay GameBoard Panel ]
    ///

    group('GamePlay GameBoard Panel', () {
      setUp(() async {
        widgetToTest = const GameBoardPanel();
        wrappedWidget = PumpApp.materialApp(widgetToTest);
      });

      testWidgets('[GamePlay GameBoard Panel] renders properly.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);

        /// [ GameBoard Panel ]
        ///
        final widgetFinderBoardSize = find.byType(GameBoardPanel);
        expect(widgetFinderBoardSize, findsNWidgets(1));
      });
    });

    group('GamePlay GameBoard Panel Grid 3x3', () {
      const edgeSize = 3;
      const countSize = edgeSize * edgeSize;

      setUp(() async {
        widgetToTest = const GameBoardPanel(); // Default is 3.
        wrappedWidget = PumpApp.materialApp(widgetToTest);
      });

      testWidgets('[GamePlay GameBoard Panel] has a 3x3 GridView.', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(wrappedWidget);

        final widgetFinderGridView = find.byType(GridView);
        expect(widgetFinderGridView, findsOneWidget);

        /// Check gridview has 3 rows and 3 columns.
        final gridView = tester.widget<GridView>(widgetFinderGridView);
        expect(gridView.childrenDelegate.estimatedChildCount, countSize);
        expect(gridView.semanticChildCount, countSize);

        /// Check gridview has `countSize` children.
        final gridViewChildren = tester.widgetList(
          find.byType(PanelTile),
        );
        expect(gridViewChildren.length, countSize);
      });
    });

    group('GamePlay GameBoard Panel Grid 4x4', () {
      const edgeSize = 4;
      const countSize = edgeSize * edgeSize;

      setUp(() async {
        widgetToTest = const GameBoardPanel(edgeSize: edgeSize);
        wrappedWidget = PumpApp.materialApp(widgetToTest);
      });

      testWidgets('[GamePlay GameBoard Panel] has a 4x4 GridView.', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(wrappedWidget);

        final widgetFinderGridView = find.byType(GridView);
        expect(widgetFinderGridView, findsOneWidget);

        /// Check gridview has 4 rows and 4 columns.
        final gridView = tester.widget<GridView>(widgetFinderGridView);
        expect(gridView.childrenDelegate.estimatedChildCount, countSize);
        expect(gridView.semanticChildCount, countSize);

        /// Check gridview has `countSize` children.
        final gridViewChildren = tester.widgetList(
          find.byType(PanelTile),
        );
        expect(gridViewChildren.length, countSize);
      });
    });

    group('GamePlay GameBoard Panel Grid 5x5', () {
      const edgeSize = 5;
      const countSize = edgeSize * edgeSize;

      setUp(() async {
        widgetToTest = const GameBoardPanel(edgeSize: edgeSize);
        wrappedWidget = PumpApp.materialApp(widgetToTest);
      });

      testWidgets('[GamePlay GameBoard Panel] has a 5x5 GridView.', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(wrappedWidget);

        final widgetFinderGridView = find.byType(GridView);
        expect(widgetFinderGridView, findsOneWidget);

        /// Check gridview has 5 rows and 5 columns.
        final gridView = tester.widget<GridView>(widgetFinderGridView);
        expect(gridView.childrenDelegate.estimatedChildCount, countSize);
        expect(gridView.semanticChildCount, countSize);

        /// Check gridview has `countSize` children.
        final gridViewChildren = tester.widgetList(
          find.byType(PanelTile),
        );
        expect(gridViewChildren.length, countSize);
      });
    });
  });
}