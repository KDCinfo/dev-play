import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/data/models/models.dart';

import 'package:equatable/equatable.dart';

/// Initial Data Design
///
/// [GameBoard](int edgeSize, List<PlayerTurn>[] plays)
///   - _boardSize => edgeSize * edgeSize
///   get rowFilled => checkRows(_boardSize)
///   get colFilled => checkCols(_boardSize)
///   get diagFilled => checkDiags(_boardSize)
///   get usedTiles => plays.where(play.playerTurnId) // <Tiles>[]
///   get availableTiles => _boardSize - usedTiles // <Tiles>[]
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

  /// This is used when a game is started, when transitioning
  /// from `GameEntry` to `GamePlay` initialization.
  GameBoardData changeEdgeSize({
    required int edgeSize,
  }) {
    return GameBoardData(
      edgeSize: edgeSize,
      plays: plays,
    );
  }

  Map<int, List<int>> initializeCheckMap() {
    final checkMap = <int, List<int>>{};
    for (var j = 0; j < boardSize; j += edgeSize) {
      checkMap.putIfAbsent(
        j ~/ edgeSize,
        () => <int>[],
      );
    }
    return checkMap;
  }

  Map<int, List<int>> mapPlaysToRowGroups() {
    ///
    /// Prepopulate the Map with an empty List for each group.
    ///   <int, List<int>>{ groupIndex: [ playerId ], }
    ///   <int, List<int>>{      0    : [ 1, 1, 1  ], 1: [], 2: [] }
    ///                     First Row :   ^ Win ^ --> PlayerID: 1
    ///
    final mapOfRowGroups = initializeCheckMap();

    /// Add a `playerId` to
    for (final play in plays) {
      ///
      /// Per-row group index: 0, 1, 2, [3, 4]
      ///
      final groupIndexRow = play.tileIndex ~/ edgeSize;

      if (mapOfRowGroups[groupIndexRow] != null) {
        final playerId = play.occupiedBy.playerId!;
        final newRowList = List.of(mapOfRowGroups[groupIndexRow]!)..add(playerId);
        mapOfRowGroups.update(groupIndexRow, (_) => newRowList);
      }
    }
    return mapOfRowGroups;
  }

  /// Same as `mapPlaysToRowGroups` but uses a modulo (`%`) to set up the groups.
  ///
  Map<int, List<int>> mapPlaysToColGroups() {
    final mapOfColGroups = initializeCheckMap();

    for (final play in plays) {
      ///
      /// Per-column group index: 0, 1, 2, [3, 4]
      ///
      final groupIndexCol = play.tileIndex % edgeSize;

      if (mapOfColGroups[groupIndexCol] != null) {
        final playerId = play.occupiedBy.playerId!;
        final newColList = List.of(mapOfColGroups[groupIndexCol]!)..add(playerId);
        mapOfColGroups.update(groupIndexCol, (_) => newColList);
      }
    }
    return mapOfColGroups;
  }

  /// [[COMPLETE]]
  ///
  (int, int)? get checkDiags {
    /// Initialize `mapOfGroups` with [1st] and [2nd] diag groups.
    final mapOfGroups = <int, List<int>>{
      0: <int>[], // 1st diag group
      1: <int>[], // 2nd diag group
    };

    /// Record all the indexes that make up the [1st] diag group.
    for (var tileIndex = 0; tileIndex < boardSize; tileIndex += edgeSize + 1) {
      // [0] += 3 + 1 == 4
      // [4] += 3 + 1 == 8
      // [8] += 3 + 1 == 12 (> boardSize)
      if (mapOfGroups[0] != null) {
        mapOfGroups[0]!.add(tileIndex);
      }
    }

    /// Record all the indexes that make up the [2nd] diag group.
    for (var tileIndex = edgeSize - 1; tileIndex < boardSize - 1; tileIndex += edgeSize - 1) {
      // 3 - 1 == [2] | 2 += 3 - 1 == [4]
      //          [4] | 4 += 3 - 1 == [6]
      //          [6] | 6 += 3 - 1 == [8] (! < boardSize - 1)
      // diag2.add(plays[i]);
      if (mapOfGroups[1] != null) {
        mapOfGroups[1]!.add(tileIndex);
      }
    }

    final diag1Tiles = mapOfGroups[0]!; // Tile indexes: [0, 4, 8], [0, 6, 12, 18, 24]
    final diag2Tiles = mapOfGroups[1]!; // Tile indexes: [2, 4, 6], [4, 8, 12, 16, 20]

    /// Store each played `playerId` that matches a
    /// stored group index for either `diag1` or `diag2`.
    final diag1Players = <int>[];
    final diag2Players = <int>[];

    for (final play in plays) {
      if (diag1Tiles.contains(play.tileIndex)) {
        diag1Players.add(play.occupiedBy.playerId!);
      }
      if (diag2Tiles.contains(play.tileIndex)) {
        diag2Players.add(play.occupiedBy.playerId!);
      }
    }

    /// Check if either group is full,
    /// and all matching the first `playerId` in the list.
    if (diag1Players.isNotEmpty) {
      final diag1FirstPlayerId = diag1Players.first;
      if (diag1Players.length == edgeSize &&
          diag1Players.every((playerId) => playerId == diag1FirstPlayerId)) {
        return (0, diag1FirstPlayerId);
      }
    }
    if (diag2Players.isNotEmpty) {
      final diag2FirstPlayerId = diag2Players.first;
      if (diag2Players.length == edgeSize &&
          diag2Players.every((playerId) => playerId == diag2FirstPlayerId)) {
        return (1, diag2FirstPlayerId);
      }
    }

    return null;
  }

  /// Used with `checkAllRows` and `checkAllCols`.
  /// Return: ( groupIndex, playerId )
  ///
  (int, int)? checkFilled(Map<int, List<int>> mapOfGroups) {
    var groupIndex = 0;
    for (final playerIdList in mapOfGroups.values) {
      if (playerIdList.isNotEmpty) {
        // Establish a baseline playerId to check against.
        final firstPlayerId = playerIdList.first;

        // Check for a full list of the same player.
        if (playerIdList.length == edgeSize &&
            playerIdList.every(
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

  /// Record: ( groupId, playerId )
  (int, int)? get checkAllRows {
    final mapOfGroups = mapPlaysToRowGroups(); // { 0: [ playerId ], 1: [], 2: [] }
    return checkFilled(mapOfGroups);
  }

  (int, int)? get checkAllCols {
    final mapOfGroups = mapPlaysToColGroups(); // { 0: [ playerId ], 1: [], 2: [] }
    return checkFilled(mapOfGroups);
  }

  // Record: ( groupIndex: playerId -> winner )
  (int, int)? get checkAllDiags {
    return checkDiags;
  }

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

  GameBoardData copyWith({
    required List<PlayerTurn> plays,
  }) {
    return GameBoardData(
      edgeSize: edgeSize,
      plays: plays,
    );
  }

  @override
  List<Object?> get props => [
        edgeSize,
        plays,
      ];
}
