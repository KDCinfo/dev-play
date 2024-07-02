import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';

abstract class BotPlay {
  static int runBotPlay({
    required Map<MatchTupleEnum, Map<int, List<int>>> filledAllTuples,
    required int nonBotPlayerId,
  }) {
    //
    final countDownRows = filledAllTuples[MatchTupleEnum.row] ?? {}; // Map<int, List<int>>
    final countDownCols = filledAllTuples[MatchTupleEnum.column] ?? {};
    final countDownDiags = filledAllTuples[MatchTupleEnum.diagonal] ?? {};
    //                               [Group]: [playerId, playerId, ...] // List<int>
    //                                   [0]: [ 0,  1,  1,  0,  1] // -2 = empty tile
    //                                   [1]: [-2, -2,  1,  0, -2]
    //                                   [2]: [ 0,  1, -2,  0,  1]
    //                                   [3]: [ 0,  1,  1, -2,  1]
    //                                   [4]: [ 0,  1,  1,  0,  1]

    final tupleDataLists = <MatchTupleEnum, BotPlayTilePlayData>{
      MatchTupleEnum.row: const BotPlayTilePlayData(matchTupleEnum: MatchTupleEnum.row),
      MatchTupleEnum.column: const BotPlayTilePlayData(matchTupleEnum: MatchTupleEnum.column),
      MatchTupleEnum.diagonal: const BotPlayTilePlayData(matchTupleEnum: MatchTupleEnum.diagonal),
    };

    countDownRows.forEach(
      (rowGroup, groupList) {
        /// Only check rows with an empty tile. If there are no
        /// empty tiles, there's nowhere to play and nothing to check for.
        ///
        final rowHasEmptyTile = groupList.any((playerId) => playerId == -2);
        final rowHasAllEmptyTiles = groupList.every((playerId) => playerId == -2);

        if (!rowHasAllEmptyTiles && rowHasEmptyTile) {
          final (bestTileIndex, maxRangeLength) = findBestTileIndex(groupList, nonBotPlayerId);

          if (maxRangeLength >= tupleDataLists[MatchTupleEnum.row]!.tilesPlayedCount) {
            tupleDataLists[MatchTupleEnum.row] = tupleDataLists[MatchTupleEnum.row]!.copyWith(
              tilesPlayedCount: maxRangeLength,
              groupIndex: rowGroup,
              tileIndexToPlay: bestTileIndex + (rowGroup * groupList.length),
            );
          }
        }
      },
    );

    countDownCols.forEach(
      (colGroup, groupList) {
        /// Only check cols with an empty tile.
        final colHasEmptyTile = groupList.any((playerId) => playerId == -2);
        final colHasAllEmptyTiles = groupList.every((playerId) => playerId == -2);

        if (!colHasAllEmptyTiles && colHasEmptyTile) {
          final (bestTileIndex, maxRangeLength) = findBestTileIndex(groupList, nonBotPlayerId);

          if (maxRangeLength >= tupleDataLists[MatchTupleEnum.column]!.tilesPlayedCount) {
            final edgeSize = groupList.length;
            final colIndex = bestTileIndex + (colGroup * edgeSize);
            // Need to convert the 'col index' to a 'row index' based on
            // how many tiles there are to transpose (i.e. the board size).
            //
            // For a 4-edge column:
            // 	9 (col count) belongs at 6 (row count)
            //
            // 	Find the col cell index to convert (9).
            // 	Use it and boardSize to find row cell index (6).
            //
            // - colIndex: 9 => rowIndex: 6
            // - colIndex: 5 => rowIndex: 5 (same both ways)
            //
            final rowIndex = transposeColumnToRowIndex(colIndex, edgeSize);

            tupleDataLists[MatchTupleEnum.column] = tupleDataLists[MatchTupleEnum.column]!.copyWith(
              tilesPlayedCount: maxRangeLength,
              groupIndex: colGroup,
              tileIndexToPlay: rowIndex,
            );
          }
        }
      },
    );

    countDownDiags.forEach(
      (diagGroup, groupList) {
        /// Only check diags with an empty tile.
        final diagHasEmptyTile = groupList.any((playerId) => playerId == -2);
        final diagHasAllEmptyTiles = groupList.every((playerId) => playerId == -2);

        if (!diagHasAllEmptyTiles && diagHasEmptyTile) {
          final (bestTileIndex, maxRangeLength) = findBestTileIndex(groupList, nonBotPlayerId);

          final edgeSize = groupList.length;
          final boardSize = edgeSize * edgeSize;

          var transposedDiagIndex = -1;

          /// [1st] => Top left to bottom right.
          /// [2nd] => Top right to bottom left.
          /// To be filled in with either a playerId, or a -2 for an empty tile.
          var checkCount = 0;

          if (diagGroup == 0) {
            // Check the [1st] diag group for a `bestTileIndex`.
            // 1st pass example:
            // |--> groupList: [-2, -2, -2, -2]
            // |--> diagIndex 0 => rowIndex 0
            for (var tileIndex = 0; tileIndex < boardSize; tileIndex += edgeSize + 1) {
              // [0] += 3 + 1 == 4
              // [4] += 3 + 1 == 8
              // [8] += 3 + 1 == 12 (> boardSize)
              if (bestTileIndex == checkCount) {
                transposedDiagIndex = tileIndex;
              }
              checkCount++;
            }
          } else {
            // Check the [2nd] diag group.
            // 2nd pass example:
            // |--> groupList: [-2, 1, -2, -2]
            // |--> diagIndex 0 => rowIndex 3
            for (var tileIndex = edgeSize - 1;
                tileIndex < boardSize - 1;
                tileIndex += edgeSize - 1) {
              // 3 - 1 == [2] | 2 += 3 - 1 == [4]
              //          [4] | 4 += 3 - 1 == [6]
              //          [6] | 6 += 3 - 1 == [8] (! < boardSize - 1)
              if (bestTileIndex == checkCount) {
                transposedDiagIndex = tileIndex;
              }
              checkCount++;
            }
          }

          if (maxRangeLength >= tupleDataLists[MatchTupleEnum.diagonal]!.tilesPlayedCount &&
              transposedDiagIndex > -1) {
            tupleDataLists[MatchTupleEnum.diagonal] =
                tupleDataLists[MatchTupleEnum.diagonal]!.copyWith(
              tilesPlayedCount: maxRangeLength,
              groupIndex: diagGroup,
              tileIndexToPlay: transposedDiagIndex,
            );
          }
        }
      },
    );

    // Find a tile to play from the list of 3 tuples.
    // @TODO: If max tiles played per group is only 1, see if middle is available.
    final tupleRow = tupleDataLists[MatchTupleEnum.row]!;
    final tupleCol = tupleDataLists[MatchTupleEnum.column]!;
    final tupleDiag = tupleDataLists[MatchTupleEnum.diagonal]!;

    return tupleRow.tilesPlayedCount > tupleCol.tilesPlayedCount
        ? tupleRow.tileIndexToPlay
        : tupleCol.tilesPlayedCount > tupleDiag.tilesPlayedCount
            ? tupleCol.tileIndexToPlay
            : tupleDiag.tileIndexToPlay;
  }

  /// :: (int bestTileIndex, int maxRangeLength)
  static (int, int) findBestTileIndex(
    List<int> tiles,
    int nonBotPlayerId,
  ) {
    // Capture sublists of non-bot played tiles.
    final sublists = <List<int>>[];
    final currentSublist = <int>[];

    for (var i = 0; i < tiles.length; i++) {
      if (tiles[i] == nonBotPlayerId) {
        // Store index of player 1 tiles.
        currentSublist.add(i);
      } else {
        if (currentSublist.isNotEmpty) {
          sublists.add(List.of(currentSublist));
          currentSublist.clear();
        }
      }
    }

    if (currentSublist.isNotEmpty) {
      sublists.add(List.of(currentSublist));
    }

    // Find the largest sublist.
    final largestSublist = sublists.fold(<int>[], (a, b) => a.length > b.length ? a : b);

    // Check for empty tiles adjacent to the largest sublist.
    final leftIndex = largestSublist.isEmpty || largestSublist.firstOrNull == null
        ? -1
        : largestSublist.firstOrNull! - 1;
    final rightIndex = largestSublist.isEmpty || largestSublist.lastOrNull == null
        ? -1
        : largestSublist.lastOrNull! + 1;

    // We need to check both sides and choose the first valid one.
    if (leftIndex >= 0 && tiles.elementAtOrNull(leftIndex) == -2) {
      return (leftIndex, largestSublist.length);
    }
    if (rightIndex < tiles.length && rightIndex >= 0 && tiles.elementAtOrNull(rightIndex) == -2) {
      return (rightIndex, largestSublist.length);
    }

    // If no empty tiles are found next to the largest sublist,
    // check the first and last elements.
    for (var i = 0; i < tiles.length; i++) {
      if (tiles[i] == -2) {
        if ((i > 0 && tiles.elementAtOrNull(i - 1) == nonBotPlayerId) ||
            (i < tiles.length - 1 && tiles.elementAtOrNull(i + 1) == nonBotPlayerId)) {
          return (i, 1);
        }
      }
    }

    // If there are still no empty tiles found next to the previous
    // check, just grab the first empty tile (we can't be in this
    // function unless there is an empty tile in the List).
    //
    // For example, if there's only one play to make;
    // and it's not adjacent to the non-bot player.
    for (var i = 0; i < tiles.length; i++) {
      if (tiles[i] == -2) {
        return (i, 0);
      }
    }

    // If no adjacent empty tiles are found, return -1
    // (this should not happen given the problem constraints).
    return (-1, 0);
  }

  static int transposeColumnToRowIndex(int colIndex, int edgeSize) {
    final row = colIndex % edgeSize;
    final col = colIndex ~/ edgeSize;
    final rowIndex = row * edgeSize + col;
    return rowIndex;
  }
}
