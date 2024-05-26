part of 'game_play_bloc.dart';

sealed class GamePlayEvent extends Equatable {
  const GamePlayEvent();
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
