import 'package:dev_play_tictactoe/src/data/models/models.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[ScorebookData] Testing:', () {
    test('[startGame] should initialize the scorebook with a new game.', () {
      const gameData = GameData(
        gameId: 0,
        players: [
          PlayerData(playerId: 0, playerName: 'Player 1', playerNum: 1),
          PlayerData(playerId: 1, playerName: 'Player 2', playerNum: 2),
        ],
      );
      final scorebookData = const ScorebookData().startGame(gameData);

      // Assert that the current game is set correctly.
      expect(scorebookData.currentGame, gameData);

      // Assert that the `allPlayers` list is updated with the players from the game data.
      expect(scorebookData.allPlayers, gameData.players);
    });

    test('[updateGame] should update the current game in progress.', () {
      const gameData = GameData(
        gameId: 0,
        players: [
          PlayerData(playerId: 0, playerName: 'Player 1', playerNum: 1),
          PlayerData(playerId: 1, playerName: 'Player 2', playerNum: 2),
        ],
      );
      final scorebookData = const ScorebookData().updateGame(gameData);

      // Assert that the current game is updated correctly.
      expect(scorebookData.currentGame, gameData);
    });

    test('[endGame] should record the game in the scorebook.', () {
      const gameData = GameData(
        gameId: 0,
        players: [
          PlayerData(playerId: 0, playerName: 'Player 1', playerNum: 1),
          PlayerData(playerId: 1, playerName: 'Player 2', playerNum: 2),
        ],
      );
      final scorebookData = const ScorebookData().endGame(gameData);

      // Assert that the game is added to the allGames map with the correct gameId.
      expect(scorebookData.allGames[gameData.gameId], gameData);

      // Assert that the current game is reset to an empty GameData object.
      expect(scorebookData.currentGame, const GameData());
    });

    test('[copyWith] should return a new ScorebookData object with updated properties.', () {
      const scorebookData = ScorebookData(
        allPlayers: [
          PlayerData(playerId: 0, playerName: 'Player 1', playerNum: 1),
          PlayerData(playerId: 1, playerName: 'Player 2', playerNum: 2),
        ],
        allGames: {
          0: GameData(
            gameId: 0,
            players: [
              PlayerData(playerId: 0, playerName: 'Player 1', playerNum: 1),
              PlayerData(playerId: 1, playerName: 'Player 2', playerNum: 2),
            ],
          ),
        },
        currentGame: GameData(
          gameId: 1,
          players: [
            PlayerData(playerId: 2, playerName: 'Player 3', playerNum: 1),
            PlayerData(playerId: 3, playerName: 'Player 4', playerNum: 2),
          ],
        ),
      );
      final newScorebookData = scorebookData.copyWith(
        currentGame: const GameData(),
      );

      // Assert that the new ScorebookData object has the updated currentGame property.
      expect(newScorebookData.currentGame, const GameData());
    });

    test(
        'ScorebookData [should be equal] to another ScorebookData object with the same properties.',
        () {
      const scorebookData1 = ScorebookData(
        allPlayers: [
          PlayerData(playerId: 0, playerName: 'Player 1', playerNum: 1),
          PlayerData(playerId: 1, playerName: 'Player 2', playerNum: 2),
        ],
        allGames: {
          0: GameData(
            gameId: 0,
            players: [
              PlayerData(playerId: 0, playerName: 'Player 1', playerNum: 1),
              PlayerData(playerId: 1, playerName: 'Player 2', playerNum: 2),
            ],
          ),
        },
        currentGame: GameData(
          gameId: 1,
          players: [
            PlayerData(playerId: 2, playerName: 'Player 3', playerNum: 1),
            PlayerData(playerId: 3, playerName: 'Player 4', playerNum: 2),
          ],
        ),
      );
      const scorebookData2 = ScorebookData(
        allPlayers: [
          PlayerData(playerId: 0, playerName: 'Player 1', playerNum: 1),
          PlayerData(playerId: 1, playerName: 'Player 2', playerNum: 2),
        ],
        allGames: {
          0: GameData(
            gameId: 0,
            players: [
              PlayerData(playerId: 0, playerName: 'Player 1', playerNum: 1),
              PlayerData(playerId: 1, playerName: 'Player 2', playerNum: 2),
            ],
          ),
        },
        currentGame: GameData(
          gameId: 1,
          players: [
            PlayerData(playerId: 2, playerName: 'Player 3', playerNum: 1),
            PlayerData(playerId: 3, playerName: 'Player 4', playerNum: 2),
          ],
        ),
      );

      // Assert that the two ScorebookData objects are equal.
      expect(scorebookData1, scorebookData2);
    });
  });
}
