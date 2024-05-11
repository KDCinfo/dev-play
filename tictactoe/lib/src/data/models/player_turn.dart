import 'package:dev_play_tictactoe/src/data/data.dart';

import 'package:equatable/equatable.dart';

class PlayerTurn extends Equatable {
  const PlayerTurn({
    required this.playerTurnId,
    required this.tileIndex,
    required this.playerId,
    required this.occupiedBy,
    this.duration = const Duration(seconds: 1),
  });

  /// Instantiate from JSON.
  factory PlayerTurn.fromJson(Map<String, dynamic> json) {
    final playerTurnId = json['playerTurnId'] as int;
    final tileIndex = json['tileIndex'] as int;
    final playerId = json['playerId'] as int;
    final duration = Duration(seconds: json['duration'] as int);
    final occupiedBy = PlayerData.fromJson(json['occupiedBy'] as Map<String, dynamic>);

    return PlayerTurn(
      playerTurnId: playerTurnId,
      tileIndex: tileIndex,
      playerId: playerId,
      duration: duration,
      occupiedBy: occupiedBy,
    );
  }

  /// Convert to JSON.
  Map<String, dynamic> toJson() {
    return {
      'playerTurnId': playerTurnId,
      'tileIndex': tileIndex,
      'playerId': playerId,
      'duration': duration.inSeconds,
      'occupiedBy': occupiedBy.toJson(),
    };
  }

  final int playerTurnId;
  final int tileIndex;
  final int playerId;
  final Duration duration;
  final PlayerData occupiedBy;

  PlayerTurn copyWith({
    int? playerTurnId,
    int? tileIndex,
    int? playerId,
    Duration? duration,
    PlayerData? occupiedBy,
  }) {
    return PlayerTurn(
      playerTurnId: playerTurnId ?? this.playerTurnId,
      tileIndex: tileIndex ?? this.tileIndex,
      playerId: playerId ?? this.playerId,
      duration: duration ?? this.duration,
      occupiedBy: occupiedBy ?? this.occupiedBy,
    );
  }

  @override
  List<Object?> get props => [
        playerTurnId,
        tileIndex,
        playerId,
        duration,
        occupiedBy,
      ];
}
