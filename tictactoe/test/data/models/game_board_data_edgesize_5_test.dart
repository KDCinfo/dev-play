import 'package:dev_play_tictactoe/src/data/models/models.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  const edgeSizeConstant = 5;

  late int edgeSize;
  late int edgeSize2;

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

    group('[changeEdgeSize]', () {
      setUp(() {
        edgeSize = edgeSizeConstant;
        edgeSize2 = 3;
      });
      test('works.', () {
        final gameBoardDataBase = GameBoardData(edgeSize: edgeSize);
        final gameBoardDataTarget = gameBoardDataBase.changeEdgeSize(edgeSize: edgeSize2);
        expect(
          gameBoardDataBase.edgeSize,
          equals(edgeSize),
        );
        expect(
          gameBoardDataBase.boardSize,
          equals(edgeSize * edgeSize),
        );
        expect(
          gameBoardDataTarget.edgeSize,
          equals(edgeSize2),
        );
        expect(
          gameBoardDataTarget.boardSize,
          equals(edgeSize2 * edgeSize2),
        );
      });
    });

    group('with an edgeSize of [5]:', () {
      setUp(() {
        edgeSize = edgeSizeConstant;
      });

      group('[boardSize]', () {
        test('is correct.', () {
          final gameBoardData = GameBoardData(edgeSize: edgeSize);
          expect(
            gameBoardData.boardSize,
            equals(edgeSize * edgeSize),
          );
        });
      });

      group('[constructor]', () {
        test('works properly.', () {
          expect(
            GameBoardData(edgeSize: edgeSize),
            isNotNull,
          );
        });

        test('is the expected type.', () {
          expect(
            GameBoardData(edgeSize: edgeSize),
            isA<GameBoardData>(),
          );
        });

        test(
          '[copyWith] should return a new [GameBoard] instance with updated properties',
          () {
            final plays = [
              playPlayer1(playerTurnId: 0, tileIndex: 0),
              playPlayer2(playerTurnId: 1, tileIndex: 2),
              playPlayer1(playerTurnId: 2, tileIndex: 1),
            ];

            final gameBoardData = GameBoardData(edgeSize: edgeSize);
            final newPlays = List.of(plays)
              ..add(
                playPlayer2(playerTurnId: 3, tileIndex: 4),
              );

            final result = gameBoardData.copyWith(plays: newPlays);
            expect(result.plays, newPlays);
          },
        );
      });

      group('[props]', () {
        test(' are correct.', () {
          final gameBoardData = GameBoardData(edgeSize: edgeSize);

          expect(
            gameBoardData.props,
            equals([
              edgeSize,
              <PlayerTurn>[],
            ]),
          );
        });
      });

      group('GameBoardData [JSON]:', () {
        test('toJson', () {
          final gameBoardData = GameBoardData(
            edgeSize: edgeSize,
            plays: const [
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
              'edgeSize': edgeSize,
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
          final gameBoardData = GameBoardData(
            edgeSize: edgeSize,
            plays: const [
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

      test('all tiles played with no winner should return [null].', () {
        final plays = [
          playPlayer1(playerTurnId: 0, tileIndex: 0),
          playPlayer2(playerTurnId: 1, tileIndex: 1),
          playPlayer3(playerTurnId: 2, tileIndex: 2),
          playPlayer4(playerTurnId: 3, tileIndex: 3),
          playPlayer1(playerTurnId: 4, tileIndex: 4),
          playPlayer2(playerTurnId: 5, tileIndex: 5),
          playPlayer3(playerTurnId: 6, tileIndex: 6),
          playPlayer4(playerTurnId: 7, tileIndex: 7),
          playPlayer1(playerTurnId: 8, tileIndex: 8),
          playPlayer2(playerTurnId: 9, tileIndex: 9),
          playPlayer3(playerTurnId: 10, tileIndex: 10),
          playPlayer4(playerTurnId: 11, tileIndex: 11),
          playPlayer1(playerTurnId: 12, tileIndex: 12),
          playPlayer2(playerTurnId: 13, tileIndex: 13),
          playPlayer3(playerTurnId: 14, tileIndex: 14),
          playPlayer4(playerTurnId: 15, tileIndex: 15),
          playPlayer1(playerTurnId: 16, tileIndex: 16),
          playPlayer2(playerTurnId: 17, tileIndex: 17),
          playPlayer3(playerTurnId: 18, tileIndex: 18),
          playPlayer4(playerTurnId: 19, tileIndex: 19),
          playPlayer1(playerTurnId: 20, tileIndex: 21), // Swapped to prevent a
          playPlayer2(playerTurnId: 21, tileIndex: 20), // player 1 reverse diag win.
          playPlayer3(playerTurnId: 22, tileIndex: 22),
          playPlayer4(playerTurnId: 23, tileIndex: 23),
          playPlayer1(playerTurnId: 24, tileIndex: 24),
        ];

        /// Initialize a new game board with an edge size of `edgeSizeConstant`.
        final gameBoardData = GameBoardData(edgeSize: edgeSize);

        /// Simulate plays by adding a list of predefined plays.
        final gameBoardCopy = gameBoardData.copyWith(plays: plays);

        /// Check that the method satisfies the condition.
        final result = gameBoardCopy.checkAllRows;
        expect(result, null);
      });

      group('[checkAllRows] should return a record when', () {
        test('the first row is filled with the same player turn', () {
          final plays = [
            playPlayer1(playerTurnId: 0, tileIndex: 0), // 0
            playPlayer2(playerTurnId: 1, tileIndex: 5),
            playPlayer1(playerTurnId: 2, tileIndex: 1), // 1
            playPlayer2(playerTurnId: 3, tileIndex: 6),
            playPlayer1(playerTurnId: 4, tileIndex: 2), // 2
            playPlayer2(playerTurnId: 5, tileIndex: 7),
            playPlayer1(playerTurnId: 6, tileIndex: 3), // 3
            playPlayer2(playerTurnId: 7, tileIndex: 8),
            playPlayer1(playerTurnId: 8, tileIndex: 4), // 4
          ];

          final gameBoardData = GameBoardData(edgeSize: edgeSize);
          final gameBoardCopy = gameBoardData.copyWith(plays: plays);
          final result = gameBoardCopy.checkAllRows;

          // ( Group index: 0, playerId: 0 (player 1) )
          expect(result, (0, 0));
        });
        test('the second row is filled with the same player turn', () {
          final plays = [
            playPlayer1(playerTurnId: 0, tileIndex: 0),
            playPlayer2(playerTurnId: 1, tileIndex: 5), // 5
            playPlayer1(playerTurnId: 2, tileIndex: 1),
            playPlayer2(playerTurnId: 3, tileIndex: 6), // 6
            playPlayer1(playerTurnId: 4, tileIndex: 2),
            playPlayer2(playerTurnId: 5, tileIndex: 7), // 7
            playPlayer1(playerTurnId: 6, tileIndex: 3),
            playPlayer2(playerTurnId: 7, tileIndex: 8), // 8
            playPlayer1(playerTurnId: 8, tileIndex: 10),
            playPlayer2(playerTurnId: 9, tileIndex: 9), // 9
          ];

          final gameBoardData = GameBoardData(edgeSize: edgeSize);
          final gameBoardCopy = gameBoardData.copyWith(plays: plays);
          final result = gameBoardCopy.checkAllRows;

          // ( Group index: 1, playerId: 1 (player 2) )
          expect(result, (1, 1));
        });
        test('the third row is filled with the same player turn', () {
          final plays = [
            playPlayer1(playerTurnId: 0, tileIndex: 0),
            playPlayer2(playerTurnId: 1, tileIndex: 10), // 10
            playPlayer1(playerTurnId: 2, tileIndex: 1),
            playPlayer2(playerTurnId: 3, tileIndex: 11), // 11
            playPlayer1(playerTurnId: 4, tileIndex: 2),
            playPlayer2(playerTurnId: 5, tileIndex: 12), // 12
            playPlayer1(playerTurnId: 6, tileIndex: 3),
            playPlayer2(playerTurnId: 7, tileIndex: 13), // 13
            playPlayer1(playerTurnId: 8, tileIndex: 5),
            playPlayer2(playerTurnId: 9, tileIndex: 14), // 14
          ];

          final gameBoardData = GameBoardData(edgeSize: edgeSize);
          final gameBoardCopy = gameBoardData.copyWith(plays: plays);
          final result = gameBoardCopy.checkAllRows;

          // ( Group index: 2, playerId: 1 (player 2) )
          expect(result, (2, 1));
        });
        test('the fourth row is filled with the same player turn', () {
          final plays = [
            playPlayer1(playerTurnId: 0, tileIndex: 15), // 15
            playPlayer2(playerTurnId: 1, tileIndex: 0),
            playPlayer1(playerTurnId: 2, tileIndex: 16), // 16
            playPlayer2(playerTurnId: 3, tileIndex: 1),
            playPlayer1(playerTurnId: 4, tileIndex: 17), // 17
            playPlayer2(playerTurnId: 5, tileIndex: 2),
            playPlayer1(playerTurnId: 6, tileIndex: 18), // 18
            playPlayer2(playerTurnId: 7, tileIndex: 3),
            playPlayer1(playerTurnId: 8, tileIndex: 19), // 19
          ];

          final gameBoardData = GameBoardData(edgeSize: edgeSize);
          final gameBoardCopy = gameBoardData.copyWith(plays: plays);
          final result = gameBoardCopy.checkAllRows;

          // ( Group index: 3, playerId: 0 (player 1) )
          expect(result, (3, 0));
        });
        test('the fifth row is filled with the same player turn', () {
          final plays = [
            playPlayer1(playerTurnId: 0, tileIndex: 0),
            playPlayer2(playerTurnId: 1, tileIndex: 20), // 20
            playPlayer1(playerTurnId: 2, tileIndex: 1),
            playPlayer2(playerTurnId: 3, tileIndex: 21), // 21
            playPlayer1(playerTurnId: 4, tileIndex: 2),
            playPlayer2(playerTurnId: 5, tileIndex: 22), // 22
            playPlayer1(playerTurnId: 6, tileIndex: 3),
            playPlayer2(playerTurnId: 7, tileIndex: 23), // 23
            playPlayer1(playerTurnId: 8, tileIndex: 5),
            playPlayer2(playerTurnId: 9, tileIndex: 24), // 24
          ];

          final gameBoardData = GameBoardData(edgeSize: edgeSize);
          final gameBoardCopy = gameBoardData.copyWith(plays: plays);
          final result = gameBoardCopy.checkAllRows;

          // ( Group index: 4, playerId: 1 (player 2) )
          expect(result, (4, 1));
        });
      });

      group('[checkAllCols] should return a record when', () {
        test('the first column is filled with the same player turn', () {
          final plays = [
            playPlayer1(playerTurnId: 0, tileIndex: 0), // 0
            playPlayer2(playerTurnId: 1, tileIndex: 1),
            playPlayer1(playerTurnId: 2, tileIndex: 5), // 5
            playPlayer2(playerTurnId: 3, tileIndex: 6),
            playPlayer1(playerTurnId: 4, tileIndex: 10), // 10
            playPlayer2(playerTurnId: 5, tileIndex: 11),
            playPlayer1(playerTurnId: 6, tileIndex: 15), // 15
            playPlayer2(playerTurnId: 7, tileIndex: 12),
            playPlayer1(playerTurnId: 8, tileIndex: 20), // 20
          ];

          final gameBoardData = GameBoardData(edgeSize: edgeSize);
          final gameBoardCopy = gameBoardData.copyWith(plays: plays);

          final result = gameBoardCopy.checkAllCols;

          // ( Group index: 0, playerId: 0 (player 1) )
          expect(result, (0, 0));
        });
        test('the second column is filled with the same player turn', () {
          final plays = [
            playPlayer1(playerTurnId: 0, tileIndex: 0),
            playPlayer2(playerTurnId: 1, tileIndex: 1), // 1
            playPlayer1(playerTurnId: 2, tileIndex: 5),
            playPlayer2(playerTurnId: 3, tileIndex: 6), // 6
            playPlayer1(playerTurnId: 4, tileIndex: 10),
            playPlayer2(playerTurnId: 5, tileIndex: 11), // 11
            playPlayer1(playerTurnId: 6, tileIndex: 15),
            playPlayer2(playerTurnId: 7, tileIndex: 16), // 16
            playPlayer1(playerTurnId: 8, tileIndex: 2),
            playPlayer2(playerTurnId: 9, tileIndex: 21), // 21
          ];

          final gameBoardData = GameBoardData(edgeSize: edgeSize);
          final gameBoardCopy = gameBoardData.copyWith(plays: plays);

          final result = gameBoardCopy.checkAllCols;

          // ( Group index: 1, playerId: 1 (player 2) )
          expect(result, (1, 1));
        });
        test('the third column is filled with the same player turn', () {
          final plays = [
            playPlayer1(playerTurnId: 0, tileIndex: 0),
            playPlayer2(playerTurnId: 1, tileIndex: 2), // 2
            playPlayer1(playerTurnId: 2, tileIndex: 5),
            playPlayer2(playerTurnId: 3, tileIndex: 7), // 7
            playPlayer1(playerTurnId: 4, tileIndex: 10),
            playPlayer2(playerTurnId: 5, tileIndex: 12), // 12
            playPlayer1(playerTurnId: 6, tileIndex: 15),
            playPlayer2(playerTurnId: 7, tileIndex: 17), // 17
            playPlayer1(playerTurnId: 8, tileIndex: 1),
            playPlayer2(playerTurnId: 9, tileIndex: 22), // 22
          ];

          final gameBoardData = GameBoardData(edgeSize: edgeSize);
          final gameBoardCopy = gameBoardData.copyWith(plays: plays);

          final result = gameBoardCopy.checkAllCols;

          // ( Group index: 2, playerId: 1 (player 2) )
          expect(result, (2, 1));
        });
        test('the fourth column is filled with the same player turn', () {
          final plays = [
            playPlayer1(playerTurnId: 0, tileIndex: 3), // 3
            playPlayer2(playerTurnId: 1, tileIndex: 1),
            playPlayer1(playerTurnId: 2, tileIndex: 8), // 8
            playPlayer2(playerTurnId: 3, tileIndex: 6),
            playPlayer1(playerTurnId: 4, tileIndex: 13), // 13
            playPlayer2(playerTurnId: 5, tileIndex: 11),
            playPlayer1(playerTurnId: 6, tileIndex: 18), // 18
            playPlayer2(playerTurnId: 7, tileIndex: 16),
            playPlayer1(playerTurnId: 8, tileIndex: 23), // 23
          ];

          final gameBoardData = GameBoardData(edgeSize: edgeSize);
          final gameBoardCopy = gameBoardData.copyWith(plays: plays);

          final result = gameBoardCopy.checkAllCols;

          // ( Group index: 3, playerId: 0 (player 1) )
          expect(result, (3, 0));
        });
        test('the fifth column is filled with the same player turn', () {
          final plays = [
            playPlayer1(playerTurnId: 0, tileIndex: 0),
            playPlayer2(playerTurnId: 1, tileIndex: 4), // 4
            playPlayer1(playerTurnId: 2, tileIndex: 5),
            playPlayer2(playerTurnId: 3, tileIndex: 9), // 9
            playPlayer1(playerTurnId: 4, tileIndex: 10),
            playPlayer2(playerTurnId: 5, tileIndex: 14), // 14
            playPlayer1(playerTurnId: 6, tileIndex: 15),
            playPlayer2(playerTurnId: 7, tileIndex: 19), // 19
            playPlayer1(playerTurnId: 8, tileIndex: 1),
            playPlayer2(playerTurnId: 9, tileIndex: 24), // 24
          ];

          final gameBoardData = GameBoardData(edgeSize: edgeSize);
          final gameBoardCopy = gameBoardData.copyWith(plays: plays);

          final result = gameBoardCopy.checkAllCols;

          // ( Group index: 4, playerId: 1 (player 2) )
          expect(result, (4, 1));
        });
      });

      group('[diagFilled] should return a record when', () {
        test(
          'the first diagonal is filled with the same player turn',
          () {
            final plays = [
              playPlayer1(playerTurnId: 0, tileIndex: 0), // 0
              playPlayer2(playerTurnId: 1, tileIndex: 1),
              playPlayer1(playerTurnId: 2, tileIndex: 6), // 6
              playPlayer2(playerTurnId: 3, tileIndex: 7),
              playPlayer1(playerTurnId: 4, tileIndex: 12), // 12
              playPlayer2(playerTurnId: 5, tileIndex: 13),
              playPlayer1(playerTurnId: 6, tileIndex: 18), // 18
              playPlayer2(playerTurnId: 7, tileIndex: 19),
              playPlayer1(playerTurnId: 8, tileIndex: 24), // 24
            ];

            final gameBoardData = GameBoardData(edgeSize: edgeSize);
            final gameBoardCopy = gameBoardData.copyWith(plays: plays);

            final result = gameBoardCopy.checkAllDiags;
            // ( Group index: 0, playerId: 0 (player 1) )
            expect(result, (0, 0));
          },
        );
        test(
          'the second diagonal is filled with the same player turn',
          () {
            final plays = [
              playPlayer1(playerTurnId: 0, tileIndex: 0),
              playPlayer2(playerTurnId: 1, tileIndex: 4), // 4
              playPlayer1(playerTurnId: 2, tileIndex: 1),
              playPlayer2(playerTurnId: 3, tileIndex: 8), // 8
              playPlayer1(playerTurnId: 4, tileIndex: 2),
              playPlayer2(playerTurnId: 5, tileIndex: 12), // 12
              playPlayer1(playerTurnId: 6, tileIndex: 3),
              playPlayer2(playerTurnId: 7, tileIndex: 16), // 16
              playPlayer1(playerTurnId: 8, tileIndex: 5),
              playPlayer2(playerTurnId: 9, tileIndex: 20), // 20
            ];

            final gameBoardData = GameBoardData(edgeSize: edgeSize);
            final gameBoardCopy = gameBoardData.copyWith(plays: plays);

            final result = gameBoardCopy.checkAllDiags;
            // ( Group index: 1, playerId: 1 (player 2) )
            expect(result, (1, 1));
          },
        );
      });

      group('[tile availability] for', () {
        test(
            '[usedTiles] should return a list of indices '
            'that have been used by any player turn', () {
          final plays = [
            playPlayer1(playerTurnId: 0, tileIndex: 11),
            playPlayer2(playerTurnId: 1, tileIndex: 1),
            playPlayer3(playerTurnId: 2, tileIndex: 13),
            playPlayer4(playerTurnId: 3, tileIndex: 22),
            playPlayer1(playerTurnId: 4, tileIndex: 4),
            playPlayer2(playerTurnId: 5, tileIndex: 5),
            playPlayer3(playerTurnId: 6, tileIndex: 6),
            playPlayer4(playerTurnId: 7, tileIndex: 17),
            playPlayer1(playerTurnId: 8, tileIndex: 8),
            playPlayer2(playerTurnId: 9, tileIndex: 9),
            playPlayer3(playerTurnId: 10, tileIndex: 20),
          ];

          final gameBoardData = GameBoardData(edgeSize: edgeSize);
          final gameBoardCopy = gameBoardData.copyWith(plays: plays);

          // This returns a simple incremental list with all used indexes.
          // Note: it will not be in the played tile index order.
          final result = gameBoardCopy.usedTileIndexes;
          expect(result, [1, 4, 5, 6, 8, 9, 11, 13, 17, 20, 22]);
        });

        test(
          '[availableTiles] should return a list of indices '
          'that have not been used by any player turn',
          () {
            final plays = [
              playPlayer1(playerTurnId: 0, tileIndex: 11),
              playPlayer2(playerTurnId: 1, tileIndex: 1),
              playPlayer3(playerTurnId: 2, tileIndex: 13),
              playPlayer4(playerTurnId: 3, tileIndex: 22),
              playPlayer1(playerTurnId: 4, tileIndex: 4),
              playPlayer2(playerTurnId: 5, tileIndex: 5),
              playPlayer3(playerTurnId: 6, tileIndex: 6),
              playPlayer4(playerTurnId: 7, tileIndex: 17),
              playPlayer1(playerTurnId: 8, tileIndex: 8),
              playPlayer2(playerTurnId: 9, tileIndex: 9),
              playPlayer3(playerTurnId: 10, tileIndex: 20),
            ];

            final gameBoardData = GameBoardData(edgeSize: edgeSize);
            final gameBoardCopy = gameBoardData.copyWith(plays: plays);

            final result = gameBoardCopy.availableTileIndexes;
            expect(result, <int>[0, 2, 3, 7, 10, 12, 14, 15, 16, 18, 19, 21, 23, 24]);
          },
        );
      });
    });
  });
}
