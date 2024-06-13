import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[BotPlay] Testing:', () {
    group('[runBotPlay]', () {
      test('runBotPlay should return 0 when there are no empty tiles.', () {
        //
        // [5] = player 1
        // [3] = bot
        //
        final filledAllRows = {
          MatchTupleEnum.row: {
            0: [3, 5, 5, 3, 5],
            1: [-2, 3, 5, 3, -2],
            2: [3, 5, 3, 3, 5],
            3: [3, 5, 5, 5, 5],
            4: [3, 5, 5, 3, 5],
          },
        };

        final result = BotPlay.runBotPlay(
          filledAllTuples: filledAllRows,
          nonBotPlayerId: 5,
        );

        // @TODO: Finish this test when `BotPlay.runBotPlay` is completed.
        expect(result, 0);
      });

      test('runBotPlay should return the tile index to play when there are empty tiles.', () {
        final filledAllRows = {
          MatchTupleEnum.row: {
            0: [3, 5, 5, -2, 5],
            1: [-2, -2, 5, 3, -2],
            2: [3, 5, -2, 3, 5],
            3: [3, 5, 5, -2, 5], // Only testing rows; tile 18 is the last empty tile with two 5s.
            4: [3, 5, 5, 3, 5],
          },
        };

        final result = BotPlay.runBotPlay(
          filledAllTuples: filledAllRows,
          nonBotPlayerId: 5,
        );

        expect(result, 18);
      });
    });

    group('[findBestTileIndex]', () {
      const eId = -2; // Empty ID (shortened to keep tests on one line)
      const playId = 5;
      const botId = 2;

      const chkId = 5;
      test('starting with playerId -2 (empty) with player 1:', () {
        expect(BotPlay.findBestTileIndex([eId, eId, eId, eId, eId], chkId), (0, 0));
        expect(BotPlay.findBestTileIndex([eId, eId, eId, eId, playId], chkId), (3, 1));
        expect(BotPlay.findBestTileIndex([eId, eId, eId, playId, playId], chkId), (2, 2));
        expect(BotPlay.findBestTileIndex([eId, eId, eId, playId, botId], chkId), (2, 1));
        expect(BotPlay.findBestTileIndex([eId, eId, eId, botId, playId], chkId), (0, 0));
        expect(BotPlay.findBestTileIndex([eId, eId, playId, eId, eId], chkId), (1, 1));
        expect(BotPlay.findBestTileIndex([eId, eId, playId, playId, playId], chkId), (1, 3));
        expect(BotPlay.findBestTileIndex([eId, eId, playId, botId, playId], chkId), (1, 1));
        expect(BotPlay.findBestTileIndex([eId, eId, botId, playId, playId], chkId), (0, 0));
        expect(BotPlay.findBestTileIndex([eId, playId, eId, eId, eId], chkId), (0, 1));
        expect(BotPlay.findBestTileIndex([eId, playId, eId, eId, playId], chkId), (3, 1));
        expect(BotPlay.findBestTileIndex([eId, playId, eId, playId, eId], chkId), (2, 1));
        expect(BotPlay.findBestTileIndex([eId, playId, eId, playId, playId], chkId), (2, 2));
        expect(BotPlay.findBestTileIndex([eId, playId, playId, eId, eId], chkId), (0, 2));
        expect(BotPlay.findBestTileIndex([eId, playId, playId, eId, botId], chkId), (0, 2));
        expect(BotPlay.findBestTileIndex([eId, playId, playId, playId, eId], chkId), (0, 3));
        expect(BotPlay.findBestTileIndex([eId, playId, playId, playId, playId], chkId), (0, 4));
        expect(BotPlay.findBestTileIndex([eId, playId, playId, botId, botId], chkId), (0, 2));
        expect(BotPlay.findBestTileIndex([eId, botId, eId, playId, playId], chkId), (2, 2));
        expect(BotPlay.findBestTileIndex([eId, botId, playId, playId, eId], chkId), (4, 2));
        expect(BotPlay.findBestTileIndex([eId, botId, playId, playId, botId], chkId), (0, 0));
        expect(BotPlay.findBestTileIndex([eId, botId, botId, playId, playId], chkId), (0, 0));
        expect(BotPlay.findBestTileIndex([eId, botId, botId, botId, botId], chkId), (0, 0));
      });

      test('starting with playerId -2 (empty) mixed with players 1 and 2:', () {
        expect(BotPlay.findBestTileIndex([eId, eId, playId, playId, botId], chkId), (1, 2));
        expect(BotPlay.findBestTileIndex([eId, eId, playId, botId, botId], chkId), (1, 1));
        expect(BotPlay.findBestTileIndex([eId, eId, botId, playId, botId], chkId), (0, 0));
        expect(BotPlay.findBestTileIndex([eId, eId, botId, botId, playId], chkId), (0, 0));
        expect(BotPlay.findBestTileIndex([eId, eId, botId, botId, botId], chkId), (0, 0));
        expect(BotPlay.findBestTileIndex([eId, playId, eId, playId, botId], chkId), (2, 1));
        expect(BotPlay.findBestTileIndex([eId, playId, eId, botId, playId], chkId), (0, 1));
        expect(BotPlay.findBestTileIndex([eId, playId, eId, botId, botId], chkId), (0, 1));
        expect(BotPlay.findBestTileIndex([eId, playId, playId, botId, eId], chkId), (0, 2));
        expect(BotPlay.findBestTileIndex([eId, playId, botId, eId, playId], chkId), (3, 1));
        expect(BotPlay.findBestTileIndex([eId, playId, botId, eId, botId], chkId), (0, 1));
        expect(BotPlay.findBestTileIndex([eId, playId, botId, playId, eId], chkId), (4, 1));
        expect(BotPlay.findBestTileIndex([eId, playId, botId, playId, botId], chkId), (0, 1));
        expect(BotPlay.findBestTileIndex([eId, playId, botId, botId, eId], chkId), (0, 1));
        expect(BotPlay.findBestTileIndex([eId, playId, botId, botId, playId], chkId), (0, 1));
        expect(BotPlay.findBestTileIndex([eId, playId, botId, botId, botId], chkId), (0, 1));
        expect(BotPlay.findBestTileIndex([eId, botId, eId, playId, botId], chkId), (2, 1));
        expect(BotPlay.findBestTileIndex([eId, botId, eId, botId, playId], chkId), (0, 0));
        expect(BotPlay.findBestTileIndex([eId, botId, eId, botId, botId], chkId), (0, 0));
        expect(BotPlay.findBestTileIndex([eId, botId, playId, eId, playId], chkId), (3, 1));
        expect(BotPlay.findBestTileIndex([eId, botId, playId, eId, botId], chkId), (3, 1));
        // Only one play to make; and it's not adjacent to the non-bot player.
        expect(BotPlay.findBestTileIndex([eId, botId, playId, playId, playId], chkId), (0, 0));
      });

      test('starting with player 1:', () {
        expect(BotPlay.findBestTileIndex([playId, eId, eId, eId, eId], chkId), (1, 1));
        expect(BotPlay.findBestTileIndex([playId, eId, eId, eId, botId], chkId), (1, 1));
        expect(BotPlay.findBestTileIndex([playId, eId, eId, botId, botId], chkId), (1, 1));
        expect(BotPlay.findBestTileIndex([playId, eId, botId, botId, botId], chkId), (1, 1));
        expect(BotPlay.findBestTileIndex([playId, playId, eId, eId, eId], chkId), (2, 2));
        expect(BotPlay.findBestTileIndex([playId, playId, eId, botId, botId], chkId), (2, 2));
        expect(BotPlay.findBestTileIndex([playId, playId, playId, eId, eId], chkId), (3, 3));
        expect(BotPlay.findBestTileIndex([playId, playId, playId, playId, eId], chkId), (4, 4));
        expect(BotPlay.findBestTileIndex([playId, playId, playId, botId, botId], chkId), (-1, 0));
        expect(BotPlay.findBestTileIndex([playId, playId, botId, playId, botId], chkId), (-1, 0));
        expect(BotPlay.findBestTileIndex([playId, playId, botId, botId, botId], chkId), (-1, 0));
        expect(BotPlay.findBestTileIndex([playId, botId, playId, playId, eId], chkId), (4, 2));
        expect(BotPlay.findBestTileIndex([playId, botId, playId, playId, botId], chkId), (-1, 0));
        expect(BotPlay.findBestTileIndex([playId, botId, playId, botId, botId], chkId), (-1, 0));
        expect(BotPlay.findBestTileIndex([playId, botId, botId, playId, playId], chkId), (-1, 0));
        expect(BotPlay.findBestTileIndex([playId, botId, botId, playId, botId], chkId), (-1, 0));
        expect(BotPlay.findBestTileIndex([playId, botId, botId, botId, playId], chkId), (-1, 0));
        expect(BotPlay.findBestTileIndex([playId, botId, botId, botId, botId], chkId), (-1, 0));
      });

      test('starting with player 2:', () {
        expect(BotPlay.findBestTileIndex([botId, eId, eId, eId, eId], chkId), (1, 0));
        expect(BotPlay.findBestTileIndex([botId, eId, eId, playId, playId], chkId), (2, 2));
        expect(BotPlay.findBestTileIndex([botId, eId, playId, playId, playId], chkId), (1, 3));
        expect(BotPlay.findBestTileIndex([botId, playId, eId, eId, eId], chkId), (2, 1));
        expect(BotPlay.findBestTileIndex([botId, playId, eId, eId, playId], chkId), (3, 1));
        expect(BotPlay.findBestTileIndex([botId, playId, eId, playId, eId], chkId), (2, 1));
        expect(BotPlay.findBestTileIndex([botId, playId, eId, playId, playId], chkId), (2, 2));
        expect(BotPlay.findBestTileIndex([botId, playId, playId, eId, eId], chkId), (3, 2));
        expect(BotPlay.findBestTileIndex([botId, playId, playId, eId, botId], chkId), (3, 2));
        expect(BotPlay.findBestTileIndex([botId, playId, playId, playId, eId], chkId), (4, 3));
        expect(BotPlay.findBestTileIndex([botId, playId, playId, playId, playId], chkId), (-1, 0));
        expect(BotPlay.findBestTileIndex([botId, playId, playId, playId, botId], chkId), (-1, 0));
        expect(BotPlay.findBestTileIndex([botId, playId, playId, botId, botId], chkId), (-1, 0));
        expect(BotPlay.findBestTileIndex([botId, botId, eId, eId, playId], chkId), (3, 1));
        expect(BotPlay.findBestTileIndex([botId, botId, eId, playId, playId], chkId), (2, 2));
        expect(BotPlay.findBestTileIndex([botId, botId, playId, playId, eId], chkId), (4, 2));
        expect(BotPlay.findBestTileIndex([botId, botId, playId, playId, botId], chkId), (-1, 0));
        expect(BotPlay.findBestTileIndex([botId, botId, botId, playId, playId], chkId), (-1, 0));
      });

      test('additional edge cases and patterns:', () {
        // Single player dominance.
        expect(BotPlay.findBestTileIndex([botId, botId, botId, botId, botId], chkId), (-1, 0));
        expect(BotPlay.findBestTileIndex([playId, playId, playId, playId, playId], chkId), (-1, 0));

        // Alternating patterns.
        expect(BotPlay.findBestTileIndex([playId, botId, playId, botId, playId], chkId), (-1, 0));
        expect(BotPlay.findBestTileIndex([botId, playId, botId, playId, botId], chkId), (-1, 0));

        // Interspersed empty tiles.
        expect(BotPlay.findBestTileIndex([playId, eId, playId, eId, playId], chkId), (3, 1));
        expect(BotPlay.findBestTileIndex([botId, eId, botId, eId, botId], chkId), (1, 0));
      });
    });
  });
}
