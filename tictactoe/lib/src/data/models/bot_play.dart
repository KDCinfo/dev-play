import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';

abstract class BotPlay {
  static int runBotPlay({
    required Map<MatchTupleEnum, Map<int, List<int>>> filledAllRows,
    required int nonBotPlayerId,
  }) {
    // Where `tilesMatched` = `edgeSize - 1` (because `== edgeSize` would have been a win, above).
    //
    // `do while(final tilesMatched = edgeSize; tilesMatched > 0; tilesMatched--)`
    // - Check rows filled with `tilesMatched`
    // - Check cols filled with `tilesMatched`
    // - Check diags filled with `tilesMatched`

    // final fullMap = newScorebookData.currentGame.gameBoardData.filledAllRows;
    // final countDownRows = fullMap[MatchTupleEnum.row] ?? {}; // Map<int, List<int>>

    final countDownRows = filledAllRows[MatchTupleEnum.row] ?? {}; // Map<int, List<int>>
    final countDownCols = filledAllRows[MatchTupleEnum.column] ?? {};
    // final countDownDiags = filledAllRows[MatchTupleEnum.diagonal] ?? {};
    //                               [Group]: [playerId, playerId] // List<int>
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

          if (maxRangeLength >= tupleDataLists[MatchTupleEnum.column]!.tilesPlayedCount) {
            tupleDataLists[MatchTupleEnum.column] = tupleDataLists[MatchTupleEnum.column]!.copyWith(
              tilesPlayedCount: maxRangeLength,
              groupIndex: colGroup,
              tileIndexToPlay: rowIndex,
            );
          }
        }
      },
    );

    // GameData newGameData;
    if (tupleDataLists[MatchTupleEnum.row]!.tileIndexToPlay > -1) {
      //
    }

    // @TODO: Find a tile to play from the list of 3 tuples.
    //        If max tiles played per group is only 1, see if middle is available.
    final tupleRow = tupleDataLists[MatchTupleEnum.row]!;
    final tupleCol = tupleDataLists[MatchTupleEnum.column]!;

    return tupleRow.tilesPlayedCount > tupleCol.tilesPlayedCount
        ? tupleRow.tileIndexToPlay
        : tupleCol.tileIndexToPlay;
  }

  // (bestTileIndex, maxRangeLength) = findBestTileIndex(
  //
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
          sublists.add(List.from(currentSublist));
          currentSublist.clear();
        }
      }
    }

    if (currentSublist.isNotEmpty) {
      sublists.add(List.from(currentSublist));
    }

    // Find the largest sublist.
    final largestSublist = sublists.fold(<int>[], (a, b) => a.length > b.length ? a : b);

    // Check for empty tiles adjacent to the largest sublist.
    final leftIndex = largestSublist.isEmpty ? -1 : largestSublist.first - 1;
    final rightIndex = largestSublist.isEmpty ? -1 : largestSublist.last + 1;

    // We need to check both sides and choose the first valid one.
    if (leftIndex >= 0 && tiles[leftIndex] == -2) {
      return (leftIndex, largestSublist.length);
    }
    if (rightIndex < tiles.length && rightIndex >= 0 && tiles[rightIndex] == -2) {
      return (rightIndex, largestSublist.length);
    }

    // If no empty tiles are found next to the largest sublist,
    // check the first and last elements.
    for (var i = 0; i < tiles.length; i++) {
      if (tiles[i] == -2) {
        if ((i > 0 && tiles[i - 1] == nonBotPlayerId) ||
            (i < tiles.length - 1 && tiles[i + 1] == nonBotPlayerId)) {
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
