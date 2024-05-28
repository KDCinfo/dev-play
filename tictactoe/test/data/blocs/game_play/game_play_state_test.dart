// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:dev_play_tictactuple/src/data/data.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[GamePlayState] Testing:', () {
    GamePlayState createSubject({
      GameData? currentGame,
    }) {
      return GamePlayState(
        currentGame: currentGame ?? const GameData(),
      );
    }

    test('supports value [equality].', () {
      expect(
        createSubject(),
        equals(createSubject()),
      );
    });

    test('[props] are correct.', () {
      expect(
        createSubject().props,
        equals(<Object?>[
          createSubject().currentGame,
        ]),
      );
    });

    group('[copyWith]', () {
      test('returns the [same object if no arguments] are provided.', () {
        expect(
          createSubject().copyWith(
            currentGame: createSubject(
              currentGame: const GameData(gameStatus: GameStatusComplete()),
            ).currentGame,
          ),
          equals(
            createSubject(currentGame: const GameData(gameStatus: GameStatusComplete())),
          ),
        );
      });

      test('retains the old value for every parameter if [null] is provided.', () {
        expect(
          createSubject().copyWith(
            currentGame: null,
          ),
          equals(
            createSubject(currentGame: null),
          ),
        );
      });

      test('replaces every [non-null] parameter.', () {
        expect(
          createSubject().copyWith(
            currentGame: GameData(
              gameStatus: GameStatusComplete(),
            ),
          ),
          equals(
            createSubject(
              currentGame: GameData(
                gameStatus: GameStatusComplete(),
              ),
            ),
          ),
        );
      });
    });
  });
}
