part of 'game_entry_bloc.dart';

abstract class GameEntryEvent extends Equatable {
  const GameEntryEvent();

  @override
  List<Object?> get props => [];
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

class GameEntrySymbolSelectedEvent extends GameEntryEvent {
  const GameEntrySymbolSelectedEvent({
    required this.playerNum,
    required this.selectedSymbolKey,
  });

  final int playerNum;
  final String selectedSymbolKey;

  @override
  List<Object> get props => [
        playerNum,
        selectedSymbolKey,
      ];
}

class GameEntryChangeNameEvent extends GameEntryEvent {
  const GameEntryChangeNameEvent({
    required this.playerNum,
    required this.playerName,
  });

  final int playerNum;
  final String playerName;

  @override
  List<Object?> get props => [
        playerNum,
        playerName,
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

class GameEntryResetGameEvent extends GameEntryEvent {
  const GameEntryResetGameEvent();

  @override
  List<Object> get props => [];
}

class GameEntryStartGameEvent extends GameEntryEvent {
  const GameEntryStartGameEvent();

  @override
  List<Object> get props => [];
}
