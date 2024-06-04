import 'package:equatable/equatable.dart';

/// This class helps keep track of previously analyzed tiles.
///
class PreviousIdTracker extends Equatable {
  const PreviousIdTracker({
    required this.playerId,
    required this.currentLongestCount,
    required this.loopIndex,
  });

  ///
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
