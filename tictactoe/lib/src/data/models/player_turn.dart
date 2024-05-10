import 'package:dev_play_tictactoe/src/data/data.dart';

import 'package:equatable/equatable.dart';

class PlayerTurn extends Equatable {
  const PlayerTurn({
    required this.playerTurnId,
    required this.playerId,
    required this.duration,
    required this.occupiedBy,
  });

  final int playerTurnId;
  final int playerId;
  final Duration duration;
  final PlayerData occupiedBy;

  PlayerTurn copyWith({
    int? playerTurnId,
    int? playerId,
    Duration? duration,
    PlayerData? occupiedBy,
  }) {
    return PlayerTurn(
      playerTurnId: playerTurnId ?? this.playerTurnId,
      playerId: playerId ?? this.playerId,
      duration: duration ?? this.duration,
      occupiedBy: occupiedBy ?? this.occupiedBy,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'playerTurnId': playerTurnId,
      'playerId': playerId,
      'duration': duration.inSeconds,
      'occupiedBy': occupiedBy.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        playerTurnId,
        playerId,
        duration,
        occupiedBy,
      ];
}
