import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';

abstract class BotPlay {
  static int runBotPlay({
    required Map<MatchTupleEnum, Map<int, List<int>>> filledAllRows,
    // required void Function({
    //   required GameData currentGame,
    //   required int tileIndex,
    // }) playTurn,
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
    //                            // [Group]: [playerId, playerId] // List<int>
    //                            //     [0]: [ 0,  1,  1,  0,  1] // -2 = empty tile
    //                            //     [1]: [-2, -2,  1,  0, -2]
    //                            //     [2]: [ 0,  1, -2,  0,  1]
    //                            //     [3]: [ 0,  1,  1, -2,  1]
    //                            //     [4]: [ 0,  1,  1,  0,  1]
    // final countDownCols = fullMap[MatchTupleEnum.column] ?? {};
    // final countDownDiags = fullMap[MatchTupleEnum.diagonal] ?? {};

    // final mapOfGroupRows = _mapPlaysToRowGroups(); // { 0: [ playerId ], 1: [], 2: [] }
    // final mapOfGroupCols = _mapPlaysToColGroups(); // { 0: [ playerId ], 1: [], 2: [] }
    // final mapOfGroupDiags = _mapPlaysToDiagGroups(); // { 0: [ playerId ], 1: [], 2: [] }

    /// BotPlayTilePlayData
    ///   - MatchTupleEnum.row, .col, .diag
    ///   - playerId
    ///   - maxCount
    ///   - groupIndex
    ///   - tileToPlay

    final tupleDataLists = <MatchTupleEnum, BotPlayTilePlayData>{
      MatchTupleEnum.row: const BotPlayTilePlayData(matchTupleEnum: MatchTupleEnum.row),
      MatchTupleEnum.column: const BotPlayTilePlayData(matchTupleEnum: MatchTupleEnum.column),
      MatchTupleEnum.diagonal: const BotPlayTilePlayData(matchTupleEnum: MatchTupleEnum.diagonal),
    };

    /// The `edgeSize` is the number of rows or columns.
    // final edgeSize = countDownRows.values.first.length;

    // countDownRows.entries.map((rowGroup) {
    countDownRows.forEach(
      (rowGroup, groupList) {
        // Note: A `playerId` of `-2` represents an empty tile.
        //
        // rowGroup.key // 0 // `groupIndex`
        // rowGroup.value // [0, 1, 1, -2, 1]

        // const previousIdTracker = PreviousIdTracker(
        //     // playerId: -1,
        //     // currentLongestCount: 0,
        //     // loopIndex: -1,
        //     );
        // var loopCount = 0;

        /// Only check rows with an empty tile.
        final rowHasEmptyTile = groupList.any((playerId) => playerId == -2);
        final rowHasAllEmptyTiles = groupList.every((playerId) => playerId == -2);

        /// If there are no empty tiles, there's nowhere to play and nothing to check for.
        if (!rowHasAllEmptyTiles && rowHasEmptyTile) {
          var maxRangeLength = 0;
          var bestTileIndex = 0;

          (bestTileIndex, maxRangeLength) = findBestTileIndex(
            groupList,
            nonBotPlayerId,
          );

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

    // GameData newGameData;
    if (tupleDataLists[MatchTupleEnum.row]!.tileIndexToPlay > -1) {
      //
    }

    // @TODO: Find a tile to play from the list of 3 tuples.
    //        If max tiles played per group is only 1, see if middle is available.
    // return newScorebookData.updateGame(newGameData);
    final tileIndexToPlay = tupleDataLists[MatchTupleEnum.row]!.tileIndexToPlay;
    return tileIndexToPlay > -1 ? tileIndexToPlay : 0;
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
}
