import 'package:equatable/equatable.dart';

/// This class helps keep track of previously analyzed tiles.
///
class PreviousIdTracker extends Equatable {
  const PreviousIdTracker({
    this.playerId = -1,
    this.currentLongestCount = 0,
    this.loopIndex = -1,
  });

  // -2 = empty, -1 = not set, 0 = player 1, 1 = player 2
  final int playerId;
  final int currentLongestCount;
  final int loopIndex;

  PreviousIdTracker copyWith({
    int? playerId,
    int? currentLongestCount,
    int? loopIndex,
  }) {
    return PreviousIdTracker(
      playerId: playerId ?? this.playerId,
      currentLongestCount: currentLongestCount ?? this.currentLongestCount,
      loopIndex: loopIndex ?? this.loopIndex,
    );
  }

  @override
  List<Object?> get props => [
        playerId,
        currentLongestCount,
        loopIndex,
      ];
}
