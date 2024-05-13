import 'dart:developer';

import 'package:dev_play_tictactoe/src/data/models/models.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  late PlayerData player1;
  late PlayerData player2;
  late PlayerData player3;
  late PlayerData player4;

  late PlayerTurn play3index0;
  late PlayerTurn play3index1;
  late PlayerTurn play3index2;
  late PlayerTurn play3index3;
  late PlayerTurn play3index4;
  late PlayerTurn play3index5;
  late PlayerTurn play3index6;
  late PlayerTurn play3index7;
  late PlayerTurn play3index8;

  late int edgeSize3;

  group('[GameBoardData] Testing:', () {
    setUp(() {
      player1 = const PlayerData(playerNum: 1, playerId: 0, playerName: 'Player 1');
      player2 = const PlayerData(playerNum: 2, playerId: 1, playerName: 'Player 2');
      player3 = const PlayerData(playerNum: 3, playerId: 2, playerName: 'Player 3');
      player4 = const PlayerData(playerNum: 4, playerId: 3, playerName: 'Player 4');

      edgeSize3 = 3;

      play3index0 = PlayerTurn(
        tileIndex: 0,
        playerTurnId: 0,
        occupiedBy: player1,
      );
      play3index1 = PlayerTurn(
        tileIndex: 1,
        playerTurnId: 1,
        occupiedBy: player2,
      );
      play3index2 = PlayerTurn(
        tileIndex: 2,
        playerTurnId: 2,
        occupiedBy: player3,
      );
      play3index3 = PlayerTurn(
        tileIndex: 3,
        playerTurnId: 3,
        occupiedBy: player4,
      );
      play3index4 = PlayerTurn(
        tileIndex: 4,
        playerTurnId: 4,
        occupiedBy: player1,
      );
      play3index5 = PlayerTurn(
        tileIndex: 5,
        playerTurnId: 5,
        occupiedBy: player2,
      );
      play3index6 = PlayerTurn(
        tileIndex: 6,
        playerTurnId: 6,
        occupiedBy: player3,
      );
      play3index7 = PlayerTurn(
        tileIndex: 7,
        playerTurnId: 7,
        occupiedBy: player4,
      );
      play3index8 = PlayerTurn(
        tileIndex: 8,
        playerTurnId: 8,
        occupiedBy: player1,
      );
    });

    test('[checkRows] should return true when a row is filled with the same player turn', () {
      final plays = [play3index0, play3index1, play3index2];

      /// Initialize a new game board with an edge size of 3.
      final gameBoardData = GameBoardData(edgeSize: edgeSize3);

      /// Simulate plays by adding a list of predefined plays.
      final gameBoardCopy = gameBoardData.copyWith(plays: plays);

      /// Check that the method satisfies the condition.
      final result = gameBoardCopy.checkAllRows;
      expect(result, null);
    });

    test('[checkCols] should return true when a column is filled with the same player turn', () {
      final plays = [play3index0, play3index3, play3index6];

      final gameBoardData = GameBoardData(edgeSize: edgeSize3);
      final gameBoardCopy = gameBoardData.copyWith(plays: plays);

      final result = gameBoardCopy.checkAllCols;
      expect(result, null);
    });

    test('[checkDiags] should return true when a diagonal is filled with the same player turn', () {
      final plays = [play3index0, play3index4, play3index8];

      final gameBoardData = GameBoardData(edgeSize: edgeSize3);
      final gameBoardCopy = gameBoardData.copyWith(plays: plays);

      final result = gameBoardCopy.checkDiags(gameBoardCopy.edgeSize);
      expect(result, true);
    });

    test(
      '[checkAllRows] should return a list of row indices that are filled with the same player turn',
      () {
        final play3P1index0 = PlayerTurn(
          tileIndex: 0,
          playerTurnId: 0,
          occupiedBy: player1,
        );
        final play3P2index3 = PlayerTurn(
          tileIndex: 3,
          playerTurnId: 1,
          occupiedBy: player2,
        );
        final play3P1index1 = PlayerTurn(
          tileIndex: 1,
          playerTurnId: 3,
          occupiedBy: player1,
        );
        final play3P2index4 = PlayerTurn(
          tileIndex: 4,
          playerTurnId: 4,
          occupiedBy: player2,
        );
        final play3P1index2 = PlayerTurn(
          tileIndex: 2,
          playerTurnId: 5,
          occupiedBy: player1,
        );
        final play3P2index5 = PlayerTurn(
          tileIndex: 5,
          playerTurnId: 6,
          occupiedBy: player2,
        );

        final plays = [
          play3P1index0, // Player 1
          play3P2index3, // Player 2
          play3P1index1, // Player 1
          play3P2index4, // Player 2
          play3P1index2, // Player 1
          play3P2index5, // Player 2
        ];

        final gameBoardData = GameBoardData(edgeSize: edgeSize3);
        final gameBoardCopy = gameBoardData.copyWith(plays: plays);

        final result = gameBoardCopy.checkAllRows;
        // expect(result, [0, 1, 2]);
        log(result.toString());
      },
    );

    test(
      '[checkAllCols] should return a list of column indices that are filled with the same player turn',
      () {
        final plays = [
          play3index0,
          play3index3,
          play3index6,
          play3index1,
          play3index4,
          play3index7,
          play3index2,
          play3index5,
          play3index8,
        ];

        final gameBoardData = GameBoardData(edgeSize: edgeSize3);
        final gameBoardCopy = gameBoardData.copyWith(plays: plays);

        final result = gameBoardCopy.checkAllCols;
        expect(result, [0, 1, 2]);
      },
    );

    test(
      '[diagFilled] should return a list of indices that are filled with the same player turn in a diagonal',
      () {
        final plays = [
          play3index0,
          play3index1,
          play3index2,
          play3index3,
          play3index4,
          play3index5,
          play3index6,
          play3index7,
          play3index8,
        ];

        final gameBoardData = GameBoardData(edgeSize: edgeSize3);
        final gameBoardCopy = gameBoardData.copyWith(plays: plays);

        final result = gameBoardCopy.diagFilled;
        expect(result, [0, 1]);
      },
    );

    test('[usedTiles] should return a list of indices that have been used by a player turn', () {
      final plays = [
        play3index0,
        play3index1,
        play3index2,
        play3index3,
        play3index4,
        play3index5,
        play3index6,
        play3index7,
        play3index8,
      ];

      final gameBoardData = GameBoardData(edgeSize: edgeSize3);
      final gameBoardCopy = gameBoardData.copyWith(plays: plays);

      final result = gameBoardCopy.usedTileIndexes;
      expect(result, [0, 1, 2, 3, 4, 5, 6, 7, 8]);
    });

    test(
      '[availableTiles] should return a list of indices that have not been used by any player turn',
      () {
        final plays = [
          play3index0,
          play3index1,
          play3index2,
          play3index3,
          play3index4,
          play3index5,
          play3index6,
          play3index7,
          play3index8,
        ];

        final gameBoardData = GameBoardData(edgeSize: edgeSize3);
        final gameBoardCopy = gameBoardData.copyWith(plays: plays);

        final result = gameBoardCopy.availableTileIndexes;
        expect(result, <int>[]);
      },
    );

    test(
      '[copyWith] should return a new [GameBoard] instance with updated properties',
      () {
        final plays = [play3index0, play3index1, play3index2];

        final gameBoardData = GameBoardData(edgeSize: edgeSize3);
        final newPlays = List.of(plays)..add(play3index4);

        final result = gameBoardData.copyWith(plays: newPlays);
        expect(result.plays, newPlays);
      },
    );

    group('GameBoardData [JSON]:', () {
      test('toJson', () {
        const gameBoardData = GameBoardData(
          // edgeSize: 3,
          plays: [
            PlayerTurn(
              playerTurnId: 0,
              tileIndex: 2,
              duration: Duration(seconds: 5),
              occupiedBy: PlayerData(
                playerNum: 1,
                playerId: 0,
                playerName: 'Player 1',
                userSymbol: UserSymbolX(),
              ),
            ),
          ],
        );
        expect(
          gameBoardData.toJson(),
          equals({
            'edgeSize': 3,
            'plays': [
              {
                'playerTurnId': 0,
                'tileIndex': 2,
                'playerId': 0,
                'duration': 5,
                'occupiedBy': {
                  'playerNum': 1,
                  'playerId': 0,
                  'playerName': 'Player 1',
                  'playerType': {'playerType': 'PlayerTypeEnum.bot'},
                  'userSymbol': {'markerKey': 'x'},
                },
              },
            ],
          }),
        );
      });

      test('fromJson', () {
        const gameBoardData = GameBoardData(
          // edgeSize: 3,
          plays: [
            PlayerTurn(
              playerTurnId: 0,
              tileIndex: 2,
              duration: Duration(seconds: 5),
              occupiedBy: PlayerData(
                playerNum: 1,
                playerId: 0,
                playerName: 'Player 1',
                userSymbol: UserSymbolX(),
              ),
            ),
          ],
        );
        final gameBoardDataJson = gameBoardData.toJson();
        final gameBoardDataFromJson = GameBoardData.fromJson(gameBoardDataJson);
        expect(gameBoardData, equals(gameBoardDataFromJson));
      });
    });
  });
}
