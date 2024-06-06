import 'package:dev_play_tictactuple/src/app_constants.dart';

import 'package:equatable/equatable.dart';

/// This class holds data used during the `runBotPlay` flow.
///
class BotPlayTilePlayData extends Equatable {
  const BotPlayTilePlayData({
    required this.matchTupleEnum,
    this.playerId = -1,
    this.tilesPlayedCount = -1,
    this.groupIndex = 0,
    this.tileIndexToPlay = 0,
  });

  final MatchTupleEnum matchTupleEnum;
  final int playerId;
  final int tilesPlayedCount;
  final int groupIndex;
  final int tileIndexToPlay;

  BotPlayTilePlayData copyWith({
    MatchTupleEnum? matchTupleEnum,
    int? playerId,
    int? tilesPlayedCount,
    int? groupIndex,
    int? tileIndexToPlay,
  }) {
    return BotPlayTilePlayData(
      matchTupleEnum: matchTupleEnum ?? this.matchTupleEnum,
      playerId: playerId ?? this.playerId,
      tilesPlayedCount: tilesPlayedCount ?? this.tilesPlayedCount,
      groupIndex: groupIndex ?? this.groupIndex,
      tileIndexToPlay: tileIndexToPlay ?? this.tileIndexToPlay,
    );
  }

  @override
  List<Object?> get props => [
        matchTupleEnum,
        playerId,
        tilesPlayedCount,
        groupIndex,
        tileIndexToPlay,
      ];
}
