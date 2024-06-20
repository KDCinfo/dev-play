import 'package:dev_play_tictactuple/src/data/data.dart';

import 'package:equatable/equatable.dart';

/// `ScorebookData` is the app's overall state.
///
/// It houses the current game (if any), and all previously completed games
/// (the current game is moved to the `allGames` Map when completed).
///
class ScorebookData extends Equatable {
  const ScorebookData({
    this.allPlayers = const [],
    this.allGames = const {},
    this.currentGame = const GameData(),
    this.endGameScores = const {},
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
    final tempAllPlayers = (json['allPlayers'] as List<dynamic>)
        .map((e) => PlayerData.fromJson(e as Map<String, dynamic>))
        .toList();
    final tempAllGames = (json['allGames'] as Map<String, dynamic>).map(
      (key, value) => MapEntry(int.parse(key), GameData.fromJson(value as Map<String, dynamic>)),
    );
    final tempCurrentGame = GameData.fromJson(
      json['currentGame'] as Map<String, dynamic>,
    );
    final tempEndGameScores = Map<int, int>.of(
      (json['endGameScores'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(int.parse(key), value as int),
      ),
    );
    return ScorebookData(
      allPlayers: tempAllPlayers,
      allGames: tempAllGames,
      currentGame: tempCurrentGame,
      endGameScores: tempEndGameScores,
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
      'endGameScores': endGameScores.map(
        (key, value) => MapEntry(key.toString(), value),
      ),
    };
  }

  // toString
  @override
  String toString() {
    return 'ScorebookData{\n'
        '  allPlayers: $allPlayers,\n'
        '  allGames: $allGames,\n'
        '  currentGame: $currentGame\n'
        '  endGameScores: $endGameScores\n'
        '}';
  }

  /// This is a list of all played players, but only the
  /// names are extracted for use in the `PlayerList` popup menu.
  ///
  /// + allPlayers: List<PlayerData>[PlayerData].putIfAbsent(newGamePlayers)
  final List<PlayerData> allPlayers;

  /// This gets updated when a game is completed.
  ///
  /// + allGames: <int, GameData>{ gameId1: GameData, gameId2: GameData }.add(GameData)
  final Map<int, GameData> allGames;

  /// This is a map of wins mapped by playerId.
  ///
  /// { playerId, wins }
  final Map<int, int> endGameScores;

  /// Current Game
  final GameData currentGame;

  /// Initialize the Scorebook with a new game
  /// with data provided by the `GameEntry` screen.
  ScorebookData startGame({
    required GameData gameData,
    required List<PlayerData> newAllPlayers,
  }) {
    return copyWith(
      currentGame: gameData,
      allPlayers: List.of(allPlayers)..addAll(newAllPlayers),
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
      currentGame: gameData.copyWith(
        gameStatus: const GameStatusComplete(),
      ),
      endGameScores: Map<int, int>.of(endGameScores)
        ..update(
          gameData.winnerId,
          (value) => value + 1,
          ifAbsent: () => 1,
        ),
    );
  }

  /// Reset the current game which sets `gameId: -1`
  /// which triggers a `BlocListener` in `GameEntry`.
  ScorebookData resetGame(GameData gameData) {
    return copyWith(
      currentGame: GameData(
        players: gameData.players,
      ),
    );
  }

  ScorebookData clearGame() {
    return copyWith(
      currentGame: const GameData(),
    );
  }

  ScorebookData copyWith({
    List<PlayerData>? allPlayers,
    Map<int, GameData>? allGames,
    GameData? currentGame,
    Map<int, int>? endGameScores,
  }) {
    return ScorebookData(
      allPlayers: allPlayers ?? this.allPlayers,
      allGames: allGames ?? this.allGames,
      currentGame: currentGame ?? this.currentGame,
      endGameScores: endGameScores ?? this.endGameScores,
    );
  }

  @override
  List<Object?> get props => [
        allPlayers,
        allGames,
        currentGame,
        endGameScores,
      ];
}
