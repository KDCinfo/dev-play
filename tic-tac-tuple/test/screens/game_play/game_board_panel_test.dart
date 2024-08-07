import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';
import 'package:dev_play_tictactuple/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('GamePlay GameBoard Panel Testing:', () {
    late MockScorebookRepository mockScorebookRepository;
    late GamePlayBloc mockGamePlayBloc;
    late WaitForBotBloc mockWaitForBotBloc;

    late Widget widgetToTest;
    late Widget wrappedWidget;

    setUpAll(() {
      registerFallbackValue(
        const ScorebookData(),
      );
    });

    setUp(() {
      mockScorebookRepository = MockScorebookRepository();
      mockGamePlayBloc = MockGamePlayBloc();
      mockWaitForBotBloc = MockWaitForBotBloc();
      when(() => mockScorebookRepository.scorebookDataStream)
          .thenAnswer((_) => Stream.value(const ScorebookData()));
      when(() => mockWaitForBotBloc.state).thenReturn(const WaitForBotState());
    });

    ///
    /// [ GamePlay GameBoard Panel ]
    ///

    group('GamePlay GameBoard Panel', () {
      setUp(() {
        widgetToTest = const GameBoardPanel();
        wrappedWidget = PumpApp.providerWrappedMaterialApp(
          child: PumpApp.providerWrappedInternal(
            waitForBotBloc: mockWaitForBotBloc,
            child: widgetToTest,
          ),
          scorebookRepository: mockScorebookRepository,
          gamePlayBloc: mockGamePlayBloc,
        );
        when(() => mockGamePlayBloc.state).thenReturn(const GamePlayState());
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

      setUp(() {
        widgetToTest = const GameBoardPanel(); // Default is 3.
        wrappedWidget = PumpApp.providerWrappedMaterialApp(
          child: PumpApp.providerWrappedInternal(
            waitForBotBloc: mockWaitForBotBloc,
            child: widgetToTest,
          ),
          scorebookRepository: mockScorebookRepository,
          gamePlayBloc: mockGamePlayBloc,
        );
        when(() => mockGamePlayBloc.state).thenReturn(const GamePlayState());
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
          find.byType(GameBoardPanelTile),
        );
        expect(gridViewChildren.length, countSize);
      });
    });

    group('GamePlay GameBoard Panel Grid 4x4', () {
      const edgeSize = 4;
      const countSize = edgeSize * edgeSize;

      setUp(() {
        mockGamePlayBloc = MockGamePlayBloc();

        widgetToTest = const GameBoardPanel();
        wrappedWidget = PumpApp.providerWrappedMaterialApp(
          child: PumpApp.providerWrappedInternal(
            waitForBotBloc: mockWaitForBotBloc,
            child: widgetToTest,
          ),
          scorebookRepository: mockScorebookRepository,
          gamePlayBloc: mockGamePlayBloc,
        );
        when(() => mockGamePlayBloc.state).thenReturn(
          GamePlayState(
            currentGame: GameData(
              players: [...playerList],
              gameBoardData: const GameBoardData(edgeSize: 4),
            ),
          ),
        );
        when(() => mockScorebookRepository.scorebookDataStream).thenAnswer(
          (_) => Stream.value(const ScorebookData()),
        );
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
          find.byType(GameBoardPanelTile),
        );
        expect(gridViewChildren.length, countSize);
      });
    });

    group('GamePlay GameBoard Panel Grid 5x5', () {
      const edgeSize = 5;
      const countSize = edgeSize * edgeSize;

      setUp(() {
        widgetToTest = const GameBoardPanel();
        wrappedWidget = PumpApp.providerWrappedMaterialApp(
          child: PumpApp.providerWrappedInternal(
            waitForBotBloc: mockWaitForBotBloc,
            child: widgetToTest,
          ),
          scorebookRepository: mockScorebookRepository,
          gamePlayBloc: mockGamePlayBloc,
        );
        when(() => mockGamePlayBloc.state).thenReturn(
          GamePlayState(
            currentGame: GameData(
              players: [...playerList],
              gameBoardData: const GameBoardData(edgeSize: 5),
            ),
          ),
        );
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
          find.byType(GameBoardPanelTile),
        );
        expect(gridViewChildren.length, countSize);
      });
    });
  });
}
