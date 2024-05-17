import 'dart:convert';

import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/data/data.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('[ScorebookRepository] Testing:', () {
    test('ScorebookRepository should be a [ScorebookRepository]', () {
      final scorebookRepository = ScorebookRepository(
        storageService: MockStorageAPI(),
      );

      expect(scorebookRepository, isA<ScorebookRepository>());
    });

    test('ScorebookRepository should initialize with empty ScorebookData', () {
      final scorebookRepository = ScorebookRepository(
        storageService: MockStorageAPI(),
      );

      expect(scorebookRepository.currentScorebookData, equals(const ScorebookData()));
    });

    test('ScorebookRepository should update scorebookDataStream with new ScorebookData', () {
      final scorebookRepository = ScorebookRepository(
        storageService: MockStorageAPI(),
      );

      const newScorebookData = ScorebookData(
        allGames: {
          0: GameData(
            players: [
              PlayerData(playerId: 0, playerName: 'Player 1', playerNum: 1),
              PlayerData(playerId: 1, playerName: 'Player 2', playerNum: 2),
            ],
          ),
        },
        allPlayers: [
          PlayerData(playerId: 0, playerName: 'Player 1', playerNum: 1),
          PlayerData(playerId: 1, playerName: 'Player 2', playerNum: 2),
        ],
        currentGame: GameData(
          players: [
            PlayerData(playerId: 2, playerName: 'Player 3', playerNum: 1),
            PlayerData(playerId: 3, playerName: 'Player 4', playerNum: 2),
          ],
        ),
      );

      scorebookRepository.updateScorebookDataStream(newScorebookData);

      expect(scorebookRepository.scorebookDataStream, emits(newScorebookData));
    });

    test('ScorebookRepository should update local storage with current scorebookData', () async {
      final mockStorageAPI = MockStorageAPI();
      final scorebookRepository = ScorebookRepository(
        storageService: mockStorageAPI,
      );

      const scorebookData = ScorebookData();

      await scorebookRepository.scorebookDataVarsToStorage(scorebookData);

      verify(
        () => mockStorageAPI.prefsSetString(
          key: AppConstants.storageKeyScorebook,
          value: json.encode(scorebookData.toJson()),
        ),
      ).called(1);
    });
  });
}
