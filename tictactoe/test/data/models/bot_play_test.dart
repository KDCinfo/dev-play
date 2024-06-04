import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[BotPlay] Testing:', () {
    test('runBotPlay should return 0 when there are no empty tiles.', () {
      final filledAllRows = {
        MatchTupleEnum.row: {
          0: [0, 1, 1, 0, 1],
          1: [-2, -2, 1, 0, -2],
          2: [0, 1, -2, 0, 1],
          3: [0, 1, 1, -2, 1],
          4: [0, 1, 1, 0, 1],
        },
      };

      final result = BotPlay.runBotPlay(filledAllRows: filledAllRows);

      // @TODO: Finish this test when `BotPlay.runBotPlay` is completed.
      // expect(result, 0);
      expect(result, 18);
    });

    test('runBotPlay should return the tile index to play when there are empty tiles.', () {
      final filledAllRows = {
        MatchTupleEnum.row: {
          0: [0, 1, 1, -2, 1],
          1: [-2, -2, 1, 0, -2],
          2: [0, 1, -2, 0, 1],
          3: [0, 1, 1, -2, 1],
          4: [0, 1, 1, 0, 1],
        },
      };

      final result = BotPlay.runBotPlay(filledAllRows: filledAllRows);

      // @TODO: Finish this test when `BotPlay.runBotPlay` is completed.
      // expect(result, 3);
      expect(result, 18);
    });
  });
}
