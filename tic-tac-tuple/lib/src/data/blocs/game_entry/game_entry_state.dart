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

  Map<String, Icon> get usedSymbolList => Map<String, Icon>.fromEntries(
        players.map(
          (player) => MapEntry(player.userSymbol.markerKey, player.userSymbol.markerIcon),
        ),
      );

  Map<String, Icon> get unusedSymbolList => Map<String, Icon>.fromEntries(
        UserSymbol.markerList.entries.where((symbol) {
          final keyUsed = usedSymbolList.containsKey(symbol.key);
          return !keyUsed;
        }).map((symbol) {
          final mapEntry = MapEntry(symbol.key, symbol.value);
          return mapEntry;
        }),
      );

  Map<String, UserSymbol> get unusedSymbolTypesList => Map<String, UserSymbol>.fromEntries(
        // `skip(1)` | The first symbol is 'empty' and should not be used.
        UserSymbol.markerListTypes.entries.skip(1).where((symbol) {
          final keyUsed = usedSymbolList.containsKey(symbol.key);
          return !keyUsed;
        }).map((symbol) {
          final mapEntry = MapEntry(symbol.key, symbol.value);
          return mapEntry;
        }),
      );

  @override
  List<Object> get props => [
        edgeSize,
        players,
        allSavedPlayerNames,
      ];
}
