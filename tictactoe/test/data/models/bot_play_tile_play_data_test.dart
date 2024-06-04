import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[BotPlayTilePlayData] Testing:', () {
    test('[copyWith] method should return a new instance with updated values.', () {
      const originalData = BotPlayTilePlayData(
        matchTupleEnum: MatchTupleEnum.row,
        playerId: 1,
        tilesPlayedCount: 5,
        groupIndex: 2,
        tileIndexToPlay: 3,
      );

      final updatedData = originalData.copyWith(
        matchTupleEnum: MatchTupleEnum.column,
        playerId: 2,
        tilesPlayedCount: 6,
        groupIndex: 3,
        tileIndexToPlay: 4,
      );

      expect(updatedData.matchTupleEnum, MatchTupleEnum.column);
      expect(updatedData.playerId, 2);
      expect(updatedData.tilesPlayedCount, 6);
      expect(updatedData.groupIndex, 3);
      expect(updatedData.tileIndexToPlay, 4);
    });

    test('[props] should return a list of all properties.', () {
      const data = BotPlayTilePlayData(
        matchTupleEnum: MatchTupleEnum.row,
        playerId: 1,
        tilesPlayedCount: 5,
        groupIndex: 2,
        tileIndexToPlay: 3,
      );

      final props = data.props;

      expect(props.length, 5);
      expect(props[0], MatchTupleEnum.row);
      expect(props[1], 1);
      expect(props[2], 5);
      expect(props[3], 2);
      expect(props[4], 3);
    });
  });
}
