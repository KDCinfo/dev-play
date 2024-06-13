part of 'game_play_bloc.dart';

sealed class GamePlayEvent extends Equatable {
  const GamePlayEvent();
}

class GamePlayEndGameEvent extends GamePlayEvent {
  const GamePlayEndGameEvent({
    required this.gameData,
  });

  final GameData gameData;

  @override
  List<Object> get props => [
        gameData,
      ];
}

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
