import 'package:dev_play_tictactoe/src/data/data.dart';

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
    this.endGameScore = const <int, int>{},
    this.gameStatus = const GameStatusInProgress(),
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
    );
  }

  GameData playTurn({
    required GameBoardData gameBoardData,
  }) {
    return copyWith(
      dateLastPlayed: DateTime.now(),
      gameBoardData: gameBoardData,
    );
  }

  GameData endGame({
    required Map<int, int> endGameScore,
  }) {
    return copyWith(
      endGameScore: endGameScore,
      gameStatus: const GameStatusComplete(),
    );
  }

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
  final Map<int, int> endGameScore;
  final GameStatus gameStatus;

  GameData copyWith({
    // Used with `playTurn` method.
    DateTime? dateLastPlayed,
    GameBoardData? gameBoardData,
    // Used with `endGame` method.
    Map<int, int>? endGameScore,
    GameStatus? gameStatus,
  }) {
    return GameData(
      gameId: gameId,
      dateCreated: dateCreated,
      players: players,
      dateLastPlayed: dateLastPlayed ?? this.dateLastPlayed,
      gameBoardData: gameBoardData ?? this.gameBoardData,
      endGameScore: endGameScore ?? this.endGameScore,
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
        'endGameScore': endGameScore,
        'gameStatus': gameStatus,
      };

  // fromJson
  // ignore: sort_constructors_first
  factory GameData.fromJson(Map<String, dynamic> json) {
    return GameData(
      gameId: json['gameId'] as int,
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      players: (json['players'] as List<dynamic>)
          .map((player) => PlayerData.fromJson(player as Map<String, dynamic>))
          .toList(),
      dateLastPlayed: DateTime.parse(json['dateLastPlayed'] as String),
      gameBoardData: json['gameBoardData'] as GameBoardData,
      endGameScore: json['endGameScore'] as Map<int, int>,
      gameStatus: json['gameStatus'] as GameStatus,
    );
  }

  @override
  List<Object?> get props => [
        gameId,
        dateCreated,
        players,
        dateLastPlayed,
        gameBoardData,
        endGameScore,
        gameStatus,
      ];
}
