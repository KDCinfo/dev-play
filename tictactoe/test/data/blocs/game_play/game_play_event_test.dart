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
  });
}
