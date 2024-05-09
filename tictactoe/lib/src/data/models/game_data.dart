import 'package:dev_play_tictactoe/src/data/data.dart';

import 'package:equatable/equatable.dart';

/// Initial Data Design
///
/// ## Persisted Data
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

typedef PlayerListByIdDef = List<Map<int, PlayerData>>;

class GameData extends Equatable {
  const GameData({
    required this.gameId,
    required this.dateCreated,
    required this.players,
    required this.dateLastPlayed,
    required this.plays,
    required this.gameBoard,
    required this.endGameScore,
    required this.gameStatus,
  });

  /// Initial game properties.
  final int gameId;
  final DateTime dateCreated;
  final PlayerListByIdDef players;

  /// Properties updated during a game.
  final DateTime dateLastPlayed;
  final List<PlayerTurn> plays;
  final List<List<int>> gameBoard;

  /// Properties stored at the end of a game.
  final Map<int, int> endGameScore;
  final GameStatus gameStatus;

  GameData copyWith({
    int? gameId,
    DateTime? dateCreated,
    PlayerListByIdDef? players,
    DateTime? dateLastPlayed,
    List<PlayerTurn>? plays,
    List<List<int>>? gameBoard,
    Map<int, int>? endGameScore,
    GameStatus? gameStatus,
  }) {
    return GameData(
      gameId: gameId ?? this.gameId,
      dateCreated: dateCreated ?? this.dateCreated,
      players: players ?? this.players,
      dateLastPlayed: dateLastPlayed ?? this.dateLastPlayed,
      plays: plays ?? this.plays,
      gameBoard: gameBoard ?? this.gameBoard,
      endGameScore: endGameScore ?? this.endGameScore,
      gameStatus: gameStatus ?? this.gameStatus,
    );
  }

  @override
  List<Object?> get props => [
        gameId,
        dateCreated,
        players,
        dateLastPlayed,
        plays,
        gameBoard,
        endGameScore,
        gameStatus,
      ];
}
