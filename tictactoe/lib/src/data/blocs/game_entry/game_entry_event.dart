part of 'game_entry_bloc.dart';

abstract class GameEntryEvent extends Equatable {
  const GameEntryEvent();

  @override
  List<Object> get props => [];
}

/// There is no event handler for this event.
/// It is called when the stream is updated which
/// then updates the `allSavedPlayerNames` property.
///
class GameEntryUpdateEvent extends GameEntryEvent {
  const GameEntryUpdateEvent({
    required this.edgeSize,
    required this.players,
    required this.allSavedPlayerNames,
  });

  final int edgeSize;
  final List<PlayerData> players;
  final List<String> allSavedPlayerNames;

  @override
  List<Object> get props => [
        edgeSize,
        players,
        allSavedPlayerNames,
      ];
}

class GameEntryPlayerListEvent extends GameEntryEvent {
  const GameEntryPlayerListEvent({
    required this.playerList,
  });

  final List<PlayerData> playerList;

  @override
  List<Object> get props => [
        playerList,
      ];
}

class GameEntryEdgeSizeEvent extends GameEntryEvent {
  const GameEntryEdgeSizeEvent({
    required this.edgeSize,
  });

  final int edgeSize;

  @override
  List<Object> get props => [
        edgeSize,
      ];
}

class GameEntryStartGameEvent extends GameEntryEvent {
  const GameEntryStartGameEvent();

  @override
  List<Object> get props => [];
}
