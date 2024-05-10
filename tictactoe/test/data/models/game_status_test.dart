import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/data/models/models.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[GameStatus] Testing:', () {
    group('[GameStatusInProgress]', () {
      test('statusMessage should be "In Progress"', () {
        const gameStatus = GameStatusInProgress();
        expect(gameStatus.statusMessage, GameStatusEnum.inProgress.statusStr);
      });

      test('props should contain statusMessage', () {
        const gameStatus = GameStatusInProgress();
        expect(gameStatus.props, [gameStatus.statusMessage]);
      });
    });

    group('[GameStatusComplete]', () {
      test('statusMessage should be "Complete"', () {
        const gameStatus = GameStatusComplete();
        expect(gameStatus.statusMessage, GameStatusEnum.complete.statusStr);
      });

      test('props should contain statusMessage', () {
        const gameStatus = GameStatusComplete();
        expect(gameStatus.props, [gameStatus.statusMessage]);
      });
    });
  });
}
