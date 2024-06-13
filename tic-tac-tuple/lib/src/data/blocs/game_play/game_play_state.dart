part of 'game_play_bloc.dart';

class GamePlayState extends Equatable {
  const GamePlayState({
    this.currentGame = const GameData(),
  });

  final GameData currentGame;

  /// copyWith
  GamePlayState copyWith({
    GameData? currentGame,
  }) {
    return GamePlayState(
      currentGame: currentGame ?? this.currentGame,
    );
  }

  @override
  List<Object> get props => [
        currentGame,
      ];
}
