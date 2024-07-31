// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:dev_play_tictactuple/src/data/data.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('[GameEntryState] Testing:', () {
    GameEntryState createSubject({
      int edgeSize = 4,
      List<PlayerData> players = const <PlayerData>[],
      List<String> allSavedPlayerNames = const <String>[],
    }) {
      return GameEntryState(
        edgeSize: edgeSize,
        players: players,
        allSavedPlayerNames: allSavedPlayerNames,
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
        createSubject(
          edgeSize: 4,
          players: playerList,
          allSavedPlayerNames: const [],
        ).props,
        equals(<Object?>[
          4,
          playerList,
          const <String>[],
        ]),
      );
    });

    group('[copyWith]', () {
      test('returns the [same object if no arguments] are provided.', () {
        expect(
          createSubject().copyWith(),
          equals(createSubject()),
        );
      });

      test('retains the old value for every parameter if [null] is provided.', () {
        expect(
          createSubject().copyWith(
            edgeSize: null,
            players: null,
            allSavedPlayerNames: null,
          ),
          equals(createSubject()),
        );
      });

      test('replaces every [non-null] parameter.', () {
        expect(
          createSubject().copyWith(
            edgeSize: 5,
            players: playerListAddOne,
            allSavedPlayerNames: const ['player1'],
          ),
          equals(
            createSubject(
              edgeSize: 5,
              players: playerListAddOne,
              allSavedPlayerNames: const ['player1'],
            ),
          ),
        );
      });
    });
  });
}
