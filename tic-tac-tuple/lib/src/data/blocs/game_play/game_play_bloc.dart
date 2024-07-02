import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';
import 'package:dev_play_tictactuple/src/data/service_repositories/service_repositories.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_play_event.dart';
part 'game_play_state.dart';

class GamePlayBloc extends Bloc<GamePlayEvent, GamePlayState> {
  GamePlayBloc({
    required ScorebookRepository scorebookRepository,
  })  : _scorebookRepository = scorebookRepository,
        super(const GamePlayState()) {
    on<GamePlayMoveEvent>(_makeMove);
    on<GamePlayBotMoveRequestedEvent>(_botMove);
    on<GamePlayUpdatedEvent>(_updateGameData);
    on<GamePlayReturnHomeEvent>(_returningHomeGameData);
    on<GamePlayResetGameEvent>(_resetGameData);

    _scorebookStreamListener = _scorebookRepository.scorebookDataStream.listen(
      _updateBlocFromStream,
      onError: (Object err, StackTrace stacktrace) => AppConstants.appPrint(
        message: '[game_play_bloc] [streamListener] Stream error ***** ***** *****',
        error: err,
        stacktrace: stacktrace,
      ),
      onDone: () => AppConstants.appPrint(
        message: '[game_play_bloc] [streamListener] Stream done ***** ***** *****',
      ),
    );
  }

  final ScorebookRepository _scorebookRepository;

  late final StreamSubscription<ScorebookData> _scorebookStreamListener;

  ScorebookData get currentScorebookData => _scorebookRepository.currentScorebookData;

  @override
  Future<void> close() {
    _scorebookStreamListener.cancel();
    return super.close();
  }

  /// The updated scorebook data from the repository has already
  /// been stored in local storage prior to being sent to the stream.
  ///
  void _updateBlocFromStream(ScorebookData scorebookData) {
    add(
      GamePlayUpdatedEvent(
        gameDataCurrent: scorebookData.currentGame,
        gameDataPaused: scorebookData.pausedGame,
      ),
    );
  }

  void _returningHomeGameData(
    GamePlayReturnHomeEvent event,
    Emitter<GamePlayState> emit,
  ) {
    final gameDataReset = event.gameDataReset;
    final gameDataPaused = event.gameDataPaused;

    final newScorebookData = _scorebookRepository.currentScorebookData.pauseGame(
      newCurrentGame: gameDataReset,
      pausedGame: gameDataPaused,
    );

    // Store scorebookData in stream and local storage.
    _scorebookRepository.processScorebookData(newScorebookData);
  }

  void _updateGameData(
    GamePlayUpdatedEvent event,
    Emitter<GamePlayState> emit,
  ) {
    emit(
      state.copyWith(
        currentGame: event.gameDataCurrent,
        pausedGame: event.gameDataPaused,
      ),
    );
  }

  /// Resetting `ScorebookData` will add an empty `GameData()` to `currentGame`,
  /// but will retain the current players to help facilitate starting a new game.
  void _resetGameData(
    GamePlayResetGameEvent event,
    Emitter<GamePlayState> emit,
  ) {
    final newScorebookData = _scorebookRepository.currentScorebookData.resetGame(
      state.currentGame,
    );

    // Store scorebookData in stream and local storage.
    _scorebookRepository.processScorebookData(newScorebookData);
  }

  /// Update `GameBoarddata`, `GameData`, and `ScorebookData`.
  ///
  void _makeMove(
    GamePlayMoveEvent event,
    Emitter<GamePlayState> emit,
  ) {
    // ignore: avoid_print
    print(event.tileIndex);

    try {
      /// Don't make any moves if tileIndex is already played or outside the range.
      _scorebookRepository.playTurn(
        currentGame: state.currentGame,
        tileIndex: event.tileIndex,
      );
      //
    } catch (err, stacktrace) {
      //
      addError(err);

      AppConstants.appPrint(
        message: '[game_play_bloc] [_makeMove] Error ***** ***** *****',
        error: err,
        stacktrace: stacktrace,
      );
    }
  }

  /// The bot's play.
  ///
  void _botMove(
    GamePlayBotMoveRequestedEvent event,
    Emitter<GamePlayState> emit,
  ) {
    try {
      final filledAllRows =
          _scorebookRepository.currentScorebookData.currentGame.gameBoardData.filledAllRows;
      final botId = state.currentGame.currentPlayerId;
      // There are always only 2 players when a bot is in play.
      // We'll be passing along the non-bot player to the tile checker.
      final nonBotPlayerId = state.currentGame.players
              .firstWhereOrNull((player) => player.playerId != botId)
              ?.playerId ??
          botId;
      final tileIndex = BotPlay.runBotPlay(
        filledAllTuples: filledAllRows,
        nonBotPlayerId: nonBotPlayerId,
      );

      _scorebookRepository.playTurn(
        currentGame: state.currentGame,
        tileIndex: tileIndex,
      );
      //
    } catch (err, stacktrace) {
      //
      addError(err);

      AppConstants.appPrint(
        message: '[game_play_bloc] [_botMove] Error ***** ***** *****',
        error: err,
        stacktrace: stacktrace,
      );
    }
  }
}
