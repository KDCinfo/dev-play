import 'package:bloc_test/bloc_test.dart';

import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/data.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

void main() {
  late MockScorebookRepository mockScorebookRepository;
  late GamePlayBloc gamePlayBloc;

  group('[GamePlayBloc] Testing:', () {
    setUpAll(() {
      registerFallbackValue(const ScorebookData());
      registerFallbackValue(const GameData());
    });

    setUp(() {
      mockScorebookRepository = MockScorebookRepository();
      when(() => mockScorebookRepository.scorebookDataStream)
          .thenAnswer((_) => Stream.value(const ScorebookData()));
      gamePlayBloc = GamePlayBloc(scorebookRepository: mockScorebookRepository);
    });

    tearDown(() {
      gamePlayBloc.close();
    });

    // Group: General bloc tests
    group('[blocTest] Testing:', () {
      blocTest<GamePlayBloc, GamePlayState>(
        'emits state when current game status is updated.',
        setUp: () {
          when(() => mockScorebookRepository.currentScorebookData).thenReturn(
            const ScorebookData(),
          );
        },
        build: () => gamePlayBloc,
        act: (bloc) => bloc.add(
          const GamePlayUpdatedEvent(gameData: GameData(gameStatus: GameStatusComplete())),
        ),
        expect: () => const <GamePlayState>[
          GamePlayState(currentGame: GameData(gameStatus: GameStatusComplete())),
        ],
      );

      blocTest<GamePlayBloc, GamePlayState>(
        'emits expected state when a move is made.',
        setUp: () {
          when(() => mockScorebookRepository.currentScorebookData).thenReturn(
            const ScorebookData(),
          );
          gamePlayBloc.add(
            GamePlayUpdatedEvent(
              gameData: GameData(
                players: AppConstants.playerListDefault
                    .map(
                      (e) => e.copyWith(playerId: e.playerNum),
                    )
                    .toList(),
              ),
            ),
          );
        },
        build: () => gamePlayBloc,
        act: (bloc) => bloc.add(
          const GamePlayMoveEvent(tileIndex: 1),
        ),
        expect: () => const <GamePlayState>[
          // No state is emitted when a move is made
          // until the repository updates its stream,
          // then the stream listener will update the bloc state.
        ],
      );

      blocTest<GamePlayBloc, GamePlayState>(
        'makes expected calls when initial move is made.',
        setUp: () {
          when(() => mockScorebookRepository.currentScorebookData).thenReturn(
            const ScorebookData(),
          );
          gamePlayBloc.add(
            GamePlayUpdatedEvent(
              gameData: GameData(
                players: AppConstants.playerListDefault
                    .map(
                      (e) => e.copyWith(playerId: e.playerNum),
                    )
                    .toList(),
              ),
            ),
          );
        },
        build: () => gamePlayBloc,
        act: (bloc) => bloc.add(const GamePlayMoveEvent(tileIndex: 4)),
        verify: (_) async {
          verify(
            () => mockScorebookRepository.playTurn(
              currentGame: any(named: 'currentGame'),
              tileIndex: any(named: 'tileIndex'),
            ),
          ).called(1);
        },
      );

      blocTest<GamePlayBloc, GamePlayState>(
        'makes expected calls when a move is made.',
        setUp: () {
          when(() => mockScorebookRepository.currentScorebookData)
              .thenReturn(const ScorebookData());
          gamePlayBloc.add(
            GamePlayUpdatedEvent(
              gameData: GameData(
                players: AppConstants.playerListDefault
                    .map((e) => e.copyWith(playerId: e.playerNum))
                    .toList(),
                gameBoardData: const GameBoardData(
                  plays: [
                    PlayerTurn(tileIndex: 0, playerTurnId: 0, occupiedById: 0),
                    PlayerTurn(tileIndex: 1, playerTurnId: 1, occupiedById: 1),
                  ],
                ),
              ),
            ),
          );
        },
        build: () => gamePlayBloc,
        act: (bloc) => bloc.add(const GamePlayMoveEvent(tileIndex: 4)),
        verify: (_) async {
          verify(
            () => mockScorebookRepository.playTurn(
              currentGame: any(named: 'currentGame'),
              tileIndex: any(named: 'tileIndex'),
            ),
          ).called(1);
        },
      );

      blocTest<GamePlayBloc, GamePlayState>(
        'makes no calls when a tile is already played.',
        setUp: () {
          when(() => mockScorebookRepository.currentScorebookData)
              .thenReturn(const ScorebookData());
          gamePlayBloc.add(
            GamePlayUpdatedEvent(
              gameData: GameData(
                players: AppConstants.playerListDefault
                    .map((e) => e.copyWith(playerId: e.playerNum))
                    .toList(),
                gameBoardData: const GameBoardData(
                  plays: [
                    PlayerTurn(tileIndex: 0, playerTurnId: 0, occupiedById: 0),
                    PlayerTurn(tileIndex: 3, playerTurnId: 1, occupiedById: 1),
                  ],
                ),
              ),
            ),
          );
        },
        build: () => gamePlayBloc,
        act: (bloc) => bloc.add(const GamePlayMoveEvent(tileIndex: 3)),
        verify: (_) async {
          verifyNever(() => mockScorebookRepository.currentScorebookData);
          verifyNever(() => mockScorebookRepository.updateGame(any()));
        },
      );
    });

    // Group: Event tests
    group('[Unit] Testing:', () {
      group('constructor', () {
        test(
          'works properly',
          () => expect(() => gamePlayBloc, returnsNormally),
        );

        test('has correct initial state', () {
          expect(
            gamePlayBloc.state,
            equals(
              const GamePlayState(),
            ),
          );
        });
      });

      test('updates the game status.', () {
        final expectedState = gamePlayBloc.state.copyWith(
          currentGame: gamePlayBloc.state.currentGame.copyWith(
            gameStatus: const GameStatusComplete(),
          ),
        );

        gamePlayBloc.add(
          const GamePlayUpdatedEvent(
            gameData: GameData(gameStatus: GameStatusComplete()),
          ),
        );

        expectLater(gamePlayBloc.stream, emits(expectedState));
      });
    });
  });
}
