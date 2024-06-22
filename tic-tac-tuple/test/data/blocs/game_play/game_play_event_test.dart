// ignore_for_file: prefer_const_constructors

import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[GamePlayEvent] Testing:', () {
    group('[GamePlayUpdatedEvent]', () {
      test('supports value [equality]', () {
        expect(
          GamePlayUpdatedEvent(
            gameDataCurrent: GameData(),
          ),
          equals(
            GamePlayUpdatedEvent(
              gameDataCurrent: GameData(),
            ),
          ),
        );
      });

      test('[props] are correct', () {
        expect(
          GamePlayUpdatedEvent(
            gameDataCurrent: GameData(),
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
          GamePlayReturnHomeEvent(
            gameDataReset: GameData(
              gameStatus: const GameStatusComplete(),
            ),
            gameDataPaused: GameData(),
          ),
          equals(
            GamePlayReturnHomeEvent(
              gameDataReset: GameData(
                gameStatus: const GameStatusComplete(),
              ),
              gameDataPaused: GameData(),
            ),
          ),
        );
      });

      test('[props] are correct', () {
        expect(
          GamePlayReturnHomeEvent(
            gameDataReset: GameData(
              winnerId: 6,
              gameStatus: const GameStatusComplete(),
            ),
            gameDataPaused: GameData(),
          ).props,
          equals(<Object?>[
            GameData(
              winnerId: 6,
              gameStatus: const GameStatusComplete(),
            ),
            GameData(),
          ]),
        );
      });
    });

    group('[GamePlayResetGameEvent]', () {
      test('supports value [equality]', () {
        expect(
          GamePlayResetGameEvent(),
          equals(
            GamePlayResetGameEvent(),
          ),
        );
      });

      test('[props] are correct', () {
        expect(
          GamePlayResetGameEvent().props,
          equals(<Object?>[]),
        );
      });
    });

    group('[GamePlayBotMoveRequestedEvent]', () {
      test('supports value [equality]', () {
        expect(
          GamePlayBotMoveRequestedEvent(),
          equals(
            GamePlayBotMoveRequestedEvent(),
          ),
        );
      });

      test('[props] are correct', () {
        expect(
          GamePlayBotMoveRequestedEvent().props,
          equals(<Object?>[]),
        );
      });
    });
  });
}
