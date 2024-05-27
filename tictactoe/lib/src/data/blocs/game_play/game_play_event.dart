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

class GamePlayMoveEvent extends GamePlayEvent {
  const GamePlayMoveEvent({
    required this.gameData,
  });

  final GameData gameData;

  @override
  List<Object> get props => [
        gameData,
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
