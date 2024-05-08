import 'package:dev_play_tictactoe/src/data/models/models.dart';

import 'package:equatable/equatable.dart';

abstract class GameStatus extends Equatable {
  const GameStatus();

  // The `statusMessage` is shown as-is in the UI.
  String get statusMessage;
}

class GameStatusInProgress extends GameStatus {
  const GameStatusInProgress() : super();

  @override
  String get statusMessage => GameStatusConstants.inProgress;

  @override
  List<Object?> get props => [statusMessage];
}

class GameStatusComplete extends GameStatus {
  const GameStatusComplete() : super();

  @override
  String get statusMessage => GameStatusConstants.complete;

  @override
  List<Object?> get props => [statusMessage];
}
