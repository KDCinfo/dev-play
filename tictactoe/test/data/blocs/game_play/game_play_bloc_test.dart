import 'package:bloc_test/bloc_test.dart';

import 'package:dev_play_tictactoe/src/data/data.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

void main() {
  late MockScorebookRepository mockScorebookRepository;
  late GamePlayBloc gamePlayBloc;

  group('[GamePlayBloc] Testing:', () {
    setUpAll(() {
      registerFallbackValue(
        const ScorebookData(),
      );
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
