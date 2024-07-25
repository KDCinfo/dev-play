import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';
import 'package:dev_play_tictactuple/src/data/service_repositories/service_repositories.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_entry_event.dart';
part 'game_entry_state.dart';

/// The `GameEntryBloc` is responsible for
/// managing the state of the `GameEntry` screen.
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
    on<GameEntryUpdateEvent>(_gameEntryUpdateEvent);
    on<GameEntrySymbolSelectedEvent>(_symbolSelected);
    on<GameEntryChangeNameEvent>(_updateBlocPlayerList);
    on<GameEntryEdgeSizeEvent>(_updateBlocEdgeSize);
    on<GameEntryStartGameEvent>(_updateBlocStartGame);
    on<GameEntryResetGameEvent>(_updateBlocResetGame);
    on<GameEntryResumeGameEvent>(_resumeGameData);

    // This will update the `allSavedPlayerNames` list in the UI.
    _scorebookStreamListener = _scorebookRepository.scorebookDataStream.listen(
      _updateBlocFromStream,
      onError: (Object err, StackTrace stacktrace) => AppConstants.appPrint(
        message: '[game_entry_bloc] Stream error ***** ***** *****',
        error: err,
        stacktrace: stacktrace,
      ),
      onDone: () => AppConstants.appPrint(
        message: '[game_entry_bloc] Stream done ***** ***** *****',
      ),
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

  void _gameEntryUpdateEvent(
    GameEntryUpdateEvent event,
    Emitter<GameEntryState> emit,
  ) {
    emit(
      state.copyWith(
        edgeSize: event.edgeSize,
        players: event.players,
        allSavedPlayerNames: event.allSavedPlayerNames,
      ),
    );
  }

  void _updateBlocResetGame(
    GameEntryResetGameEvent event,
    Emitter<GameEntryState> emit,
  ) {
    emit(
      state.copyWith(
        edgeSize: AppConstants.defaultEdgeSize,
        players: AppConstants.playerListDefault,
        allSavedPlayerNames: <String>[...state.allSavedPlayerNames],
      ),
    );
  }

  void _resumeGameData(
    GameEntryResumeGameEvent event,
    Emitter<GameEntryState> emit,
  ) {
    _scorebookRepository.resumeGame();
  }

  void _updateBlocStartGame(
    GameEntryStartGameEvent event,
    Emitter<GameEntryState> emit,
  ) {
    try {
      // First let's remove the last player if the name is empty.
      final workingList = List<PlayerData>.of(state.players)
        ..removeWhere(
          (player) => player.playerNum == state.players.length && player.playerName.isEmpty,
        );

      // This call distills the highest playerId from the list of players.
      // New players will be assigned a playerId starting at +1 from this highest playerId.
      final lastPlayerId = _scorebookRepository.currentScorebookData.allPlayers.isNotEmpty
          ? _scorebookRepository.currentScorebookData.allPlayers
                  .map((player) => player.playerId)
                  .reduce((a, b) => a != null && b != null && b > a ? b : a) ??
              0
          : 0;

      // This will be incremented if needed.
      var nextPlayerId = lastPlayerId;

      // Isolate new players for storing in the `allPlayers` list,
      // and pull out existing players for reuse.
      final playersMap = {
        'existing': <PlayerData>[],
        'new': <PlayerData>[],
      };
      for (final player in workingList) {
        final existingPlayerIndex = _scorebookRepository.currentScorebookData.allPlayers.indexWhere(
          (existingPlayer) =>
              existingPlayer.playerName.trim().toLowerCase() ==
              player.playerName.trim().toLowerCase(),
        );

        if (existingPlayerIndex > -1) {
          final existingPlayer =
              _scorebookRepository.currentScorebookData.allPlayers.elementAtOrNull(
            existingPlayerIndex,
          );
          if (existingPlayer != null) {
            playersMap['existing'] = [
              ...?playersMap['existing'],
              player.copyWith(playerId: existingPlayer.playerId),
            ];
          }
        } else {
          nextPlayerId++;
          playersMap['new'] = [
            ...?playersMap['new'],
            player.copyWith(playerId: nextPlayerId),
          ];
        }
      }

      // Combine and resort new list based on `playerNum`.
      final playersWithIds = [
        ...?playersMap['existing'],
        ...?playersMap['new'],
      ].toList()
        ..sort((a, b) => a.playerNum.compareTo(b.playerNum));

      // We'll prep the game by creating a new `GameData` object
      // using the `startGame` method which will prepopulate the
      // gameData with things like the game creation date.
      final gameData = GameData.startGame(
        gameId: _scorebookRepository.currentScorebookData.allGames.isNotEmpty
            ? (_scorebookRepository.currentScorebookData.allGames.keys.lastOrNull ?? 0) + 1
            : 1,
        // players: state.players,
        // Give each player a playerId that is +1 from the
        // highest playerId in the `allPlayers` list.
        players: playersWithIds,
        gameBoardData: GameBoardData(edgeSize: state.edgeSize),
      );

      // We'll then populate the `currentGame` property in `ScorebookData` using
      // the new gameData. When this change hits the stream, it will be what
      // triggers the UI to navigate to the `GamePlay` screen. We'll also be
      // providing the new players for storing in the `allPlayers` list in `ScorebookData`.
      final newScorebookData = _scorebookRepository.currentScorebookData.startGame(
        gameData: gameData,
        newAllPlayers: playersMap['new']!,
      );

      // The new scorebook data will be stored in local storage,
      // then the stream will be updated with the new data,
      // triggering the actual start of the new game.
      _scorebookRepository.processScorebookData(newScorebookData);

      //
    } catch (err, stacktrace) {
      //
      addError(err);

      AppConstants.appPrint(
        message: '[game_entry_bloc] _updateBlocStartGame error ***** ***** *****',
        error: err,
        stacktrace: stacktrace,
      );
    }
  }

  void _symbolSelected(
    GameEntrySymbolSelectedEvent event,
    Emitter<GameEntryState> emit,
  ) {
    final playerNum = event.playerNum;

    if (state.players.isNotEmpty && state.players.any((player) => player.playerNum == playerNum)) {
      final playerToUpdate = state.players.firstWhereOrNull(
        (PlayerData player) => player.playerNum == playerNum,
      );

      if (playerToUpdate != null) {
        final selectedSymbolKey = event.selectedSymbolKey;
        final updatedPlayer = playerToUpdate.copyWith(
          userSymbol: UserSymbol.markerListTypes[selectedSymbolKey],
        );

        final newPlayerList = List.of(state.players)
          ..replaceRange(playerNum - 1, playerNum, [updatedPlayer]);

        emit(
          state.copyWith(players: newPlayerList),
        );
      }
    }
  }

  /// Updating the player list happens
  /// while on the `GameEntry` screen when either:
  ///
  /// - The user changes the player name.
  /// - The user selects a previously saved name from the list
  ///   (which then populates the player name field).
  /// - The user selects a different marker from the marker menu.
  ///
  /// When the 2nd player name is changed, the player type is changed
  /// from a bot to a human player, and a new empty player slot is added.
  ///
  /// When the 3rd player name is changed, a 4th player slot is added.
  ///
  void _updateBlocPlayerList(
    GameEntryChangeNameEvent event,
    Emitter<GameEntryState> emit,
  ) {
    // The default player list has 2 players, a human and a bot.
    //
    // This first condition ensures
    // - the list indeed has at least 2 players.
    //
    final players = state.players;

    if (players.length >= 2 && players.length <= AppConstants.playerListMax) {
      //
      final playerNum = event.playerNum;

      late final List<PlayerData> newPlayerList;

      // This second condition checks if
      // - the 2nd player is a bot.
      //
      final currentPlayer = players.elementAtOrNull(playerNum - 1);

      if (playerNum == 2 && currentPlayer != null && currentPlayer.playerType is PlayerTypeBot) {
        //
        // This condition can only ever be met when the player list
        //   is in its default state, where the 2nd player is a bot,
        //   and so there will only ever be 2 rows at this stage.
        // When the 3rd player is added, it will be in the list
        //   until the fields are reset (by selecting the bot name
        //   in the 2nd row's saved player list).
        //
        newPlayerList = List.of(players)
          // Update the 2nd player's name and type'.
          ..replaceRange(
            playerNum - 1,
            playerNum,
            [
              currentPlayer.copyWith(
                playerName: event.playerName,
                playerType: const PlayerTypeHuman(),
              ),
            ],
          )
          // Add a new empty PlayerData.
          ..add(
            PlayerData(
              playerNum: 3,
              // Grab the first available symbol.
              userSymbol:
                  state.unusedSymbolTypesList.entries.firstOrNull?.value ?? const UserSymbolEmpty(),
              playerType: const PlayerTypeHuman(),
            ),
          );
      } else if (playerNum == 2 &&
          currentPlayer != null &&
          currentPlayer.playerType is! PlayerTypeBot &&
          event.playerName == AppConstants.playerBotName) {
        //
        // When selecting the default bot name ('TicTacBot') from the
        // saved player list (available from the 2nd row), or when
        // entering the name directly in the 2nd row's name field,
        // the 3rd and 4th player fields will be removed from the
        // list, and the 2nd player will be set back to a bot.
        //
        // This condition is met when the 2nd player is being
        // reset back to a bot by matching the default bot name.
        //
        final playerListCopy = List.of(players).take(1).toList();
        newPlayerList = playerListCopy..add(AppConstants.playerBot);

        //
      } else if (currentPlayer != null &&
          playerNum > 2 &&
          playerNum < AppConstants.playerListMax &&
          playerNum == players.length) {
        //
        // Given: players.length >= 2
        // Given: playerListMax == 4
        // - playerNum == players.length
        // - playerNum < 4
        // - playerNum == 3
        //
        // Given: players.length >= 2
        // Given: playerListMax == 5
        // - playerNum == players.length
        // - playerNum < 5
        // - playerNum == 4
        //
        // This condition will only ever be met when the 2nd to last
        // player name is changed, and the last player slot has not
        // yet been added. If the max were ever increased to 5, this
        // condition would also be met when the 4th player name is changed.
        //
        final newPlayerListTemp = List.of(players)
          // Update the 2nd player's name and type'.
          ..replaceRange(
            playerNum - 1,
            playerNum,
            [
              currentPlayer.copyWith(
                playerName: event.playerName,
              ),
            ],
          );
        // Add a new empty PlayerData.
        if (state.unusedSymbolTypesList.entries.isNotEmpty) {
          newPlayerList = List.of(newPlayerListTemp)
            ..add(
              PlayerData(
                playerNum: 4,
                playerName: players.lastOrNull?.playerName ?? '',
                // Grab the first available symbol.
                userSymbol: state.unusedSymbolTypesList.entries.firstOrNull?.value ??
                    const UserSymbolEmpty(),
                playerType: const PlayerTypeHuman(),
              ),
            );
        }
      } else {
        // Otherwise, let's just update the list with the player's name.
        if (currentPlayer != null) {
          newPlayerList = List.of(players)
            // Update this [nth] player's name.
            ..replaceRange(
              playerNum - 1,
              playerNum,
              [
                currentPlayer.copyWith(
                  playerName: event.playerName,
                ),
              ],
            );
        }
      }

      emit(
        state.copyWith(
          players: newPlayerList,
        ),
      );
    }
  }

  void _updateBlocEdgeSize(
    GameEntryEdgeSizeEvent event,
    Emitter<GameEntryState> emit,
  ) {
    if (event.edgeSize < AppConstants.defaultEdgeSizeMin ||
        event.edgeSize > AppConstants.defaultEdgeSizeMax) {
      return;
    }
    emit(
      state.copyWith(
        edgeSize: event.edgeSize,
      ),
    );
  }
}
