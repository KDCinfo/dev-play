import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[BotPlayTilePlayData] Testing:', () {
    test('should construct a new instance with defaults.', () {
      const originalData = BotPlayTilePlayData(matchTupleEnum: MatchTupleEnum.row);

      expect(originalData.matchTupleEnum, MatchTupleEnum.row);
      expect(originalData.tilesPlayedCount, 0);
      expect(originalData.groupIndex, 0);
      expect(originalData.tileIndexToPlay, 0);
    });

    test('[copyWith] method should return a new instance with updated values.', () {
      const originalData = BotPlayTilePlayData(
        matchTupleEnum: MatchTupleEnum.row,
        tilesPlayedCount: 5,
        groupIndex: 2,
        tileIndexToPlay: 3,
      );

      final updatedData = originalData.copyWith(
        matchTupleEnum: MatchTupleEnum.column,
        tilesPlayedCount: 6,
        groupIndex: 3,
        tileIndexToPlay: 4,
      );

      expect(updatedData.matchTupleEnum, MatchTupleEnum.column);
      expect(updatedData.tilesPlayedCount, 6);
      expect(updatedData.groupIndex, 3);
      expect(updatedData.tileIndexToPlay, 4);
    });

    test('[props] should return a list of all properties.', () {
      const data = BotPlayTilePlayData(
        matchTupleEnum: MatchTupleEnum.row,
        tilesPlayedCount: 5,
        groupIndex: 2,
        tileIndexToPlay: 3,
      );

      final props = data.props;

      expect(props.length, 4);
      expect(props[0], MatchTupleEnum.row);
      expect(props[1], 5);
      expect(props[2], 2);
      expect(props[3], 3);
    });
  });
}
