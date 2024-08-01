import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';

import 'package:equatable/equatable.dart';

/// This class holds the data for every game; both in-progress and archived.
///
class GameBoardData extends Equatable {
  const GameBoardData({
    this.edgeSize = AppConstants.defaultEdgeSize,
    this.plays = const <PlayerTurn>[],
  });

  /// Instantiate from JSON.
  factory GameBoardData.fromJson(Map<String, dynamic> json) {
    return GameBoardData(
      edgeSize: json['edgeSize'] as int,
      plays: (json['plays'] as List<dynamic>)
          .map((play) => PlayerTurn.fromJson(play as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Convert to JSON.
  Map<String, dynamic> toJson() {
    return {
      'edgeSize': edgeSize,
      'plays': plays.map((play) => play.toJson()).toList(),
    };
  }

  final int edgeSize;
  final List<PlayerTurn> plays;

  int get boardSize => edgeSize * edgeSize;

  // ignore: avoid-incomplete-copy-with
  GameBoardData copyWith({
    required List<PlayerTurn> plays,
  }) {
    return GameBoardData(
      edgeSize: edgeSize,
      plays: plays,
    );
  }

  /// Add a turn to the `plays` list.
  GameBoardData addPlay({
    required PlayerTurn play,
  }) {
    return GameBoardData(
      edgeSize: edgeSize,
      plays: List.of(plays)..add(play),
    );
  }

  /// This is used when a game is started, when transitioning
  /// from `GameEntry` to `GamePlay` initialization.
  GameBoardData changeEdgeSize({
    required int newEdgeSize,
  }) {
    return GameBoardData(
      edgeSize: newEdgeSize,
      plays: plays,
    );
  }

  /// Prepopulate the Map with an empty List for each group.
  ///   <int, List<int>>{ groupIndex: [`playerId`], }
  ///   <int, List<int>>{      0    : [ 1, 1, 1  ], 1: [], 2: [] }
  ///                     First Row :   ^ Win ^ --> PlayerID: 1
  ///
  Map<int, List<int>> _initializeCheckMap() {
    final checkMap = <int, List<int>>{};

    for (var j = 0; j < boardSize; j += edgeSize) {
      checkMap.putIfAbsent(
        j ~/ edgeSize,
        () => List<int>.filled(edgeSize, -2),
      );
    }

    return checkMap;
  }

  Map<int, List<int>> _mapPlaysToRowGroups() {
    ///
    final mapOfRowGroups = _initializeCheckMap();

    /// Add a `playerId` to `mapOfRowGroups`.
    for (final play in plays) {
      ///
      /// Per-row group index: 0, 1, 2, [3, 4]
      ///
      final groupIndexRow = play.tileIndex ~/ edgeSize;

      if (mapOfRowGroups[groupIndexRow] != null) {
        final indexInRowList = play.tileIndex % edgeSize;
        final newRowList = List.of(mapOfRowGroups[groupIndexRow]!)
          ..replaceRange(indexInRowList, indexInRowList + 1, [play.occupiedById]);

        mapOfRowGroups.update(groupIndexRow, (_) => newRowList);
      }
    }
    return mapOfRowGroups;
  }

  /// Same as `mapPlaysToRowGroups` but uses a modulo (`%`) to set up the groups.
  ///
  Map<int, List<int>> _mapPlaysToColGroups() {
    final mapOfColGroups = _initializeCheckMap();

    for (final play in plays) {
      ///
      /// Per-column group index: 0, 1, 2, [3, 4]
      ///
      final groupIndexCol = play.tileIndex % edgeSize;

      if (mapOfColGroups[groupIndexCol] != null) {
        final indexInColList = play.tileIndex ~/ edgeSize;
        final newColList = List.of(mapOfColGroups[groupIndexCol]!)
          ..replaceRange(indexInColList, indexInColList + 1, [play.occupiedById]);
        mapOfColGroups.update(groupIndexCol, (_) => newColList);
      }
    }
    return mapOfColGroups;
  }

  /// Used with `checkAllRows` and `checkAllCols`.
  /// Return: ( groupIndex, playerId )
  ///
  (int, int)? _checkFilled(Map<int, List<int>> mapOfGroups) {
    var groupIndex = 0;
    for (final playerIdList in mapOfGroups.values) {
      // @TODO: Make this `= -2` into a configurable option on the `GameEntry` screen.
      //        `!= -2` => all defensive; `== 1` => more offensive.
      // A `playerId: -2` indicates a tile that has not been played.
      final checkPlayerIdList = playerIdList.where((playerId) => playerId != -2);
      if (checkPlayerIdList.isNotEmpty) {
        // Establish a baseline playerId to check against.
        final firstPlayerId = checkPlayerIdList.firstOrNull;

        // Check for a full list of the same player.
        if (firstPlayerId != null &&
            checkPlayerIdList.length == edgeSize &&
            checkPlayerIdList.every(
              (playerId) => playerId == firstPlayerId,
            )) {
          return (groupIndex, firstPlayerId);
        }
      }

      // Let's check the next group.
      groupIndex++;
    }
    return null;
  }

  Map<int, Map<int, int>> _mapPlaysToDiagGroups() {
    /// Initialize `mapOfGroups` with [1st] and [2nd] diag groups.
    /// [1st] => Top left to bottom right.
    /// [2nd] => Top right to bottom left.
    /// To be filled in with either a playerId, or a -2 for an empty tile.
    final mapOfDiagTiles = <int, Map<int, int>>{
      // <tileId, playerId>
      0: <int, int>{}, // 1st diag group
      1: <int, int>{}, // 2nd diag group
    };

    /// [1] Record all the indexes that make up the [1st] diag group.
    for (var tileIndex = 0; tileIndex < boardSize; tileIndex += edgeSize + 1) {
      // [0] += 3 + 1 == 4
      // [4] += 3 + 1 == 8
      // [8] += 3 + 1 == 12 (> boardSize)
      mapOfDiagTiles[0]!.putIfAbsent(tileIndex, () => -2);
    }

    /// [2] Record all the indexes that make up the [2nd] diag group.
    for (var tileIndex = edgeSize - 1; tileIndex < boardSize - 1; tileIndex += edgeSize - 1) {
      // 3 - 1 == [2] | 2 += 3 - 1 == [4]
      //          [4] | 4 += 3 - 1 == [6]
      //          [6] | 6 += 3 - 1 == [8] (! < boardSize - 1)
      mapOfDiagTiles[1]!.putIfAbsent(tileIndex, () => -2);
    }

    for (final play in plays) {
      final groupDiagIndexes = [0, 1];
      for (final groupIndexDiag in groupDiagIndexes) {
        if (mapOfDiagTiles[groupIndexDiag]!.containsKey(play.tileIndex)) {
          mapOfDiagTiles[groupIndexDiag]!.update(play.tileIndex, (_) => play.occupiedById);
        }
      }
    }

    return mapOfDiagTiles;
  }

  (int, int)? _checkFilledDiags(Map<int, Map<int, int>> mapOfGroups) {
    // Tile indexes: [0, 4, 8], [0, 6, 12, 18, 24]
    final diag1Tiles = mapOfGroups[0]!.values.where((playerId) => playerId != -2);

    // Tile indexes: [2, 4, 6], [4, 8, 12, 16, 20]
    final diag2Tiles = mapOfGroups[1]!.values.where((playerId) => playerId != -2);

    /// Check if either group is full,
    /// and all matching the first `playerId` in the list.
    if (diag1Tiles.isNotEmpty) {
      final diag1FirstPlayerId = diag1Tiles.firstOrNull;
      if (diag1FirstPlayerId != null &&
          diag1Tiles.length == edgeSize &&
          diag1Tiles.every((playerId) => playerId == diag1FirstPlayerId)) {
        return (0, diag1FirstPlayerId);
      }
    }
    if (diag2Tiles.isNotEmpty) {
      final diag2FirstPlayerId = diag2Tiles.firstOrNull;
      if (diag2FirstPlayerId != null &&
          diag2Tiles.length == edgeSize &&
          diag2Tiles.every((playerId) => playerId == diag2FirstPlayerId)) {
        return (1, diag2FirstPlayerId);
      }
    }
    return null;
  }

  ///
  /// Entry methods
  ///
  /// Record: ( groupIndex, playerId -> winner )
  ///

  (int, int)? get checkAllRows {
    final mapOfGroups = _mapPlaysToRowGroups(); // { 0: [ playerId ], 1: [], 2: [] }
    return _checkFilled(mapOfGroups);
  }

  (int, int)? get checkAllCols {
    final mapOfGroups = _mapPlaysToColGroups(); // { 0: [ playerId ], 1: [], 2: [] }
    return _checkFilled(mapOfGroups);
  }

  (int, int)? get checkAllDiags {
    final mapOfGroups = _mapPlaysToDiagGroups(); // { 0: [ playerId ], 1: [], 2: [] }
    return _checkFilledDiags(mapOfGroups);
  }

  Map<MatchTupleEnum, Map<int, List<int>>> get filledAllRows {
    final filledPlaysMap = <MatchTupleEnum, Map<int, List<int>>>{
      MatchTupleEnum.row: _mapPlaysToRowGroups(), // { 0: [ playerId ], 1: [-1], 2: [-1] }
      MatchTupleEnum.column: _mapPlaysToColGroups(), // { 0: [ playerId ], 1: [], 2: [] }
      MatchTupleEnum.diagonal: _mapPlaysToDiagGroups().map(
        (key, value) => MapEntry(key, value.values.toList()),
      ),
    };
    return filledPlaysMap;
  }

  ///
  /// Utility methods
  ///

  List<int> get usedTileIndexes {
    final usedTiles = <int>[];
    for (var i = 0; i < boardSize; i++) {
      if (plays.any((play) => play.tileIndex == i)) {
        usedTiles.add(i);
      }
    }
    return usedTiles..sort();
  }

  List<int> get availableTileIndexes {
    final availableTiles = <int>[];
    for (var i = 0; i < boardSize; i++) {
      if (!plays.any((play) => play.tileIndex == i)) {
        availableTiles.add(i);
      }
    }
    return availableTiles..sort();
  }

  @override
  List<Object?> get props => [
        edgeSize,
        plays,
      ];
}
