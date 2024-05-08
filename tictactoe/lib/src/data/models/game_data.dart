import 'package:dev_play_tictactoe/src/data/data.dart';

import 'package:equatable/equatable.dart';

/// Initial Data Design
///
/// ## Persisted Data
/// [GameData](int gameId, <GamePlayer>[] players, gameBoard)
///   + gameId
///   + dateCreated => DateTime,
///   + dateLastPlayed => DateTime,
///   + gameStatus => [GameStatus => GameStatusIP, GameStatusComplete]
///   + plays => <PlayerTurn>[].add(PlayerTurn)
///   + players => <Map<int, GamePlayer>>[
///     { userId1, gamePlayer1 }, { userId2, gamePlayer2 },
///   ]
///   + gameBoard
///   + endGameScore => {
///     userId1: score, // +1 for each game won; +0 for lost games.
///     userId2: score,
///   }

typedef PlayerListByIdDef = List<Map<int, PlayerData>>;

class GameData extends Equatable {
  const GameData({
    required this.gameId,
    required this.dateCreated,
    required this.dateLastPlayed,
    required this.gameStatus,
    required this.plays,
    required this.players,
    required this.gameBoard,
    required this.endGameScore,
  });

  final int gameId;
  final DateTime dateCreated;
  final DateTime dateLastPlayed;
  final GameStatus gameStatus;
  final List<PlayerTurn> plays;
  final PlayerListByIdDef players;
  final List<List<int>> gameBoard;
  final Map<int, int> endGameScore;

  GameData copyWith({
    int? gameId,
    DateTime? dateCreated,
    DateTime? dateLastPlayed,
    GameStatus? gameStatus,
    List<PlayerTurn>? plays,
    PlayerListByIdDef? players,
    List<List<int>>? gameBoard,
    Map<int, int>? endGameScore,
  }) {
    return GameData(
      gameId: gameId ?? this.gameId,
      dateCreated: dateCreated ?? this.dateCreated,
      dateLastPlayed: dateLastPlayed ?? this.dateLastPlayed,
      gameStatus: gameStatus ?? this.gameStatus,
      plays: plays ?? this.plays,
      players: players ?? this.players,
      gameBoard: gameBoard ?? this.gameBoard,
      endGameScore: endGameScore ?? this.endGameScore,
    );
  }

  @override
  List<Object?> get props => [
        gameId,
        dateCreated,
        dateLastPlayed,
        gameStatus,
        plays,
        players,
        gameBoard,
        endGameScore,
      ];
}
