// ignore_for_file: prefer_const_constructors

import 'package:dev_play_tictactuple/src/data/blocs/game_entry/game_entry_bloc.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('[GameEntryEvent] Testing:', () {
    group('[GameEntryUpdateEvent]', () {
      test('supports value [equality]', () {
        expect(
          GameEntryUpdateEvent(
            edgeSize: 4,
            players: playerList,
            allSavedPlayerNames: const ['Player 1', 'Player 2'],
          ),
          equals(
            GameEntryUpdateEvent(
              edgeSize: 4,
              players: playerList,
              allSavedPlayerNames: const ['Player 1', 'Player 2'],
            ),
          ),
        );
      });

      test('[props] are correct', () {
        expect(
          GameEntryUpdateEvent(
            edgeSize: 4,
            players: playerList,
            allSavedPlayerNames: const ['Player 1', 'Player 2'],
          ).props,
          equals(<Object?>[
            4,
            playerList,
            const <String>['Player 1', 'Player 2'],
          ]),
        );
      });
    });

    group('[GameEntrySymbolSelectedEvent]', () {
      test('supports value [equality]', () {
        expect(
          GameEntrySymbolSelectedEvent(
            playerNum: 1,
            selectedSymbolKey: '*',
          ),
          equals(
            GameEntrySymbolSelectedEvent(
              playerNum: 1,
              selectedSymbolKey: '*',
            ),
          ),
        );
      });

      test('[props] are correct', () {
        expect(
          GameEntrySymbolSelectedEvent(
            playerNum: 1,
            selectedSymbolKey: '*',
          ).props,
          equals(<Object?>[
            1,
            '*',
          ]),
        );
      });
    });

    group('[GameEntryChangeNameEvent]', () {
      test('supports value [equality]', () {
        expect(
          const GameEntryChangeNameEvent(playerNum: 1, playerName: 'Player 1'),
          equals(
            const GameEntryChangeNameEvent(playerNum: 1, playerName: 'Player 1'),
          ),
        );
      });

      test('[props] are correct', () {
        expect(
          const GameEntryChangeNameEvent(playerNum: 1, playerName: 'Player 1').props,
          equals(<Object?>[
            1,
            'Player 1',
          ]),
        );
      });
    });

    group('[GameEntryEdgeSizeEvent]', () {
      test('supports value [equality]', () {
        expect(
          GameEntryEdgeSizeEvent(
            edgeSize: 4,
          ),
          equals(
            GameEntryEdgeSizeEvent(
              edgeSize: 4,
            ),
          ),
        );
      });

      test('[props] are correct', () {
        expect(
          GameEntryEdgeSizeEvent(
            edgeSize: 4,
          ).props,
          equals(<Object?>[
            4,
          ]),
        );
      });
    });

    group('[GameEntryStartGameEvent]', () {
      test('supports value [equality]', () {
        expect(
          GameEntryStartGameEvent(),
          equals(
            GameEntryStartGameEvent(),
          ),
        );
      });

      test('[props] are correct', () {
        expect(
          GameEntryStartGameEvent().props,
          equals(<Object?>[]),
        );
      });
    });

    group('[GameEntryResetGameEvent]', () {
      test('supports value [equality]', () {
        expect(
          GameEntryResetGameEvent(),
          equals(
            GameEntryResetGameEvent(),
          ),
        );
      });

      test('[props] are correct', () {
        expect(
          GameEntryResetGameEvent().props,
          equals(<Object?>[]),
        );
      });
    });

    group('[GameEntryResumeGameEvent]', () {
      test('supports value [equality]', () {
        expect(
          GameEntryResumeGameEvent(),
          equals(
            GameEntryResumeGameEvent(),
          ),
        );
      });

      test('[props] are correct', () {
        expect(
          GameEntryResumeGameEvent().props,
          equals(<Object?>[]),
        );
      });
    });
  });
}
