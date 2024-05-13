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

  bool checkDiags(int boardSize) {
    final diag1 = <PlayerTurn>[];
    final diag2 = <PlayerTurn>[];
    for (var i = 0; i < boardSize; i += edgeSize + 1) {
      diag1.add(plays[i]);
    }
    for (var i = edgeSize - 1; i < boardSize - 1; i += edgeSize - 1) {
      diag2.add(plays[i]);
    }
    if (diag1.every((play) => play.tileIndex == diag1.first.tileIndex) ||
        diag2.every((play) => play.tileIndex == diag2.first.tileIndex)) {
      return true;
    }
    return false;
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

  (int, int)? get checkAllRows {
    final mapOfGroups = mapPlaysToRowGroups(); // { 0: [ playerId ], 1: [], 2: [] }
    return checkFilled(mapOfGroups);
  }

  (int, int)? get checkAllCols {
    final mapOfGroups = mapPlaysToColGroups(); // { 0: [ playerId ], 1: [], 2: [] }
    return checkFilled(mapOfGroups);
  }

  List<int> get diagFilled {
    final diag1 = <PlayerTurn>[];
    final diag2 = <PlayerTurn>[];
    for (var i = 0; i < boardSize; i += edgeSize + 1) {
      diag1.add(plays[i]);
    }
    for (var i = edgeSize - 1; i < boardSize - 1; i += edgeSize - 1) {
      diag2.add(plays[i]);
    }
    if (diag1.every((play) => play.tileIndex == diag1.first.tileIndex) ||
        diag2.every((play) => play.tileIndex == diag2.first.tileIndex)) {
      return diag1.every((play) => play.tileIndex == diag1.first.tileIndex)
          ? List.generate(edgeSize, (index) => index * (edgeSize + 1))
          : List.generate(edgeSize, (index) => (index + 1) * (edgeSize - 1));
    }
    return [];
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
