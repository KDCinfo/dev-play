import 'package:dev_play_tictactoe/src/data/data.dart';

import 'package:equatable/equatable.dart';

/// `ScorebookData` is the app's global state.
///
/// It houses the current game (if any), and all
/// previously completed games (the current game
/// is moved to the `allGames` Map when completed).

/// Initial Data Design
///
///   // Reminder to convert `int` keys to `string` when JSONifying.
/// + allPlayers: Map<int, PlayerData>(playerId: PlayerData).putIfAbsent(currentPlayers)
///   // ^^^ This was changed to be a `List<PlayerData>`.
/// + allGames: <int, GameData>{ gameId1: GameData, gameId2: GameData }.add(GameData)
///
///   // This was nixed: not needed; overkill; superfluous; a micro-optimization.
/// + allGamesByPlayerId: Map<int, int>{ playerId: gameId1 }
///
///   // This was added.
/// + currentGame: GameData
///   ---
/// > Called from repository when data is retrieved from local storage.
/// + initGame(gameData.players) =>
///     allGames.add(),
///     allGamesByPlayerId.addAll(),
/// x   // allPlayers.putIfAbsent(),
///     allPlayers.addAll(),
/// > Called from repository when a play is made.
/// + updateGame(gameData) => allGames.updateWhere(gameData)
///
class ScorebookData extends Equatable {
  const ScorebookData({
    this.allPlayers = const [],
    this.allGames = const {},
    this.currentGame = const GameData(),
  });

  factory ScorebookData.initGame(GameData gameData) {
    return ScorebookData(
      currentGame: gameData,
      allPlayers: gameData.players,
    );
  }

  // JSON
  /// Instantiate from JSON.
  factory ScorebookData.fromJson(Map<String, dynamic> json) {
    return ScorebookData(
      allPlayers: (json['allPlayers'] as List<dynamic>)
          .map((e) => PlayerData.fromJson(e as Map<String, dynamic>))
          .toList(),
      allGames: (json['allGames'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(int.parse(key), GameData.fromJson(value as Map<String, dynamic>)),
      ),
      currentGame: GameData.fromJson(json['currentGame'] as Map<String, dynamic>),
    );
  }

  /// Convert to JSON.
  Map<String, dynamic> toJson() {
    return {
      'allPlayers': allPlayers.map((PlayerData e) => e.toJson()).toList(),
      'allGames': allGames.map(
        (key, value) => MapEntry(key.toString(), value.toJson()),
      ),
      'currentGame': currentGame.toJson(),
    };
  }

  // + allPlayers: List<PlayerData>[PlayerData].putIfAbsent(newGamePlayers)
  final List<PlayerData> allPlayers;

  // + allGames: <int, GameData>{ gameId1: GameData, gameId2: GameData }.add(GameData)
  final Map<int, GameData> allGames;

  /// Current Game
  final GameData currentGame;

  /// Initialize the Scorebook with a new game
  /// with data provided by the `GameEntry` screen.
  ScorebookData startGame(GameData gameData) {
    return copyWith(
      currentGame: gameData,
      allPlayers: gameData.players,
    );
  }

  /// Update the current game that's in progress.
  ScorebookData updateGame(GameData gameData) {
    return copyWith(
      currentGame: gameData,
    );
  }

  /// Record the game in the Scorebook.
  ScorebookData endGame(GameData gameData) {
    return copyWith(
      allGames: Map.of(allGames)..addAll({gameData.gameId: gameData}),
      currentGame: const GameData(),
    );
  }

  ScorebookData copyWith({
    List<PlayerData>? allPlayers,
    Map<int, GameData>? allGames,
    GameData? currentGame,
  }) {
    return ScorebookData(
      allPlayers: allPlayers ?? this.allPlayers,
      allGames: allGames ?? this.allGames,
      currentGame: currentGame ?? this.currentGame,
    );
  }

  @override
  List<Object?> get props => [
        allPlayers,
        allGames,
        currentGame,
      ];
}
