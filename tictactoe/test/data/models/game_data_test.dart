// ignore_for_file: require_trailing_commas

import 'package:dev_play_tictactoe/src/data/data.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  late GameData gameData;
  late DateTime dateTime1;
  late DateTime dateTime2;
  late DateTime dateTime3;

  group('[GameData]', () {
    group('[GameData] can be instantiated:', () {
      test('GameData should be a [GameData]', () {
        gameData = GameData(
          /// Initial properties.
          gameId: 0,
          dateCreated: DateTime(2024, 5, 8),
          players: const [],

          /// Properties updated during the game.
          dateLastPlayed: DateTime(2024, 5, 8),
          plays: const [],
          gameBoard: const [],

          /// Properties stored at the end of the game.
          endGameScore: const {},
          gameStatus: const GameStatusInProgress(),
        );

        expect(gameData, isA<GameData>());
      });

      test('GameData [props] should return the correct list of properties', () {
        final dateTime = DateTime(2024, 5, 8);
        gameData = GameData(
          gameId: 0,
          dateCreated: dateTime,
          players: const [],
          dateLastPlayed: dateTime,
          plays: const [],
          gameBoard: const [],
          endGameScore: const {},
          gameStatus: const GameStatusInProgress(),
        );

        expect(
          gameData.props,
          equals([
            0,
            dateTime,
            <PlayerListByIdDef>[],
            dateTime,
            <PlayerTurn>[],
            <List<int>>[],
            <int, int>{},
            const GameStatusInProgress(),
          ]),
        );
      });
    });

    group('[GameData] copyWith:', () {
      setUp(() {
        dateTime1 = DateTime(2024, 5, 8);
        dateTime2 = DateTime(2024, 5, 9);
        dateTime3 = DateTime(2024, 5, 10);
      });

      test('copyWith method should return a new GameData object with updated values', () {
        const playerData1 = PlayerData(
          playerNum: 1,
          playerId: 0,
          playerName: 'Player 1',
          userSymbol: UserSymbolX(),
        );

        const playerData2 = PlayerData(
          playerNum: 2,
          playerId: 1,
          playerName: 'Player 2',
          userSymbol: UserSymbolO(),
        );

        const playerTurn1 = PlayerTurn(
          playerTurnId: 0,
          playerId: 0,
          duration: Duration(seconds: 1),
          occupiedBy: playerData1,
        );
        const playerTurn2 = PlayerTurn(
          playerTurnId: 1,
          playerId: 1,
          duration: Duration(seconds: 3),
          occupiedBy: playerData2,
        );

        final gameData = GameData(
          gameId: 1,
          dateCreated: dateTime1,
          players: const [
            {0: playerData1},
            {1: playerData2},
          ],
          dateLastPlayed: dateTime1,
          plays: const [],
          gameBoard: const [[]],
          endGameScore: const {0: 0},
          gameStatus: const GameStatusInProgress(),
        );

        final updatedGameData1 = gameData.copyWith(
          dateLastPlayed: dateTime2,
          plays: [playerTurn1],
          gameBoard: [
            [5]
          ],
        );

        final updatedGameData2 = updatedGameData1.copyWith(
          dateLastPlayed: dateTime3,
          plays: List.of(updatedGameData1.plays)
            ..add(playerTurn2), // plays: [...gameData.plays, playerTurn2]
          gameBoard: [
            [5],
            [7]
          ],
        );

        final updatedGameData3 = updatedGameData2.copyWith(
          endGameScore: {1: 0},
          gameStatus: const GameStatusComplete(),
        );

        /// 1
        expect(updatedGameData1.gameId, 1);
        expect(updatedGameData1.dateCreated, dateTime1);
        expect(updatedGameData1.players, const [
          {0: playerData1},
          {1: playerData2}
        ]);
        expect(updatedGameData1.dateLastPlayed, dateTime2);
        expect(updatedGameData1.plays, [playerTurn1]);
        expect(updatedGameData1.gameBoard, [
          [5]
        ]);
        expect(updatedGameData1.endGameScore, {0: 0});
        expect(updatedGameData1.gameStatus, isA<GameStatusInProgress>());

        /// 2
        expect(updatedGameData2.gameId, 1);
        expect(updatedGameData2.dateCreated, dateTime1);
        expect(updatedGameData2.players, const [
          {0: playerData1},
          {1: playerData2}
        ]);
        expect(updatedGameData2.dateLastPlayed, dateTime3);
        expect(updatedGameData2.plays, [playerTurn1, playerTurn2]);
        expect(updatedGameData2.gameBoard, [
          [5],
          [7]
        ]);
        expect(updatedGameData2.endGameScore, {0: 0});
        expect(updatedGameData2.gameStatus, isA<GameStatusInProgress>());

        /// 3
        expect(updatedGameData3.gameId, 1);
        expect(updatedGameData3.dateCreated, dateTime1);
        expect(updatedGameData3.players, const [
          {0: playerData1},
          {1: playerData2}
        ]);
        expect(updatedGameData3.dateLastPlayed, dateTime3);
        expect(updatedGameData3.plays, [playerTurn1, playerTurn2]);
        expect(updatedGameData3.gameBoard, [
          [5],
          [7]
        ]);
        expect(updatedGameData3.endGameScore, {1: 0});
        expect(updatedGameData3.gameStatus, isA<GameStatusComplete>());
      });
    });
  });
}
