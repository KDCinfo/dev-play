// ignore_for_file: prefer_const_constructors

import 'package:dev_play_tictactoe/src/data/blocs/game_entry/game_entry_bloc.dart';

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
            allSavedPlayerNames: const <String>['Player 1', 'Player 2'],
          ),
          equals(
            GameEntryUpdateEvent(
              edgeSize: 4,
              players: playerList,
              allSavedPlayerNames: const <String>['Player 1', 'Player 2'],
            ),
          ),
        );
      });

      test('[props] are correct', () {
        expect(
          GameEntryUpdateEvent(
            edgeSize: 4,
            players: playerList,
            allSavedPlayerNames: const <String>['Player 1', 'Player 2'],
          ).props,
          equals(<Object?>[
            4,
            playerList,
            const <String>['Player 1', 'Player 2'],
          ]),
        );
      });
    });

    group('[GameEntryNameSelectedEvent]', () {
      test('supports value [equality]', () {
        expect(
          GameEntryNameSelectedEvent(
            playerNum: 1,
            selectedPlayerName: 'Player 1',
          ),
          equals(
            GameEntryNameSelectedEvent(
              playerNum: 1,
              selectedPlayerName: 'Player 1',
            ),
          ),
        );
      });

      test('[props] are correct', () {
        expect(
          GameEntryNameSelectedEvent(
            playerNum: 1,
            selectedPlayerName: 'Player 1',
          ).props,
          equals(<Object?>[
            1,
            'Player 1',
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

    group('[GameEntryPlayerListEvent]', () {
      test('supports value [equality]', () {
        expect(
          GameEntryPlayerListEvent(
            playerList: playerList,
          ),
          equals(
            GameEntryPlayerListEvent(
              playerList: playerList,
            ),
          ),
        );
      });

      test('[props] are correct', () {
        expect(
          GameEntryPlayerListEvent(
            playerList: playerList,
          ).props,
          equals(<Object?>[
            playerList,
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
  });
}
