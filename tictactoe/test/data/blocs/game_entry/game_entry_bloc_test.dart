import 'package:bloc_test/bloc_test.dart';

import 'package:dev_play_tictactoe/src/data/data.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

void main() {
  late MockScorebookRepository mockScorebookRepository;
  late GameEntryBloc gameEntryBloc;

  group('[GameEntryBloc] Testing:', () {
    setUpAll(() {
      registerFallbackValue(
        const ScorebookData(),
      );
    });

    setUp(() {
      mockScorebookRepository = MockScorebookRepository();
      when(() => mockScorebookRepository.scorebookDataStream)
          .thenAnswer((_) => Stream.value(const ScorebookData()));
      gameEntryBloc = GameEntryBloc(scorebookRepository: mockScorebookRepository);
    });

    tearDown(() {
      gameEntryBloc.close();
    });

    // Group: General bloc tests
    group('[blocTest] Testing:', () {
      blocTest<GameEntryBloc, GameEntryState>(
        'emits state when new game is started.',
        setUp: () {
          when(() => mockScorebookRepository.currentScorebookData)
              .thenReturn(const ScorebookData());
          gameEntryBloc
            ..add(const GameEntryEdgeSizeEvent(edgeSize: 4))
            ..add(GameEntryPlayerListEvent(playerList: playerList));
        },
        build: () => gameEntryBloc,
        act: (bloc) => bloc.add(const GameEntryStartGameEvent()),
        verify: (_) async {
          verify(() => mockScorebookRepository.scorebookDataStream).called(1);
          verify(() => mockScorebookRepository.updateScorebookDataStream(any())).called(1);
        },
      );

      blocTest<GameEntryBloc, GameEntryState>(
        'emits state with updated edgeSize.',
        setUp: () {
          gameEntryBloc
            ..add(const GameEntryEdgeSizeEvent(edgeSize: 4))
            ..add(GameEntryPlayerListEvent(playerList: playerList));
        },
        build: () => gameEntryBloc,
        act: (bloc) => bloc.add(const GameEntryEdgeSizeEvent(edgeSize: 5)),
        expect: () => [
          GameEntryState(
            edgeSize: 4,
            players: playerList,
          ),
          GameEntryState(
            edgeSize: 5,
            players: playerList,
          ),
        ],
      );

      blocTest<GameEntryBloc, GameEntryState>(
        'emits state with updated players.',
        setUp: () {
          gameEntryBloc
            ..add(const GameEntryEdgeSizeEvent(edgeSize: 4))
            ..add(GameEntryPlayerListEvent(playerList: playerList));
        },
        build: () => gameEntryBloc,
        act: (bloc) => bloc.add(
          GameEntryPlayerListEvent(
            playerList: playerListAddOne,
          ),
        ),
        expect: () => [
          GameEntryState(
            edgeSize: 4,
            players: playerList,
          ),
          GameEntryState(
            edgeSize: 4,
            players: playerListAddOne,
          ),
        ],
      );

      blocTest<GameEntryBloc, GameEntryState>(
        'emits state with four players.',
        setUp: () {
          gameEntryBloc
            ..add(const GameEntryEdgeSizeEvent(edgeSize: 5))
            ..add(GameEntryPlayerListEvent(playerList: playerList));
        },
        build: () => gameEntryBloc,
        act: (bloc) => bloc.add(
          GameEntryPlayerListEvent(
            playerList: playerListAddFourth,
          ),
        ),
        expect: () => [
          GameEntryState(
            edgeSize: 5,
            players: playerList,
          ),
          GameEntryState(
            edgeSize: 5,
            players: playerListAddFourth,
          ),
        ],
      );
    });

    // Group: Event tests
    group('[Unit] Testing:', () {
      group('constructor', () {
        test(
          'works properly',
          () => expect(() => gameEntryBloc, returnsNormally),
        );

        test('has correct initial state', () {
          expect(
            gameEntryBloc.state,
            equals(const GameEntryState()),
          );
        });
      });

      test('update player list.', () {
        final expectedState = gameEntryBloc.state.copyWith(players: playerList);

        gameEntryBloc.add(GameEntryPlayerListEvent(playerList: playerList));

        expectLater(gameEntryBloc.stream, emits(expectedState));
      });

      test('update edge size.', () {
        const edgeSize = 4;
        final expectedState = gameEntryBloc.state.copyWith(edgeSize: edgeSize);

        gameEntryBloc.add(const GameEntryEdgeSizeEvent(edgeSize: edgeSize));

        expectLater(gameEntryBloc.stream, emits(expectedState));
      });

      test('start game with one player.', () async {
        final playerList = [
          const PlayerData(
            playerId: 1,
            playerNum: 1,
            playerName: 'Player 1',
            userSymbol: UserSymbolX(),
          ),
        ];
        final scorebookData = ScorebookData(
          allPlayers: playerList,
        );

        when(() => mockScorebookRepository.scorebookDataStream)
            .thenAnswer((_) => Stream.value(scorebookData));
        when(() => mockScorebookRepository.currentScorebookData).thenReturn(scorebookData);
        when(() => mockScorebookRepository.updateScorebookDataStream(any()))
            .thenAnswer((_) async {});

        gameEntryBloc
          ..add(const GameEntryEdgeSizeEvent(edgeSize: 4))
          ..add(GameEntryPlayerListEvent(playerList: playerList))
          ..add(const GameEntryStartGameEvent());

        verify(
          () => mockScorebookRepository.scorebookDataStream,
        ).called(1);

        // Wait for bloc to process events
        // await gameEntryBloc.stream.isEmpty;
        await Future<void>.delayed(Duration.zero);

        // This fails when not delayed with the `Future` above.
        //
        verify(
          () async => mockScorebookRepository.updateScorebookDataStream(any()),
        ).called(1);

        // This also fails when not delayed.
        //
        // Note: This test is commented because only one `verify` can be verified at a time.
        //
        // If you need to check specifics, capture the argument.
        // final captured = verify(() => mockScorebookRepository.updateScorebookDataStream(captureAny()))
        //     .captured
        //     .single as ScorebookData;
        //
        // You can inspect the `captured` data to ensure it has the properties you expect.
        // await expectLater(captured.allPlayers.length, 2); // 'Player 1' and 'Botuple'
      });

      // Can use: `playerListAddFourth`
      test('start game with four players.', () async {
        final scorebookData = ScorebookData(
          allPlayers: playerListAddFourth,
        );

        when(() => mockScorebookRepository.scorebookDataStream)
            .thenAnswer((_) => Stream.value(scorebookData));
        when(() => mockScorebookRepository.currentScorebookData).thenReturn(scorebookData);
        when(() => mockScorebookRepository.updateScorebookDataStream(any()))
            .thenAnswer((_) async {});

        gameEntryBloc
          ..add(const GameEntryEdgeSizeEvent(edgeSize: 5))
          ..add(GameEntryPlayerListEvent(playerList: playerListAddFourth))
          ..add(const GameEntryStartGameEvent());

        verify(
          () => mockScorebookRepository.scorebookDataStream,
        ).called(1);

        // Wait for bloc to process events
        await Future<void>.delayed(Duration.zero);

        verify(
          () async => mockScorebookRepository.updateScorebookDataStream(any()),
        ).called(1);
      });
    });
  });
}