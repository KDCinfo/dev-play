import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';
import 'package:dev_play_tictactuple/src/screens/game_board/game_board.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('GameBoardPlayerPanel', () {
    late MockScorebookRepository mockScorebookRepository;
    late GamePlayBloc mockGamePlayBloc;

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
      when(() => mockScorebookRepository.scorebookDataStream)
          .thenAnswer((_) => Stream.value(const ScorebookData()));
      when(() => mockGamePlayBloc.state).thenReturn(const GamePlayState());
    });

    ///
    /// [ GameBoard Player Panel ]
    ///

    group('GameBoard Player Panel', () {
      setUp(() async {
        widgetToTest = const GameBoardPlayerPanel();
        wrappedWidget = await PumpApp.providerWrappedMaterialApp(
          child: widgetToTest,
          scorebookRepository: mockScorebookRepository,
          gamePlayBloc: mockGamePlayBloc,
        );
        when(() => mockGamePlayBloc.state).thenReturn(
          const GamePlayState(
            currentGame: GameData(
              players: AppConstants.playerListDefault,
            ),
          ),
        );
      });

      testWidgets('[GameBoard Player Panel] renders.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);
        final widgetFinderBoard = find.byType(GameBoardPlayerPanel);
        expect(widgetFinderBoard, findsOneWidget);

        final widgetFinderPanelTitle = find.byType(GameBoardPlayerPanelTitle);
        expect(widgetFinderPanelTitle, findsOneWidget);

        final widgetFinderPanelNames = find.byType(GameBoardPlayerPanelNames);
        expect(widgetFinderPanelNames, findsOneWidget);
      });

      testWidgets('[GameBoard Player Panel] should display the correct player count', (
        WidgetTester tester,
      ) async {
        const playerCount = 2;
        const playerTitle = 'Players: [ $playerCount ]';

        await tester.pumpWidget(wrappedWidget);

        expect(find.text(playerTitle), findsOneWidget);
      });

      testWidgets('[GameBoard Player Panel] should display the correct player names', (
        WidgetTester tester,
      ) async {
        final players = <String>[
          AppConstants.playerListDefault[0].playerName,
          AppConstants.playerListDefault[1].playerName,
        ];

        await tester.pumpWidget(wrappedWidget);

        expect(find.text('[ ${players.elementAtOrNull(0) ?? 'Oops'} ]'), findsOneWidget);
        expect(find.text('[ ${players.elementAtOrNull(1) ?? 'Oops'} ]'), findsOneWidget);
      });

      testWidgets('[GameBoard Player Panel] should highlight the current player', (
        WidgetTester tester,
      ) async {
        const currentPlayer = 0;
        final players = <String>[
          AppConstants.playerListDefault[0].playerName,
          AppConstants.playerListDefault[1].playerName,
        ];

        await tester.pumpWidget(wrappedWidget);

        final player1Text = tester.widget<Text>(
          find.text('[ ${players.elementAtOrNull(currentPlayer) ?? 'Oops'} ]'),
        );
        final player2Text = tester.widget<Text>(
          find.text('[ ${players.elementAtOrNull(1) ?? 'Oops'} ]'),
        );

        expect(player1Text.style?.fontWeight, equals(FontWeight.bold));
        expect(player2Text.style?.fontWeight, equals(FontWeight.normal));
      });
    });
  });
}
