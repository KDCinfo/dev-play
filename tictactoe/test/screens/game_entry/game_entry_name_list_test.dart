import 'package:dev_play_tictactoe/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactoe/src/data/models/models.dart';
import 'package:dev_play_tictactoe/src/data/service_repositories/service_repositories.dart';
import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('GameEntry Testing:', () {
    late Widget widgetToTest;
    late Widget wrappedWidget;
    late ScorebookRepository mockScorebookRepository;
    late GameEntryBloc mockGameEntryBloc;

    setUpAll(() {
      registerFallbackValue(const ScorebookData());
    });

    setUp(() async {
      mockScorebookRepository = MockScorebookRepository();
      mockGameEntryBloc = MockGameEntryBloc();

      widgetToTest = const GameEntryNameList();
      wrappedWidget = await PumpApp.providerWrappedMaterialApp(
        scorebookRepository: mockScorebookRepository,
        gameEntryBloc: mockGameEntryBloc,
        child: widgetToTest,
      );

      when(() => mockScorebookRepository.currentScorebookData).thenReturn(const ScorebookData());
      when(() => mockScorebookRepository.scorebookDataStream).thenAnswer(
        (_) => Stream.value(const ScorebookData()),
      );
    });

    ///
    /// [ Player Name List ]
    ///

    group('GameEntry Player Name List', () {
      testWidgets('should show 1 GameEntryNameListRow when state.players.length == 0.',
          (WidgetTester tester) async {
        //
        // const playerList = <PlayerData>[];
        //
        when(() => mockGameEntryBloc.state).thenReturn(
          const GameEntryState(), // players: playerList | Default: []
        );

        await tester.pumpWidget(wrappedWidget);

        // Root: GameEntryNameList
        final widgetFinderNameList = find.byType(GameEntryNameList);
        expect(widgetFinderNameList, findsOneWidget);

        // [1-4]: GameEntryNameListRow
        final widgetFinderNameListRow = find.descendant(
          of: widgetFinderNameList,
          matching: find.byType(GameEntryNameListRow),
        );
        expect(widgetFinderNameListRow, findsOneWidget);

        // testWidgets('[GameEntry Name List] has an InputName.', (WidgetTester tester) async {});
        final widgetFinderNameListInputName = find.descendant(
          of: widgetFinderNameList,
          matching: find.byType(GameEntryNameListRowInputName),
        );
        expect(widgetFinderNameListInputName, findsOneWidget);

        // testWidgets('[GameEntry Name List] has a PlayerNameList.', (WidgetTester tester) async {});
        final widgetFinderNameListPlayerNameList = find.descendant(
          of: widgetFinderNameList,
          matching: find.byType(PlayerList),
        );
        expect(widgetFinderNameListPlayerNameList, findsOneWidget);
      });

      testWidgets('should show 2 GameEntryNameListRow when state.players.length = 1.',
          (WidgetTester tester) async {
        final playerList = playerListSingle;

        when(() => mockGameEntryBloc.state).thenReturn(
          GameEntryState(players: playerList),
        );

        await tester.pumpWidget(wrappedWidget);

        // Root
        final widgetFinderNameList = find.byType(GameEntryNameList);
        expect(widgetFinderNameList, findsOneWidget);

        // [1-4] => 1 player in the list = 2 rows (with 3 elements each).

        // GameEntryNameListRow
        final widgetFinderNameListRow = find.descendant(
          of: widgetFinderNameList,
          matching: find.byType(GameEntryNameListRow),
        );
        expect(widgetFinderNameListRow, findsNWidgets(2));

        // Input Name
        final widgetFinderNameListInputName = find.descendant(
          of: widgetFinderNameList,
          matching: find.byType(GameEntryNameListRowInputName),
        );
        expect(widgetFinderNameListInputName, findsNWidgets(2));

        // Player Name List
        final widgetFinderNameListPlayerNameList = find.descendant(
          of: widgetFinderNameList,
          matching: find.byType(PlayerList),
        );
        expect(widgetFinderNameListPlayerNameList, findsNWidgets(2));
      });

      testWidgets('should show 3 [GameEntryNameListRow] when state.players.length = 2.',
          (WidgetTester tester) async {
        final twoPlayerList = playerList;

        when(() => mockGameEntryBloc.state).thenReturn(
          GameEntryState(players: twoPlayerList),
        );

        await tester.pumpWidget(wrappedWidget);

        // Root
        final widgetFinderNameList = find.byType(GameEntryNameList);
        expect(widgetFinderNameList, findsOneWidget);

        // [1-4] => 2 players in the list = 3 rows (with 3 elements each).

        // GameEntryNameListRow
        final widgetFinderNameListRow = find.descendant(
          of: widgetFinderNameList,
          matching: find.byType(GameEntryNameListRow),
        );
        expect(widgetFinderNameListRow, findsNWidgets(3));

        // Input Name
        final widgetFinderNameListInputName = find.descendant(
          of: widgetFinderNameList,
          matching: find.byType(GameEntryNameListRowInputName),
        );
        expect(widgetFinderNameListInputName, findsNWidgets(3));

        // Player Name List
        final widgetFinderNameListPlayerNameList = find.descendant(
          of: widgetFinderNameList,
          matching: find.byType(PlayerList),
        );
        expect(widgetFinderNameListPlayerNameList, findsNWidgets(3));
      });

      testWidgets('should show 4 [GameEntryNameListRow] when state.players.length = 3.',
          (WidgetTester tester) async {
        final threePlayerList = playerListAddOne;

        when(() => mockGameEntryBloc.state).thenReturn(
          GameEntryState(players: threePlayerList),
        );

        await tester.pumpWidget(wrappedWidget);

        // Root
        final widgetFinderNameList = find.byType(GameEntryNameList);
        expect(widgetFinderNameList, findsOneWidget);

        // [1-4] => 3 players in the list = 4 rows (with 3 elements each).

        // GameEntryNameListRow
        final widgetFinderNameListRow = find.descendant(
          of: widgetFinderNameList,
          matching: find.byType(GameEntryNameListRow),
        );
        expect(widgetFinderNameListRow, findsNWidgets(4));

        // Input Name
        final widgetFinderNameListInputName = find.descendant(
          of: widgetFinderNameList,
          matching: find.byType(GameEntryNameListRowInputName),
        );
        expect(widgetFinderNameListInputName, findsNWidgets(4));

        // Player Name List
        final widgetFinderNameListPlayerNameList = find.descendant(
          of: widgetFinderNameList,
          matching: find.byType(PlayerList),
        );
        expect(widgetFinderNameListPlayerNameList, findsNWidgets(4));
      });
    });
  });
}
