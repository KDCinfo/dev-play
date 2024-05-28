import 'package:equatable/equatable.dart';

class PlayerTurn extends Equatable {
  const PlayerTurn({
    required this.playerTurnId,
    required this.tileIndex,
    required this.occupiedById,
    this.duration = const Duration(seconds: 1),
  });

  /// Instantiate from JSON.
  factory PlayerTurn.fromJson(Map<String, dynamic> json) {
    final playerTurnId = json['playerTurnId'] as int;
    final tileIndex = json['tileIndex'] as int;
    final duration = Duration(seconds: json['duration'] as int);
    final occupiedById = json['occupiedById'] as int;

    return PlayerTurn(
      playerTurnId: playerTurnId,
      tileIndex: tileIndex,
      duration: duration,
      occupiedById: occupiedById,
    );
  }

  /// Convert to JSON.
  Map<String, dynamic> toJson() {
    return {
      'playerTurnId': playerTurnId,
      'tileIndex': tileIndex,
      'duration': duration.inSeconds,
      'occupiedById': occupiedById,
    };
  }

  final int playerTurnId;
  final int tileIndex;
  final Duration duration;
  // final PlayerData occupiedBy;
  final int occupiedById;

  PlayerTurn copyWith({
    int? playerTurnId,
    int? tileIndex,
    Duration? duration,
    int? occupiedById,
  }) {
    return PlayerTurn(
      playerTurnId: playerTurnId ?? this.playerTurnId,
      tileIndex: tileIndex ?? this.tileIndex,
      duration: duration ?? this.duration,
      occupiedById: occupiedById ?? this.occupiedById,
    );
  }

  @override
  List<Object?> get props => [
        playerTurnId,
        tileIndex,
        duration,
        occupiedById,
      ];
}
