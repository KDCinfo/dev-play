import 'package:bloc_test/bloc_test.dart';

import 'package:dev_play_tictactoe/src/app_constants.dart';
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
            ..add(const GameEntryChangeNameEvent(playerNum: 1, playerName: 'Player 1'));
        },
        build: () => gameEntryBloc,
        act: (bloc) => bloc.add(const GameEntryStartGameEvent()),
        verify: (_) async {
          verify(() => mockScorebookRepository.scorebookDataStream).called(1);
          verify(() => mockScorebookRepository.currentScorebookData).called(2);
          verify(() => mockScorebookRepository.processNewGame(any())).called(1);
        },
      );

      blocTest<GameEntryBloc, GameEntryState>(
        'emits state with updated edgeSize.',
        setUp: () {
          gameEntryBloc
            ..add(const GameEntryEdgeSizeEvent(edgeSize: 4))
            ..add(const GameEntryChangeNameEvent(playerNum: 1, playerName: 'Player 1b'));
        },
        build: () => gameEntryBloc,
        act: (bloc) => bloc.add(const GameEntryEdgeSizeEvent(edgeSize: 5)),
        expect: () => [
          const GameEntryState(
            edgeSize: 4,
            players: [
              PlayerData(
                playerNum: 1,
                playerName: 'Player 1b',
                playerType: PlayerTypeHuman(),
                userSymbol: UserSymbolX(),
              ),
              PlayerData(
                playerNum: 2,
                playerName: 'TicTacBot',
                userSymbol: UserSymbolO(),
              ),
            ],
          ),
          const GameEntryState(
            edgeSize: 5,
            players: [
              PlayerData(
                playerNum: 1,
                playerName: 'Player 1b',
                playerType: PlayerTypeHuman(),
                userSymbol: UserSymbolX(),
              ),
              PlayerData(
                playerNum: 2,
                playerName: 'TicTacBot',
                userSymbol: UserSymbolO(),
              ),
            ],
          ),
        ],
      );

      blocTest<GameEntryBloc, GameEntryState>(
        'emits state with updated players.',
        setUp: () {
          gameEntryBloc
            ..add(const GameEntryEdgeSizeEvent(edgeSize: 4))
            ..add(const GameEntryChangeNameEvent(playerNum: 1, playerName: 'Player 1'));
        },
        build: () => gameEntryBloc,
        act: (bloc) => bloc.add(
          const GameEntryChangeNameEvent(playerNum: 1, playerName: 'Player 1b'),
        ),
        expect: () => [
          const GameEntryState(
            edgeSize: 4,
            players: [
              PlayerData(
                playerNum: 1,
                playerName: 'Player 1b',
                playerType: PlayerTypeHuman(),
                userSymbol: UserSymbolX(),
              ),
              PlayerData(
                playerNum: 2,
                playerName: 'TicTacBot',
                userSymbol: UserSymbolO(),
              ),
            ],
          ),
        ],
      );

      blocTest<GameEntryBloc, GameEntryState>(
        'emits state with four players.',
        setUp: () {
          gameEntryBloc
            ..add(const GameEntryEdgeSizeEvent(edgeSize: 5))
            ..add(const GameEntryChangeNameEvent(playerNum: 1, playerName: 'Player 1'));
        },
        build: () => gameEntryBloc,
        act: (bloc) => bloc.add(
          const GameEntryChangeNameEvent(playerNum: 1, playerName: 'Player 1b'),
        ),
        expect: () => [
          const GameEntryState(
            edgeSize: 5,
            players: [
              PlayerData(
                playerNum: 1,
                playerName: 'Player 1b',
                playerType: PlayerTypeHuman(),
                userSymbol: UserSymbolX(),
              ),
              PlayerData(
                playerNum: 2,
                playerName: 'TicTacBot',
                userSymbol: UserSymbolO(),
              ),
            ],
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
            equals(
              const GameEntryState(
                players: AppConstants.playerListDefault,
              ),
            ),
          );
        });
      });

      test('updates the player list.', () async {
        const player1Change = PlayerData(
          playerNum: 1,
          playerName: 'Player 1b',
          playerType: PlayerTypeHuman(),
          userSymbol: UserSymbolX(),
        );
        final localPlayerListFirstChange = [
          player1Change,
          const PlayerData(
            playerNum: 2,
            playerName: 'TicTacBot',
            userSymbol: UserSymbolO(),
          ),
        ];
        final localPlayerListSecondChange = [
          player1Change,
          const PlayerData(
            playerNum: 2,
            playerName: 'TicTacBot',
            userSymbol: UserSymbolStar(),
          ),
        ];

        final expectedStateFirst = gameEntryBloc.state.copyWith(
          players: localPlayerListFirstChange,
        );
        final expectedStateSecond = gameEntryBloc.state.copyWith(
          players: localPlayerListSecondChange,
        );

        expect(
          gameEntryBloc.state,
          equals(const GameEntryState(players: AppConstants.playerListDefault)),
        );

        gameEntryBloc
          ..add(const GameEntryChangeNameEvent(playerNum: 1, playerName: 'Player 1b'))
          ..add(const GameEntrySymbolSelectedEvent(playerNum: 2, selectedSymbolKey: '*'));

        await expectLater(
          gameEntryBloc.stream,
          emitsInOrder([
            expectedStateFirst,
            expectedStateSecond,
          ]),
        );
      });

      test('updates the edge size.', () {
        const edgeSize = 4;
        final expectedState = gameEntryBloc.state.copyWith(edgeSize: edgeSize);

        gameEntryBloc.add(const GameEntryEdgeSizeEvent(edgeSize: edgeSize));

        expectLater(gameEntryBloc.stream, emits(expectedState));
      });

      test('adds a 3rd player when 2nd player bot name is changed.', () async {
        gameEntryBloc
          ..add(const GameEntryEdgeSizeEvent(edgeSize: 4))
          ..add(const GameEntryChangeNameEvent(playerNum: 2, playerName: 'Player 2b'));

        expect(gameEntryBloc.stream, emits(isA<GameEntryState>()));

        // Check state is changed to 3 players.
        expect(
          gameEntryBloc.stream,
          emitsInOrder([
            isA<GameEntryState>().having((state) => state.players.length, 'players.length', 2),
            isA<GameEntryState>().having((state) => state.players.length, 'players.length', 3),
          ]),
        );

        // Wait for bloc to process events.
        await Future<void>.delayed(Duration.zero);

        verify(() => mockScorebookRepository.scorebookDataStream).called(1);
      });

      test('starts the game with four players.', () async {
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
          ..add(const GameEntryChangeNameEvent(playerNum: 1, playerName: 'Player 1b'))
          ..add(const GameEntryStartGameEvent());

        // Wait for bloc to process events.
        await Future<void>.delayed(Duration.zero);

        verify(() => mockScorebookRepository.scorebookDataStream).called(1);
        verify(() => mockScorebookRepository.currentScorebookData).called(2);
        verify(() => mockScorebookRepository.processNewGame(any())).called(1);
      });
    });
  });
}
