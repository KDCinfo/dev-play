part of 'game_play_bloc.dart';

class GamePlayState extends Equatable {
  const GamePlayState({
    this.currentGame = const GameData(),
    this.pausedGame = const GameData(),
  });

  final GameData currentGame;
  final GameData pausedGame;

  GamePlayState copyWith({
    GameData? currentGame,
    GameData? pausedGame,
  }) {
    return GamePlayState(
      currentGame: currentGame ?? this.currentGame,
      pausedGame: pausedGame ?? this.pausedGame,
    );
  }

  @override
  List<Object> get props => [
        currentGame,
        pausedGame,
      ];
}
