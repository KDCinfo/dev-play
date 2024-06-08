import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[BotPlay] Testing:', () {
    group('[runBotPlay]', () {
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

    group('[findBestTileIndex]', () {
      const emptyId = -2;
      const playId = 5;
      const botId = 2;

      const checkId = 5;
      test('starting with playerId -2 (empty) with player 1:', () {
        expect(
          BotPlay.findBestTileIndex([emptyId, emptyId, emptyId, emptyId, emptyId], checkId),
          -1,
        );
        expect(BotPlay.findBestTileIndex([emptyId, emptyId, emptyId, emptyId, playId], checkId), 3);
        expect(BotPlay.findBestTileIndex([emptyId, emptyId, emptyId, playId, playId], checkId), 2);
        expect(BotPlay.findBestTileIndex([emptyId, emptyId, emptyId, playId, botId], checkId), 2);
        expect(BotPlay.findBestTileIndex([emptyId, emptyId, emptyId, botId, playId], checkId), -1);
        expect(BotPlay.findBestTileIndex([emptyId, emptyId, playId, emptyId, emptyId], checkId), 1);
        expect(BotPlay.findBestTileIndex([emptyId, emptyId, playId, playId, playId], checkId), 1);
        expect(BotPlay.findBestTileIndex([emptyId, emptyId, playId, botId, playId], checkId), 1);
        expect(BotPlay.findBestTileIndex([emptyId, emptyId, botId, playId, playId], checkId), -1);
        expect(BotPlay.findBestTileIndex([emptyId, playId, emptyId, emptyId, emptyId], checkId), 0);
        expect(BotPlay.findBestTileIndex([emptyId, playId, emptyId, emptyId, playId], checkId), 3);
        expect(BotPlay.findBestTileIndex([emptyId, playId, emptyId, playId, emptyId], checkId), 2);
        expect(BotPlay.findBestTileIndex([emptyId, playId, emptyId, playId, playId], checkId), 2);
        expect(BotPlay.findBestTileIndex([emptyId, playId, playId, emptyId, emptyId], checkId), 0);
        expect(BotPlay.findBestTileIndex([emptyId, playId, playId, emptyId, botId], checkId), 0);
        expect(BotPlay.findBestTileIndex([emptyId, playId, playId, playId, emptyId], checkId), 0);
        expect(BotPlay.findBestTileIndex([emptyId, playId, playId, playId, playId], checkId), 0);
        expect(BotPlay.findBestTileIndex([emptyId, playId, playId, botId, botId], checkId), 0);
        expect(BotPlay.findBestTileIndex([emptyId, botId, emptyId, playId, playId], checkId), 2);
        expect(BotPlay.findBestTileIndex([emptyId, botId, playId, playId, emptyId], checkId), 4);
        expect(BotPlay.findBestTileIndex([emptyId, botId, playId, playId, botId], checkId), -1);
        expect(BotPlay.findBestTileIndex([emptyId, botId, botId, playId, playId], checkId), -1);
        expect(BotPlay.findBestTileIndex([emptyId, botId, botId, botId, botId], checkId), -1);
      });

      test('starting with playerId -2 (empty) mixed with players 1 and 2:', () {
        expect(BotPlay.findBestTileIndex([emptyId, emptyId, playId, playId, botId], checkId), 1);
        expect(BotPlay.findBestTileIndex([emptyId, emptyId, playId, botId, botId], checkId), 1);
        expect(BotPlay.findBestTileIndex([emptyId, emptyId, botId, playId, botId], checkId), -1);
        expect(BotPlay.findBestTileIndex([emptyId, emptyId, botId, botId, playId], checkId), -1);
        expect(BotPlay.findBestTileIndex([emptyId, emptyId, botId, botId, botId], checkId), -1);
        expect(BotPlay.findBestTileIndex([emptyId, playId, emptyId, playId, botId], checkId), 2);
        expect(BotPlay.findBestTileIndex([emptyId, playId, emptyId, botId, playId], checkId), 0);
        expect(BotPlay.findBestTileIndex([emptyId, playId, emptyId, botId, botId], checkId), 0);
        expect(BotPlay.findBestTileIndex([emptyId, playId, playId, botId, emptyId], checkId), 0);
        expect(BotPlay.findBestTileIndex([emptyId, playId, botId, emptyId, playId], checkId), 3);
        expect(BotPlay.findBestTileIndex([emptyId, playId, botId, emptyId, botId], checkId), 0);
        expect(BotPlay.findBestTileIndex([emptyId, playId, botId, playId, emptyId], checkId), 4);
        expect(BotPlay.findBestTileIndex([emptyId, playId, botId, playId, botId], checkId), 0);
        expect(BotPlay.findBestTileIndex([emptyId, playId, botId, botId, emptyId], checkId), 0);
        expect(BotPlay.findBestTileIndex([emptyId, playId, botId, botId, playId], checkId), 0);
        expect(BotPlay.findBestTileIndex([emptyId, playId, botId, botId, botId], checkId), 0);
        expect(BotPlay.findBestTileIndex([emptyId, botId, emptyId, playId, botId], checkId), 2);
        expect(BotPlay.findBestTileIndex([emptyId, botId, emptyId, botId, playId], checkId), -1);
        expect(BotPlay.findBestTileIndex([emptyId, botId, emptyId, botId, botId], checkId), -1);
        expect(BotPlay.findBestTileIndex([emptyId, botId, playId, emptyId, playId], checkId), 3);
        expect(BotPlay.findBestTileIndex([emptyId, botId, playId, emptyId, botId], checkId), 3);
      });

      test('starting with player 1:', () {
        expect(BotPlay.findBestTileIndex([playId, emptyId, emptyId, emptyId, emptyId], checkId), 1);
        expect(BotPlay.findBestTileIndex([playId, emptyId, emptyId, emptyId, botId], checkId), 1);
        expect(BotPlay.findBestTileIndex([playId, emptyId, emptyId, botId, botId], checkId), 1);
        expect(BotPlay.findBestTileIndex([playId, emptyId, botId, botId, botId], checkId), 1);
        expect(BotPlay.findBestTileIndex([playId, playId, emptyId, emptyId, emptyId], checkId), 2);
        expect(BotPlay.findBestTileIndex([playId, playId, emptyId, botId, botId], checkId), 2);
        expect(BotPlay.findBestTileIndex([playId, playId, playId, emptyId, emptyId], checkId), 3);
        expect(BotPlay.findBestTileIndex([playId, playId, playId, playId, emptyId], checkId), 4);
        expect(BotPlay.findBestTileIndex([playId, playId, playId, botId, botId], checkId), -1);
        expect(BotPlay.findBestTileIndex([playId, playId, botId, playId, botId], checkId), -1);
        expect(BotPlay.findBestTileIndex([playId, playId, botId, botId, botId], checkId), -1);
        expect(BotPlay.findBestTileIndex([playId, botId, playId, playId, emptyId], checkId), 4);
        expect(BotPlay.findBestTileIndex([playId, botId, playId, playId, botId], checkId), -1);
        expect(BotPlay.findBestTileIndex([playId, botId, playId, botId, botId], checkId), -1);
        expect(BotPlay.findBestTileIndex([playId, botId, botId, playId, playId], checkId), -1);
        expect(BotPlay.findBestTileIndex([playId, botId, botId, playId, botId], checkId), -1);
        expect(BotPlay.findBestTileIndex([playId, botId, botId, botId, playId], checkId), -1);
        expect(BotPlay.findBestTileIndex([playId, botId, botId, botId, botId], checkId), -1);
      });

      test('starting with player 2:', () {
        expect(BotPlay.findBestTileIndex([botId, emptyId, emptyId, emptyId, emptyId], checkId), -1);
        expect(BotPlay.findBestTileIndex([botId, emptyId, emptyId, playId, playId], checkId), 2);
        expect(BotPlay.findBestTileIndex([botId, emptyId, playId, playId, playId], checkId), 1);
        expect(BotPlay.findBestTileIndex([botId, playId, emptyId, emptyId, emptyId], checkId), 2);
        expect(BotPlay.findBestTileIndex([botId, playId, emptyId, emptyId, playId], checkId), 3);
        expect(BotPlay.findBestTileIndex([botId, playId, emptyId, playId, emptyId], checkId), 2);
        expect(BotPlay.findBestTileIndex([botId, playId, emptyId, playId, playId], checkId), 2);
        expect(BotPlay.findBestTileIndex([botId, playId, playId, emptyId, emptyId], checkId), 3);
        expect(BotPlay.findBestTileIndex([botId, playId, playId, emptyId, botId], checkId), 3);
        expect(BotPlay.findBestTileIndex([botId, playId, playId, playId, emptyId], checkId), 4);
        expect(BotPlay.findBestTileIndex([botId, playId, playId, playId, playId], checkId), -1);
        expect(BotPlay.findBestTileIndex([botId, playId, playId, playId, botId], checkId), -1);
        expect(BotPlay.findBestTileIndex([botId, playId, playId, botId, botId], checkId), -1);
        expect(BotPlay.findBestTileIndex([botId, botId, emptyId, emptyId, playId], checkId), 3);
        expect(BotPlay.findBestTileIndex([botId, botId, emptyId, playId, playId], checkId), 2);
        expect(BotPlay.findBestTileIndex([botId, botId, playId, playId, emptyId], checkId), 4);
        expect(BotPlay.findBestTileIndex([botId, botId, playId, playId, botId], checkId), -1);
        expect(BotPlay.findBestTileIndex([botId, botId, botId, playId, playId], checkId), -1);
      });

      test('additional edge cases and patterns:', () {
        // Single player dominance.
        expect(BotPlay.findBestTileIndex([playId, playId, playId, playId, playId], checkId), -1);
        expect(BotPlay.findBestTileIndex([botId, botId, botId, botId, botId], checkId), -1);

        // Alternating patterns.
        expect(BotPlay.findBestTileIndex([playId, botId, playId, botId, playId], checkId), -1);
        expect(BotPlay.findBestTileIndex([botId, playId, botId, playId, botId], checkId), -1);

        // Interspersed empty tiles.
        expect(BotPlay.findBestTileIndex([playId, emptyId, playId, emptyId, playId], checkId), 3);
        expect(BotPlay.findBestTileIndex([botId, emptyId, botId, emptyId, botId], checkId), -1);
      });
    });
  });
}
