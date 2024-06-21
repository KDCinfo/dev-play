part of 'game_play_bloc.dart';

sealed class GamePlayEvent extends Equatable {
  const GamePlayEvent();
}

/// This is equivalent to pausing the game.
/// It is used during game play when the 'Return Home' button is pressed.
class GamePlayReturnHomeEvent extends GamePlayEvent {
  const GamePlayReturnHomeEvent({
    required this.gameDataReset,
    required this.gameDataPaused,
  });

  final GameData gameDataReset;
  final GameData gameDataPaused;

  @override
  List<Object> get props => [
        gameDataReset,
        gameDataPaused,
      ];
}

/// This will reset both `currentGame` and `pausedGame`.
/// It is used when a game is complete.
class GamePlayResetGameEvent extends GamePlayEvent {
  const GamePlayResetGameEvent();

  @override
  List<Object> get props => [];
}

class GamePlayBotMoveRequestedEvent extends GamePlayEvent {
  const GamePlayBotMoveRequestedEvent();

  @override
  List<Object> get props => [];
}

class GamePlayMoveEvent extends GamePlayEvent {
  const GamePlayMoveEvent({
    required this.tileIndex,
  });

  final int tileIndex;

  @override
  List<Object> get props => [
        tileIndex,
      ];
}

class GamePlayUpdatedEvent extends GamePlayEvent {
  const GamePlayUpdatedEvent({
    required this.gameData,
  });

  final GameData gameData;

  @override
  List<Object> get props => [
        gameData,
      ];
}
