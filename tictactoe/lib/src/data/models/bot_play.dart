import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';

abstract class BotPlay {
  static int runBotPlay({
    required Map<MatchTupleEnum, Map<int, List<int>>> filledAllRows,
    // required void Function({
    //   required GameData currentGame,
    //   required int tileIndex,
    // }) playTurn,
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
    final edgeSize = countDownRows.values.first.length;

    // countDownRows.entries.map((rowGroup) {
    countDownRows.forEach(
      (rowGroup, groupList) {
        // Note: A `playerId` of `-2` represents an empty tile.
        //
        // rowGroup.key // 0 // `groupIndex`
        // rowGroup.value // [0, 1, 1, -2, 1]
        //
        /// This will allow for this tile, and future marker tiles,
        /// and now player tiles, to all look to update the `tupleDataLists`.
        var markerHitStartCompares = false;

        /// <playerId, currentLongestCount>
        // final prevIdCount = <int, int>{};
        /// previousIdTracker | <playerId, currentLongestCount, loopIndex>
        final previousIdTracker = <int, int>{};
        var loopCount = 0;

        /// Check for empty tiles in each row.
        final rowHasEmptyTile = groupList.any((playerId) => playerId == -2);
        final rowHasAllEmptyTiles = groupList.every((playerId) => playerId == -2);

        /// If there are no empty tiles, there's nowhere to play and nothing to check for.
        if (!rowHasAllEmptyTiles && rowHasEmptyTile) {
          // for (final checkPlayerId in rowGroup.value) {
          for (final checkPlayerId in groupList) {
            // key:   int       currentTileIndex
            // value: List<int> checkPlayerId

            /// When the first marker is hit; we can then begin
            /// performing checks on whether to update `tupleDataLists`.
            if (checkPlayerId == -2 && !markerHitStartCompares) {
              markerHitStartCompares = true;
            }

            if (previousIdTracker.isEmpty) {
              // There's no need to store empty tiles.
              if (checkPlayerId != -2) {
                previousIdTracker.addAll({checkPlayerId: 1});

                tupleDataLists[MatchTupleEnum.row] = tupleDataLists[MatchTupleEnum.row]!.copyWith(
                  // matchTupleEnum: MatchTupleEnum.row,
                  playerId: previousIdTracker.keys.first,
                  tilesPlayedCount: previousIdTracker.values.first,
                  groupIndex: rowGroup,
                  // tileIndexToPlay: -1,
                );
              } else {
                tupleDataLists[MatchTupleEnum.row] = tupleDataLists[MatchTupleEnum.row]!.copyWith(
                  // matchTupleEnum: MatchTupleEnum.row,
                  // playerId: prevIdCount.keys.first,
                  // tilesPlayedCount: prevIdCount.values.first,
                  groupIndex: rowGroup,
                  tileIndexToPlay: loopCount + (rowGroup * edgeSize),
                );
              }
            } else {
              ///
              /// [ 1 ] --- Pre-check; update `tupleDataLists`
              ///
              /// This first code block is for cases where a marker isn't the
              /// first cell, and it has to look at the sequential tiles 'before'
              /// the current tile, which is the `prevIdCount` before the update below.
              ///
              /// So before updating the `prevIdCount`, if this is an empty
              /// tile (`-2`), we need to check the previous `prevIdCount`
              /// to see if it qualifies for updating `tupleDataLists`.
              ///
              /// @TODO: Need to know which tile index last had a play.
              ///
              if (checkPlayerId == -2 && tupleDataLists[MatchTupleEnum.row]!.tileIndexToPlay == -1
                  // && (prevIdCount.values.first - loopCount).abs() <= 1
                  ) {
                if (previousIdTracker.values.first >=
                    tupleDataLists[MatchTupleEnum.row]!.tilesPlayedCount) {
                  //
                  tupleDataLists[MatchTupleEnum.row] = tupleDataLists[MatchTupleEnum.row]!.copyWith(
                    // matchTupleEnum: MatchTupleEnum.row,
                    playerId: previousIdTracker.keys.first,
                    tilesPlayedCount: previousIdTracker.values.first,
                    groupIndex: rowGroup,
                    tileIndexToPlay: loopCount + (rowGroup * edgeSize),
                  );
                }
              }

              /// [ 2 ] --- Update `prevIdCount`
              ///
              /// Update the running `prevIdCount`.
              if (previousIdTracker.isNotEmpty && previousIdTracker.keys.contains(checkPlayerId)) {
                final tempNewMax = previousIdTracker[checkPlayerId]! + 1;
                previousIdTracker[checkPlayerId] = tempNewMax;
              } else {
                // There's no need to store empty tiles.
                if (checkPlayerId != -2) {
                  previousIdTracker
                    ..clear()
                    ..addAll({checkPlayerId: 1});
                }
              }

              /// [ 3 ] --- Post-check; update `tupleDataLists`
              ///
              /// Now that `prevIdCount` has been updated with
              /// this current tile, we need to check if the new
              /// data qualifies it for updating `tupleDataLists`.
              if (markerHitStartCompares && checkPlayerId != -2) {
                // final prevTileIdEmpty = tupleDataLists[MatchTupleEnum.row]!.playerId == -2;
                // if (prevTileIdEmpty || prevIdCount.values.first >=
                if (previousIdTracker.values.first >=
                    tupleDataLists[MatchTupleEnum.row]!.tilesPlayedCount) {
                  //
                  tupleDataLists[MatchTupleEnum.row] = tupleDataLists[MatchTupleEnum.row]!.copyWith(
                    // matchTupleEnum: MatchTupleEnum.row,
                    playerId: previousIdTracker.keys.first,
                    tilesPlayedCount: previousIdTracker.values.first,
                    groupIndex: rowGroup,
                    // tileIndexToPlay: loopCount,
                  );
                }
              } else if (checkPlayerId == -2 &&
                  (previousIdTracker.values.first - loopCount).abs() <= 1) {
                if (previousIdTracker.values.first >=
                    tupleDataLists[MatchTupleEnum.row]!.tilesPlayedCount) {
                  //
                  tupleDataLists[MatchTupleEnum.row] = tupleDataLists[MatchTupleEnum.row]!.copyWith(
                    // matchTupleEnum: MatchTupleEnum.row,
                    // playerId: prevIdCount.keys.first,
                    // tilesPlayedCount: prevIdCount.values.first,
                    groupIndex: rowGroup,
                    // tileIndexToPlay: loopCount,
                    tileIndexToPlay: loopCount + (rowGroup * edgeSize),
                  );
                }
              }
            }

            loopCount++;
          }
        }
        // return rowGroup;
      },
    ); // End of `.map`

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
}
