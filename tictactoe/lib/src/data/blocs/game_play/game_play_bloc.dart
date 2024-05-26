import 'dart:async';

import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/data/models/models.dart';
import 'package:dev_play_tictactoe/src/data/service_repositories/service_repositories.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_play_event.dart';
part 'game_play_state.dart';

class GamePlayBloc extends Bloc<GamePlayEvent, GamePlayState> {
  GamePlayBloc({
    required ScorebookRepository scorebookRepository,
  })  : _scorebookRepository = scorebookRepository,
        super(const GamePlayState()) {
    on<GamePlayUpdatedEvent>(_updateGameData);

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

  void _updateGameData(
    GamePlayUpdatedEvent event,
    Emitter<GamePlayState> emit,
  ) {
    emit(state.copyWith(currentGame: event.gameData));
  }
}
