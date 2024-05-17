import 'dart:async';

import 'package:dev_play_tictactoe/src/data/models/models.dart';
import 'package:dev_play_tictactoe/src/data/service_repositories/service_repositories.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_entry_event.dart';
part 'game_entry_state.dart';

/// Initial Data Design
///
/// [[GameInit]]
/// + Ask for - playerList [1-4]:
///   - name(s) | or select from `ScoreBook.allPlayers`
///   - symbol(s) | select from prefilled symbols list
/// + Ask for board size (edgeSize) | Assert: 5 >= edgeSize[3] > players.length >= 1

/// --> gameId => ScoreBook.allGames.keys.last+1 // Get last `gameId` from `ScoreBook.allGames`
/// --> players => List.of(playerList.forEach(PlayerData(name, symbol)))
/// --> gameBoard => GameBoard(int edgeSize)
/// --> gameData => [GameData](int gameId, <PlayerData>[] players, gameBoard)
/// --> [GamePlay](gameData)
/// --> [[ScoreBook]].initGame(gameData)

/// Listen to Stream.allPlayers
/// - Update `allSavedPlayerNames`
///
/// Update when UI is updated
/// - `edgeSize`
/// - `playerList`
///
/// Create when game is started
/// --> gameData => [GameData](int gameId, <PlayerData>[] players, gameBoard)
///   --> gameId => ScoreBook.allGames.keys.last+1 // Get last `gameId` from `ScoreBook.allGames`
///   --> GameBoard(int edgeSize)
///   --> [[ScoreBook]].initGame(gameData)
///       Use existing `scorebookData` state;
///       run with new `GameEntry` data:
///       > scorebookData.startGame(GameData gameData)
///       Update the repository with that new `scorebookData`.
///       Having a ScorebookData with a currentGame gameID of -1 shows entry screen.
///
class GameEntryBloc extends Bloc<GameEntryEvent, GameEntryState> {
  GameEntryBloc({
    required ScorebookRepository scorebookRepository,
  })  : _scorebookRepository = scorebookRepository,
        super(const GameEntryState()) {
    //
    on<GameEntryPlayerListEvent>(_updateBlocPlayerList);
    on<GameEntryEdgeSizeEvent>(_updateBlocEdgeSize);
    on<GameEntryStartGameEvent>(_updateBlocStartGame);

    /// This will update the `allSavedPlayerNames` list in the UI.
    _scorebookStreamListener = _scorebookRepository.scorebookDataStream.listen(
      (ScorebookData scorebookData) => _updateBlocFromStream,
    );
  }

  final ScorebookRepository _scorebookRepository;

  late final StreamSubscription<ScorebookData> _scorebookStreamListener;

  @override
  Future<void> close() {
    _scorebookStreamListener.cancel();
    return super.close();
  }

  void _updateBlocFromStream(ScorebookData scorebookData) {
    add(
      GameEntryUpdateEvent(
        edgeSize: state.edgeSize,
        players: state.players,
        allSavedPlayerNames: scorebookData.allPlayers.map((player) => player.playerName).toList(),
      ),
    );
  }

  void _updateBlocStartGame(
    GameEntryStartGameEvent event,
    Emitter<GameEntryState> emit,
  ) {
    // If `players` has only 1 player, add a `bot` to the player list.
    if (state.players.length == 1) {
      state.players.add(
        const PlayerData(
          playerId: -1,
          playerNum: 2,
          playerName: 'Botuple',
          userSymbol: UserSymbolX(),
          // playerType: const PlayerTypeBot(),
        ),
      );
    }

    final gameData = GameData.startGame(
      gameId: _scorebookRepository.currentScorebookData.allGames.isNotEmpty
          ? _scorebookRepository.currentScorebookData.allGames.keys.last + 1
          : 1,
      players: state.players,
      gameBoardData: GameBoardData(edgeSize: state.edgeSize),
    );

    final newScorebookData = _scorebookRepository.currentScorebookData.startGame(gameData);

    _scorebookRepository.updateScorebookDataStream(newScorebookData);
  }

  void _updateBlocPlayerList(
    GameEntryPlayerListEvent event,
    Emitter<GameEntryState> emit,
  ) {
    emit(
      state.copyWith(
        players: event.playerList,
      ),
    );
  }

  void _updateBlocEdgeSize(
    GameEntryEdgeSizeEvent event,
    Emitter<GameEntryState> emit,
  ) {
    emit(
      state.copyWith(
        edgeSize: event.edgeSize,
      ),
    );
  }
}
