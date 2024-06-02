import 'package:dev_play_tictactuple/src/data/data.dart';

import 'package:equatable/equatable.dart';

/// `GameData` houses the gaming data for any
/// in progress games, and all completed games.
///
/// It's the nuts and bolts for every game and is fed to the
/// `GamePlay` bloc via a stream in the `Scorebook` repository.

/// Initial Data Design
///
/// [GameData](int gameId, <GamePlayer>[] players, gameBoard)
///
/// | Initial properties.
///   + gameId
///   + dateCreated => DateTime,
///   + players => <Map<int, GamePlayer>>[
///     { userId1, gamePlayer1 }, { userId2, gamePlayer2 },
///   ]
///
/// | Properties updated during the game.
///   + dateLastPlayed => DateTime,
///   + plays => <PlayerTurn>[].add(PlayerTurn)
///   + gameBoard
///
/// | Properties stored at the end of the game.
///   + endGameScore => {
///     userId1: score, // +1 for each game won; +0 for lost games.
///     userId2: score,
///   }
///   + gameStatus => [GameStatus => GameStatusIP, GameStatusComplete]

class GameData extends Equatable {
  const GameData({
    this.dateCreated, // This is set when a game is started.
    this.gameId = -1, // For initialization purposes only.
    this.players = const <PlayerData>[],
    this.gameBoardData = const GameBoardData(),
    this.dateLastPlayed,
    this.winnerId = -1,
    this.gameStatus = const GameStatusEntryMode(),
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

  GameData endGame({
    required int winnerId,
  }) {
    return copyWith(
      winnerId: winnerId,
      gameStatus: const GameStatusComplete(),
    );
  }

  int get previousPlayerIndex => players.isEmpty || gameBoardData.plays.isEmpty
      ? -1
      : (gameBoardData.plays.length - 1) % players.length;
  int get currentPlayerIndex => players.isEmpty ? -1 : gameBoardData.plays.length % players.length;
  int get currentPlayerId => players[currentPlayerIndex].playerId!;

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
  // @TODO: Add this `winnerRowColDiag` property
  //        (to store the winning row, column, or diagonal).
  //        - int:            WinnerId
  //        - MatchTupleEnum: Row/Col/Diag
  //        - int:            Which row, column, or diagonal
  //          - Diagonals have 2 counts; #1 is top-left to bottom-right.
  // final (int, MatchTupleEnum, int)? winnerRowColDiag;

  GameData copyWith({
    // Used with `playTurn` method.
    DateTime? dateLastPlayed,
    GameBoardData? gameBoardData,
    // Used with `endGame` method.
    int? winnerId,
    GameStatus? gameStatus,
  }) {
    return GameData(
      gameId: gameId,
      dateCreated: dateCreated,
      players: players,
      dateLastPlayed: dateLastPlayed ?? this.dateLastPlayed,
      gameBoardData: gameBoardData ?? this.gameBoardData,
      winnerId: winnerId ?? this.winnerId,
      gameStatus: gameStatus ?? this.gameStatus,
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
      ];
}
