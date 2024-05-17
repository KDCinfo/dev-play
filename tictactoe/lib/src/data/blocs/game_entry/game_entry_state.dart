part of 'game_entry_bloc.dart';

class GameEntryState extends Equatable {
  const GameEntryState({
    this.edgeSize = 3,
    this.players = const <PlayerData>[],
    this.allSavedPlayerNames = const <String>[],
  });

  /// --> edgeSize => GameBoard(int edgeSize) [3-5]
  final int edgeSize;

  /// Who will be playing this game? [1-4]
  /// --> players => List.of(PlayerData())
  final List<PlayerData> players;

  /// ScorebookRepository<ScorebookData>().allPlayers
  /// --> allSavedPlayerNames => allPlayers.forEach(PlayerData().name)
  final List<String> allSavedPlayerNames;

  /// copyWith
  GameEntryState copyWith({
    int? edgeSize,
    List<PlayerData>? players,
    List<String>? allSavedPlayerNames,
  }) {
    return GameEntryState(
      edgeSize: edgeSize ?? this.edgeSize,
      players: players ?? this.players,
      allSavedPlayerNames: allSavedPlayerNames ?? this.allSavedPlayerNames,
    );
  }

  @override
  List<Object> get props => [
        edgeSize,
        players,
        allSavedPlayerNames,
      ];
}
