import 'package:dev_play_tictactuple/src/data/models/models.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  const edgeSizeConstant = 4;

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
            occupiedById: player1.playerId!,
          );
      playPlayer2 = ({required int tileIndex, required int playerTurnId}) => PlayerTurn(
            tileIndex: tileIndex,
            playerTurnId: playerTurnId,
            occupiedById: player2.playerId!,
          );
      playPlayer3 = ({required int tileIndex, required int playerTurnId}) => PlayerTurn(
            tileIndex: tileIndex,
            playerTurnId: playerTurnId,
            occupiedById: player3.playerId!,
          );
      playPlayer4 = ({required int tileIndex, required int playerTurnId}) => PlayerTurn(
            tileIndex: tileIndex,
            playerTurnId: playerTurnId,
            occupiedById: player4.playerId!,
          );
    });

    group('[changeEdgeSize]', () {
      setUp(() {
        edgeSize = edgeSizeConstant;
        edgeSize2 = 5;
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

    group('with an edgeSize of [4]:', () {
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
            () => GameBoardData(edgeSize: edgeSize),
            returnsNormally,
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
                occupiedById: 0,
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
                  'occupiedById': 0,
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
                occupiedById: 0,
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
          playPlayer1(playerTurnId: 12, tileIndex: 15), // Reversed to
          playPlayer2(playerTurnId: 13, tileIndex: 14), // prevent a
          playPlayer3(playerTurnId: 14, tileIndex: 13), // player 1
          playPlayer4(playerTurnId: 15, tileIndex: 12), // column 1 win.
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
            playPlayer2(playerTurnId: 1, tileIndex: 4),
            playPlayer1(playerTurnId: 2, tileIndex: 1), // 1
            playPlayer2(playerTurnId: 3, tileIndex: 5),
            playPlayer1(playerTurnId: 4, tileIndex: 2), // 2
            playPlayer2(playerTurnId: 5, tileIndex: 6),
            playPlayer1(playerTurnId: 6, tileIndex: 3), // 3
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
            playPlayer2(playerTurnId: 1, tileIndex: 4), // 4
            playPlayer1(playerTurnId: 2, tileIndex: 1),
            playPlayer2(playerTurnId: 3, tileIndex: 5), // 5
            playPlayer1(playerTurnId: 4, tileIndex: 2),
            playPlayer2(playerTurnId: 5, tileIndex: 6), // 6
            playPlayer1(playerTurnId: 6, tileIndex: 8),
            playPlayer2(playerTurnId: 7, tileIndex: 7), // 7
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
            playPlayer2(playerTurnId: 1, tileIndex: 8), // 8
            playPlayer1(playerTurnId: 2, tileIndex: 1),
            playPlayer2(playerTurnId: 3, tileIndex: 9), // 9
            playPlayer1(playerTurnId: 4, tileIndex: 2),
            playPlayer2(playerTurnId: 5, tileIndex: 10), // 10
            playPlayer1(playerTurnId: 6, tileIndex: 4),
            playPlayer2(playerTurnId: 7, tileIndex: 11), // 11
          ];

          final gameBoardData = GameBoardData(edgeSize: edgeSize);
          final gameBoardCopy = gameBoardData.copyWith(plays: plays);
          final result = gameBoardCopy.checkAllRows;

          // ( Group index: 2, playerId: 1 (player 2) )
          expect(result, (2, 1));
        });
        test('the fourth row is filled with the same player turn', () {
          final plays = [
            playPlayer1(playerTurnId: 0, tileIndex: 12), // 12
            playPlayer2(playerTurnId: 1, tileIndex: 4),
            playPlayer1(playerTurnId: 2, tileIndex: 13), // 13
            playPlayer2(playerTurnId: 3, tileIndex: 5),
            playPlayer1(playerTurnId: 4, tileIndex: 14), // 14
            playPlayer2(playerTurnId: 5, tileIndex: 6),
            playPlayer1(playerTurnId: 6, tileIndex: 15), // 15
          ];

          final gameBoardData = GameBoardData(edgeSize: edgeSize);
          final gameBoardCopy = gameBoardData.copyWith(plays: plays);
          final result = gameBoardCopy.checkAllRows;

          // ( Group index: 3, playerId: 0 (player 1) )
          expect(result, (3, 0));
        });
      });

      group('[checkAllCols] should return a record when', () {
        test('the first column is filled with the same player turn', () {
          final plays = [
            playPlayer1(playerTurnId: 0, tileIndex: 0), // 0
            playPlayer2(playerTurnId: 1, tileIndex: 1),
            playPlayer1(playerTurnId: 2, tileIndex: 4), // 4
            playPlayer2(playerTurnId: 3, tileIndex: 5),
            playPlayer1(playerTurnId: 4, tileIndex: 8), // 8
            playPlayer2(playerTurnId: 5, tileIndex: 9),
            playPlayer1(playerTurnId: 6, tileIndex: 12), // 12
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
            playPlayer1(playerTurnId: 2, tileIndex: 4),
            playPlayer2(playerTurnId: 3, tileIndex: 5), // 5
            playPlayer1(playerTurnId: 4, tileIndex: 8),
            playPlayer2(playerTurnId: 5, tileIndex: 9), // 9
            playPlayer1(playerTurnId: 6, tileIndex: 2),
            playPlayer2(playerTurnId: 7, tileIndex: 13), // 13
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
            playPlayer1(playerTurnId: 2, tileIndex: 4),
            playPlayer2(playerTurnId: 3, tileIndex: 6), // 6
            playPlayer1(playerTurnId: 4, tileIndex: 8),
            playPlayer2(playerTurnId: 5, tileIndex: 10), // 10
            playPlayer1(playerTurnId: 6, tileIndex: 9),
            playPlayer2(playerTurnId: 7, tileIndex: 14), // 14
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
            playPlayer2(playerTurnId: 1, tileIndex: 0),
            playPlayer1(playerTurnId: 2, tileIndex: 7), // 7
            playPlayer2(playerTurnId: 3, tileIndex: 4),
            playPlayer1(playerTurnId: 4, tileIndex: 11), // 11
            playPlayer2(playerTurnId: 5, tileIndex: 8),
            playPlayer1(playerTurnId: 6, tileIndex: 15), // 15
          ];

          final gameBoardData = GameBoardData(edgeSize: edgeSize);
          final gameBoardCopy = gameBoardData.copyWith(plays: plays);

          final result = gameBoardCopy.checkAllCols;

          // ( Group index: 3, playerId: 0 (player 1) )
          expect(result, (3, 0));
        });
      });

      group('[diagFilled] should return a record when', () {
        test(
          'the first diagonal is filled with the same player turn',
          () {
            final plays = [
              playPlayer1(playerTurnId: 0, tileIndex: 0), // 0
              playPlayer2(playerTurnId: 1, tileIndex: 1),
              playPlayer1(playerTurnId: 2, tileIndex: 5), // 5
              playPlayer2(playerTurnId: 3, tileIndex: 6),
              playPlayer1(playerTurnId: 4, tileIndex: 10), // 10
              playPlayer2(playerTurnId: 5, tileIndex: 8),
              playPlayer1(playerTurnId: 6, tileIndex: 15), // 15
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
              playPlayer2(playerTurnId: 1, tileIndex: 3), // 3
              playPlayer1(playerTurnId: 2, tileIndex: 1),
              playPlayer2(playerTurnId: 3, tileIndex: 6), // 6
              playPlayer1(playerTurnId: 4, tileIndex: 2),
              playPlayer2(playerTurnId: 5, tileIndex: 9), // 9
              playPlayer1(playerTurnId: 6, tileIndex: 4),
              playPlayer2(playerTurnId: 7, tileIndex: 12), // 12
            ];

            final gameBoardData = GameBoardData(
              plays: plays,
              edgeSize: 4,
            );
            // final gameBoardCopy = gameBoardData.copyWith(plays: plays);

            final result = gameBoardData.checkAllDiags;
            // ( Group index: 1, playerId: 1 (player 2) )
            expect(result, (1, 1));
          },
        );
      });

      group('[tile availability] for', () {
        test(
          '[usedTiles] should return a list of indices '
          'that have been used by any player turn',
          () {
            final plays = [
              playPlayer1(playerTurnId: 0, tileIndex: 0),
              playPlayer2(playerTurnId: 1, tileIndex: 2),
              playPlayer1(playerTurnId: 2, tileIndex: 1),
              playPlayer2(playerTurnId: 3, tileIndex: 4),
              playPlayer1(playerTurnId: 4, tileIndex: 12),
              playPlayer2(playerTurnId: 5, tileIndex: 9),
              playPlayer1(playerTurnId: 6, tileIndex: 7),
            ];

            final gameBoardData = GameBoardData(edgeSize: edgeSize);
            final gameBoardCopy = gameBoardData.copyWith(plays: plays);

            // This returns a simple incremental list with all used indexes.
            // Note: it will not be in the played tile index order;
            //       notice `tileIndex` [2, 1] becomes [1, 2].
            final result = gameBoardCopy.usedTileIndexes;
            expect(result, [0, 1, 2, 4, 7, 9, 12]);
          },
        );

        test(
          '[availableTiles] should return a list of indices '
          'that have not been used by any player turn',
          () {
            final plays = [
              playPlayer1(playerTurnId: 0, tileIndex: 0),
              playPlayer2(playerTurnId: 1, tileIndex: 2),
              playPlayer1(playerTurnId: 2, tileIndex: 1),
              playPlayer2(playerTurnId: 3, tileIndex: 4),
              playPlayer1(playerTurnId: 4, tileIndex: 12),
              playPlayer2(playerTurnId: 5, tileIndex: 9),
              playPlayer1(playerTurnId: 6, tileIndex: 7),
            ];

            final gameBoardData = GameBoardData(edgeSize: edgeSize);
            final gameBoardCopy = gameBoardData.copyWith(plays: plays);

            final result = gameBoardCopy.availableTileIndexes;
            expect(result, <int>[3, 5, 6, 8, 10, 11, 13, 14, 15]);
          },
        );
      });
    });
  });
}
