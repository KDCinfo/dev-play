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
    on<GamePlayUpdatedEvent>(_updateGameData);
    on<GamePlayEndGameEvent>(_endGameData);

    _scorebookStreamListener = _scorebookRepository.scorebookDataStream.listen(
      _updateBlocFromStream,
      onError: (Object err, StackTrace stacktrace) => AppConstants.appPrint(
        message: '[game_play_bloc] Stream error ***** ***** *****',
        error: err,
        stacktrace: stacktrace,
      ),
      onDone: () => AppConstants.appPrint(
        message: '[game_play_bloc] Stream done ***** ***** *****',
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
      if (state.currentGame.gameBoardData.plays.any((play) => play.tileIndex == event.tileIndex) ||
          event.tileIndex < 0 ||
          event.tileIndex >= state.currentGame.gameBoardData.boardSize) {
        return;
      }

      /// Get the current player turn.
      final playerTurnId = state.currentGame.gameBoardData.plays.length;

      /// Get the current player ID.
      final currentPlayerId = state.currentGame.currentPlayerId;

      /// Calculate the duration of the play.
      final lastPlayDate =
          state.currentGame.dateLastPlayed ?? state.currentGame.dateCreated ?? DateTime.now();
      final duration = DateTime.now().difference(lastPlayDate);

      final newGameBoardData = state.currentGame.gameBoardData.addPlay(
        play: PlayerTurn(
          tileIndex: event.tileIndex,
          playerTurnId: playerTurnId,
          occupiedById: currentPlayerId,
          duration: duration,
        ),
      );

      // Update `GameData` => `PlayerTurn`.
      final newGameData = state.currentGame.playTurn(gameBoardData: newGameBoardData);

      // Update `ScorebookData`
      final newScorebookData = _scorebookRepository.currentScorebookData.updateGame(newGameData);

      // Store scorebookData in stream.
      // Store scorebookData in local storage.
      _scorebookRepository.updateGame(newScorebookData);

      //
    } catch (err, stacktrace) {
      //
      addError(err);

      AppConstants.appPrint(
        message: '[game_play_bloc] Error ***** ***** *****',
        error: err,
        stacktrace: stacktrace,
      );
    }
  }
}
