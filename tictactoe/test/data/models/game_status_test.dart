import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';

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

    group('GameStatus [JSON]:', () {
      group('GameStatusInProgress:', () {
        test('toJson', () {
          const gameStatus = GameStatusInProgress();
          expect(gameStatus.toJson(), equals({'statusMessage': 'In Progress'}));
        });
        test('fromJson', () {
          const gameStatus = GameStatusInProgress();
          final gameStatusJson = gameStatus.toJson();
          final gameStatusFromJson = GameStatus.fromJson(gameStatusJson);
          expect(gameStatus, equals(gameStatusFromJson));
        });
      });
      group('GameStatusComplete:', () {
        test('toJson', () {
          const gameStatus = GameStatusComplete();
          expect(gameStatus.toJson(), equals({'statusMessage': 'Complete'}));
        });
        test('fromJson', () {
          const gameStatus = GameStatusComplete();
          final gameStatusJson = gameStatus.toJson();
          final gameStatusFromJson = GameStatus.fromJson(gameStatusJson);
          expect(gameStatus, equals(gameStatusFromJson));
        });
      });
    });
  });
}
