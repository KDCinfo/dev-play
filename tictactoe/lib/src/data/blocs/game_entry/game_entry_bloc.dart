import 'dart:async';

import 'package:dev_play_tictactoe/src/app_constants.dart';
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

        /// The `GameEntryBloc` state needs 2 initial players; 1 human, 1 bot.
        ///
        /// - When text is added to the 2nd (bot) name, it becomes human,
        ///     and a 3rd empty human player is added to the playerList.
        /// - When text is added to the 3rd name, a 4th player will be added.
        ///
        /// - Only populated name fields will be used
        ///     (although the game can't be started without the first player entered).
        /// - The 2nd slot can be reset to a bot
        ///     by selecting 'TicTacBot' from the saved player list
        ///     (which is only available to the 2nd row).
        ///     Doing so will clear and remove the 3rd and 4th player fields.
        /// -   The 3rd or 4th players won't be used if left empty.
        /// - If fields 2-4 are left empty,
        ///     player 2 will become a bot when the game is started.
        ///
        /// When text is added to the 3rd name, a 4th player name is added
        ///   (the input field will persist even if field is cleared).
        /// The 4th player won't be used if left empty,
        ///   and will become the 3rd player if the 3rd field is left empty.
        super(
          const GameEntryState(players: AppConstants.playerListDefault),
        ) {
    //
    on<GameEntryNameSelectedEvent>(_nameSelected);
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

  void _nameSelected(
    GameEntryNameSelectedEvent event,
    Emitter<GameEntryState> emit,
  ) {
    /// By selecting 'TicTacBot' from the saved player list (available from the 2nd row),
    /// the 3rd and 4th player fields will be removed from the list,
    /// and the 2nd player will be set back to a bot.
    /// Otherwise, the list will be updated with the selected player name.

    late final List<PlayerData> newPlayerList;

    final playerNum = event.playerNum;
    final selectedPlayerName = event.selectedPlayerName;

    if (playerNum == 2 && selectedPlayerName == AppConstants.playerBotName) {
      newPlayerList = List.of(state.players)
        ..take(1)
        ..toList()
        ..add(AppConstants.playerBot);
    } else {
      final playerToUpdate = state.players.firstWhere(
        (player) => player.playerNum == playerNum,
      );
      final updatedPlayer = playerToUpdate.copyWith(
        playerName: selectedPlayerName,
        playerType: const PlayerTypeHuman(),
      );
      newPlayerList = List.of(state.players)
        ..replaceRange(playerNum - 1, playerNum, [updatedPlayer]);
    }

    emit(
      state.copyWith(players: newPlayerList),
    );
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
