import 'package:dev_play_tictactoe/src/data/models/models.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  late int edgeSize3;

  // Initialize players.
  late PlayerData player1;
  late PlayerData player2;
  late PlayerData player3;
  late PlayerData player4;

  // Initialize function variables at the same scope as players.
  late PlayerTurn Function({required int tileIndex, required int playerTurnId}) playPlayer1;
  late PlayerTurn Function({required int tileIndex, required int playerTurnId}) playPlayer2;
  late PlayerTurn Function({required int tileIndex, required int playerTurnId}) playPlayer3;
  late PlayerTurn Function({required int tileIndex, required int playerTurnId}) playPlayer4;

  group('[GameBoardData] Testing:', () {
    setUp(() {
      player1 = const PlayerData(playerNum: 1, playerId: 0, playerName: 'Player 1');
      player2 = const PlayerData(playerNum: 2, playerId: 1, playerName: 'Player 2');
      player3 = const PlayerData(playerNum: 3, playerId: 2, playerName: 'Player 3');
      player4 = const PlayerData(playerNum: 4, playerId: 3, playerName: 'Player 4');

      playPlayer1 = ({required int tileIndex, required int playerTurnId}) => PlayerTurn(
            tileIndex: tileIndex,
            playerTurnId: playerTurnId,
            occupiedBy: player1,
          );
      playPlayer2 = ({required int tileIndex, required int playerTurnId}) => PlayerTurn(
            tileIndex: tileIndex,
            playerTurnId: playerTurnId,
            occupiedBy: player2,
          );
      playPlayer3 = ({required int tileIndex, required int playerTurnId}) => PlayerTurn(
            tileIndex: tileIndex,
            playerTurnId: playerTurnId,
            occupiedBy: player3,
          );
      playPlayer4 = ({required int tileIndex, required int playerTurnId}) => PlayerTurn(
            tileIndex: tileIndex,
            playerTurnId: playerTurnId,
            occupiedBy: player4,
          );
    });

    group('[constructor] works.:', () {});

    group('[props] are correct:', () {});

    group('[changeEdgeSize] works:', () {});

    group('[boardSize] is correct:', () {});

    group('with an edgeSize of [3]:', () {
      setUp(() {
        edgeSize3 = 3;
      });

      test('all tiles played with no winner should return [null].', () {
        final plays = [
          playPlayer1(playerTurnId: 0, tileIndex: 0),
          playPlayer2(playerTurnId: 1, tileIndex: 1),
          playPlayer3(playerTurnId: 2, tileIndex: 2),
          playPlayer4(playerTurnId: 3, tileIndex: 3),
          playPlayer1(playerTurnId: 4, tileIndex: 4),
          playPlayer2(playerTurnId: 5, tileIndex: 5),
          playPlayer3(playerTurnId: 6, tileIndex: 6),
          playPlayer4(playerTurnId: 7, tileIndex: 8),
          playPlayer1(playerTurnId: 8, tileIndex: 7),
        ];

        /// Initialize a new game board with an edge size of 3.
        final gameBoardData = GameBoardData(edgeSize: edgeSize3);

        /// Simulate plays by adding a list of predefined plays.
        final gameBoardCopy = gameBoardData.copyWith(plays: plays);

        /// Check that the method satisfies the condition.
        final result = gameBoardCopy.checkAllRows;
        expect(result, null);
      });

      test(
          '[checkAllRows] should return a record when '
          'the first row is filled with the same player turn', () {
        final plays = [
          playPlayer1(playerTurnId: 0, tileIndex: 0),
          playPlayer2(playerTurnId: 1, tileIndex: 3),
          playPlayer1(playerTurnId: 2, tileIndex: 1),
          playPlayer2(playerTurnId: 3, tileIndex: 4),
          playPlayer1(playerTurnId: 4, tileIndex: 2),
        ];

        /// Initialize a new game board with an edge size of 3.
        final gameBoardData = GameBoardData(edgeSize: edgeSize3);

        /// Simulate plays by adding a list of predefined plays.
        final gameBoardCopy = gameBoardData.copyWith(plays: plays);

        /// Check that the method satisfies the condition.
        final result = gameBoardCopy.checkAllRows;

        // ( Group index: 0, playerId: 0 (player 1) )
        expect(result, (0, 0));
      });

      test(
          '[checkAllCols] should return a record when '
          'the first column is filled with the same player turn', () {
        final plays = [
          playPlayer1(playerTurnId: 0, tileIndex: 0),
          playPlayer2(playerTurnId: 1, tileIndex: 1),
          playPlayer1(playerTurnId: 2, tileIndex: 3),
          playPlayer2(playerTurnId: 3, tileIndex: 4),
          playPlayer1(playerTurnId: 4, tileIndex: 6),
        ];

        final gameBoardData = GameBoardData(edgeSize: edgeSize3);
        final gameBoardCopy = gameBoardData.copyWith(plays: plays);

        final result = gameBoardCopy.checkAllCols;

        // ( Group index: 0, playerId: 0 (player 1) )
        expect(result, (0, 0));
      });

      test(
        '[diagFilled] should return a list of indices that are filled with the same player turn in a diagonal',
        () {
          // Player 2 wins with the reverse (2nd) diag.
          final plays = [
            playPlayer1(playerTurnId: 0, tileIndex: 0),
            playPlayer2(playerTurnId: 1, tileIndex: 2),
            playPlayer1(playerTurnId: 2, tileIndex: 1),
            playPlayer2(playerTurnId: 3, tileIndex: 4),
            playPlayer1(playerTurnId: 4, tileIndex: 5),
            playPlayer2(playerTurnId: 5, tileIndex: 6),
          ];

          final gameBoardData = GameBoardData(edgeSize: edgeSize3);
          final gameBoardCopy = gameBoardData.copyWith(plays: plays);

          final result = gameBoardCopy.checkAllDiags;
          // ( Group index: 1, playerId: 1 (player 2) )
          expect(result, (1, 1));
        },
      );

      test('[usedTiles] should return a list of indices that have been used by a player turn', () {
        final plays = [
          playPlayer1(playerTurnId: 0, tileIndex: 0),
          playPlayer2(playerTurnId: 1, tileIndex: 2),
          playPlayer1(playerTurnId: 2, tileIndex: 1),
          playPlayer2(playerTurnId: 3, tileIndex: 4),
          playPlayer1(playerTurnId: 4, tileIndex: 5),
          playPlayer2(playerTurnId: 5, tileIndex: 6),
        ];

        final gameBoardData = GameBoardData(edgeSize: edgeSize3);
        final gameBoardCopy = gameBoardData.copyWith(plays: plays);

        // This returns a simple incremental list with all used indexes.
        // Note: it will not be in the played tile index order;
        //       notice `tileIndex` [2, 1] becomes [1, 2].
        final result = gameBoardCopy.usedTileIndexes;
        expect(result, [0, 1, 2, 4, 5, 6]);
      });

      test(
        '[availableTiles] should return a list of indices that have not been used by any player turn',
        () {
          final plays = [
            playPlayer1(playerTurnId: 0, tileIndex: 0),
            playPlayer2(playerTurnId: 1, tileIndex: 2),
            playPlayer1(playerTurnId: 2, tileIndex: 1),
            playPlayer2(playerTurnId: 3, tileIndex: 4),
            playPlayer1(playerTurnId: 4, tileIndex: 5),
            playPlayer2(playerTurnId: 5, tileIndex: 6),
          ];

          final gameBoardData = GameBoardData(edgeSize: edgeSize3);
          final gameBoardCopy = gameBoardData.copyWith(plays: plays);

          final result = gameBoardCopy.availableTileIndexes;
          expect(result, <int>[3, 7, 8]);
        },
      );

      test(
        '[copyWith] should return a new [GameBoard] instance with updated properties',
        () {
          final plays = [
            playPlayer1(playerTurnId: 0, tileIndex: 0),
            playPlayer2(playerTurnId: 1, tileIndex: 2),
            playPlayer1(playerTurnId: 2, tileIndex: 1),
          ];

          final gameBoardData = GameBoardData(edgeSize: edgeSize3);
          final newPlays = List.of(plays)
            ..add(
              playPlayer2(playerTurnId: 3, tileIndex: 4),
            );

          final result = gameBoardData.copyWith(plays: newPlays);
          expect(result.plays, newPlays);
        },
      );
    });

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
