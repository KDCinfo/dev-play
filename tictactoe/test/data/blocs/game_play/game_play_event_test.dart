// ignore_for_file: prefer_const_constructors

import 'package:dev_play_tictactoe/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactoe/src/data/models/models.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[GamePlayEvent] Testing:', () {
    group('[GamePlayUpdatedEvent]', () {
      test('supports value [equality]', () {
        expect(
          GamePlayUpdatedEvent(
            gameData: GameData(),
          ),
          equals(
            GamePlayUpdatedEvent(
              gameData: GameData(),
            ),
          ),
        );
      });

      test('[props] are correct', () {
        expect(
          GamePlayUpdatedEvent(
            gameData: GameData(),
          ).props,
          equals(<Object?>[
            GameData(),
          ]),
        );
      });
    });

    group('[GamePlayMoveEvent]', () {
      test('supports value [equality]', () {
        expect(
          GamePlayMoveEvent(
            tileIndex: 3,
          ),
          equals(
            GamePlayMoveEvent(
              tileIndex: 3,
            ),
          ),
        );
      });

      test('[props] are correct', () {
        expect(
          GamePlayMoveEvent(
            tileIndex: 3,
          ).props,
          equals(<Object?>[
            3,
          ]),
        );
      });
    });

    group('[GamePlayEndGameEvent]', () {
      test('supports value [equality]', () {
        expect(
          GamePlayEndGameEvent(
            gameData: GameData(
              endGameScore: const <int, int>{0: 1},
              gameStatus: const GameStatusComplete(),
            ),
          ),
          equals(
            GamePlayEndGameEvent(
              gameData: GameData(
                endGameScore: const <int, int>{0: 1},
                gameStatus: const GameStatusComplete(),
              ),
            ),
          ),
        );
      });

      test('[props] are correct', () {
        expect(
          GamePlayEndGameEvent(
            gameData: GameData(
              endGameScore: const <int, int>{0: 1},
              gameStatus: const GameStatusComplete(),
            ),
          ).props,
          equals(<Object?>[
            GameData(
              endGameScore: const <int, int>{0: 1},
              gameStatus: const GameStatusComplete(),
            ),
          ]),
        );
      });
    });
  });
}
