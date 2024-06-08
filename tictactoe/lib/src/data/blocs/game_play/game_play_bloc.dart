import 'dart:async';

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
    on<GamePlayEndGameEvent>(_endGameData);
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
      GamePlayUpdatedEvent(gameData: scorebookData.currentGame),
    );
  }

  void _endGameData(
    GamePlayEndGameEvent event,
    Emitter<GamePlayState> emit,
  ) {
    emit(state.copyWith(currentGame: event.gameData));
  }

  void _updateGameData(
    GamePlayUpdatedEvent event,
    Emitter<GamePlayState> emit,
  ) {
    emit(state.copyWith(currentGame: event.gameData));
  }

  void _resetGameData(
    GamePlayResetGameEvent event,
    Emitter<GamePlayState> emit,
  ) {
    // Update `ScorebookData`.
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
      final nonBotPlayerId =
          state.currentGame.players.firstWhere((player) => player.playerId != botId).playerId ??
              botId;
      final tileIndex = BotPlay.runBotPlay(
        filledAllRows: filledAllRows,
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
