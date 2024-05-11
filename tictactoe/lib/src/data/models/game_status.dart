import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:equatable/equatable.dart';

abstract class GameStatus extends Equatable {
  const GameStatus();

  // The `statusMessage` is shown as-is in the UI.
  String get statusMessage;

  /// Instantiate from JSON.
  static GameStatus fromJson(Map<String, dynamic> json) {
    final statusMessage = json['statusMessage'] as String;

    switch (statusMessage) {
      case 'In Progress':
        return const GameStatusInProgress();
      case 'Complete':
        return const GameStatusComplete();
      default:
        throw Exception('Unknown GameStatus: $statusMessage');
    }
  }

  /// Convert to JSON.
  Map<String, dynamic> toJson() {
    return {
      'statusMessage': statusMessage,
    };
  }
}

class GameStatusInProgress extends GameStatus {
  const GameStatusInProgress() : super();

  @override
  String get statusMessage => GameStatusEnum.inProgress.statusStr;

  @override
  List<Object?> get props => [statusMessage];
}

class GameStatusComplete extends GameStatus {
  const GameStatusComplete() : super();

  @override
  String get statusMessage => GameStatusEnum.complete.statusStr;

  @override
  List<Object?> get props => [statusMessage];
}
