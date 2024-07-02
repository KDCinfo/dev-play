import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/data.dart';

import 'package:equatable/equatable.dart';

/// `GameData` houses the gaming data for any
/// in progress games, and all completed games.
///
/// It's the nuts and bolts for every game and is fed to the
/// `GamePlay` bloc via a stream in the `Scorebook` repository.
///
class GameData extends Equatable {
  const GameData({
    this.dateCreated, // This is set when a game is started.
    this.gameId = -1, // For initialization purposes only.
    this.players = const <PlayerData>[],
    this.gameBoardData = const GameBoardData(),
    this.dateLastPlayed,
    this.winnerId = -1,
    this.gameStatus = const GameStatusEntryMode(),
    this.winnerRowColDiag,
  });

  factory GameData.startGame({
    required int gameId,
    required List<PlayerData> players,
    required GameBoardData gameBoardData,
  }) {
    return GameData(
      dateCreated: DateTime.now(),
      gameId: gameId,
      players: players,
      gameBoardData: gameBoardData,
      // gameBoardData: List<List<int>> | List.generate(3, (_) => List.generate(3, (_) => 0)),
      gameStatus: const GameStatusInProgress(),
    );
  }

  /// Reset game by setting gameId to -1.
  factory GameData.resetGame(GameData currentGameData) {
    return GameData(
      // gameId: -1,
      dateCreated: currentGameData.dateCreated,
      players: currentGameData.players,
      gameBoardData: currentGameData.gameBoardData,
      dateLastPlayed: currentGameData.dateLastPlayed,
      winnerId: currentGameData.winnerId,
      gameStatus: currentGameData.gameStatus,
      // winnerRowColDiag: null,
    );
  }

  GameData gameDataPlayTurn({
    required GameBoardData gameBoardData,
  }) {
    return copyWith(
      dateLastPlayed: DateTime.now(),
      gameBoardData: gameBoardData,
    );
  }

  /// The `winnerRowColDiag` property is a nullable typedef: (MatchTupleEnum, int)?
  GameData endGame({
    required int winnerId,
    required WinnerRowColDiagDef winnerRowColDiag,
  }) {
    return copyWith(
      winnerId: winnerId,
      gameStatus: const GameStatusComplete(),
      winnerRowColDiag: winnerRowColDiag,
    );
  }

  int get previousPlayerIndex => players.isEmpty || gameBoardData.plays.isEmpty
      ? -1
      : (gameBoardData.plays.length - 1) % players.length;
  int get currentPlayerIndex => players.isEmpty ? -1 : gameBoardData.plays.length % players.length;
  int get currentPlayerId => players.elementAtOrNull(currentPlayerIndex)?.playerId ?? -3;

  /// Initial game properties.
  ///
  final int gameId;
  final DateTime? dateCreated;
  final List<PlayerData> players;

  /// Properties updated during a game.
  ///
  final DateTime? dateLastPlayed;
  final GameBoardData gameBoardData;

  /// Properties stored at the end of a game.
  ///
  final int winnerId; // was endGameScore
  final GameStatus gameStatus;

  /// The `winnerRowColDiag` property stores the winning `row`,
  /// `column`, or `diagonal` and its index as a record: (MatchTupleEnum, int)?
  ///
  /// - $1: MatchTupleEnum: Row/Col/Diag
  /// - $2: int:            Which row, column, or diagonal
  ///                       - Diagonals have 2 counts; #1 is top-left to bottom-right.
  ///
  final WinnerRowColDiagDef winnerRowColDiag;

  GameData copyWith({
    // Used with `playTurn` method.
    DateTime? dateLastPlayed,
    GameBoardData? gameBoardData,
    // Used with `endGame` method.
    int? winnerId,
    GameStatus? gameStatus,
    WinnerRowColDiagDef? winnerRowColDiag,
  }) {
    return GameData(
      gameId: gameId,
      dateCreated: dateCreated,
      players: players,
      dateLastPlayed: dateLastPlayed ?? this.dateLastPlayed,
      gameBoardData: gameBoardData ?? this.gameBoardData,
      winnerId: winnerId ?? this.winnerId,
      gameStatus: gameStatus ?? this.gameStatus,
      winnerRowColDiag: winnerRowColDiag ?? this.winnerRowColDiag,
    );
  }

  // toJson
  Map<String, dynamic> toJson() => {
        'gameId': gameId,
        'dateCreated': dateCreated?.toIso8601String(),
        'players': players.map((player) => player.toJson()).toList(),
        'dateLastPlayed': dateLastPlayed?.toIso8601String(),
        'gameBoardData': gameBoardData,
        'winnerId': winnerId,
        'gameStatus': gameStatus,
        'winnerRowColDiag': winnerRowColDiag == null
            ? null
            : {
                '0': winnerRowColDiag!.$1.toString(),
                '1': winnerRowColDiag!.$2,
              },
      };

  // fromJson
  // ignore: sort_constructors_first
  factory GameData.fromJson(Map<String, dynamic> json) {
    return GameData(
      gameId: json['gameId'] as int,
      dateCreated:
          json['dateCreated'] != null ? DateTime.tryParse(json['dateCreated'] as String) : null,
      players: (json['players'] as List<dynamic>)
          .map((player) => PlayerData.fromJson(player as Map<String, dynamic>))
          .toList(),
      dateLastPlayed: json['dateLastPlayed'] != null
          ? DateTime.tryParse(json['dateLastPlayed'] as String)
          : null,
      gameBoardData: GameBoardData.fromJson(json['gameBoardData'] as Map<String, dynamic>),
      winnerId: json['winnerId'] as int,
      gameStatus: GameStatus.fromJson(json['gameStatus'] as Map<String, dynamic>),
      winnerRowColDiag: json['winnerRowColDiag'] == null
          ? null
          : (
              MatchTupleEnum.fromJson(
                (json['winnerRowColDiag'] as dynamic)['0'] as String,
              ),
              (json['winnerRowColDiag'] as dynamic)['1'] as int,
            ),
    );
  }

  @override
  List<Object?> get props => [
        gameId,
        dateCreated,
        players,
        dateLastPlayed,
        gameBoardData,
        winnerId,
        gameStatus,
        winnerRowColDiag,
      ];
}
