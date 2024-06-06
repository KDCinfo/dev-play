import 'package:dev_play_tictactuple/src/data/models/models.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[PreviousIdTracker] Testing:', () {
    test('should construct a new instance with defaults.', () {
      const tracker = PreviousIdTracker();

      expect(tracker.playerId, equals(-1));
      expect(tracker.currentLongestCount, equals(0));
      expect(tracker.loopIndex, equals(-1));
    });

    test('[copyWith] method should return a new instance with updated values.', () {
      const tracker = PreviousIdTracker(
        playerId: 1,
        currentLongestCount: 5,
        loopIndex: 10,
      );

      final updatedTracker = tracker.copyWith(
        playerId: 2,
        currentLongestCount: 6,
        loopIndex: 11,
      );

      expect(updatedTracker.playerId, equals(2));
      expect(updatedTracker.currentLongestCount, equals(6));
      expect(updatedTracker.loopIndex, equals(11));
    });

    test('[props] should return the correct list of properties.', () {
      const tracker = PreviousIdTracker(
        playerId: 1,
        currentLongestCount: 5,
        loopIndex: 10,
      );

      expect(tracker.props, equals([1, 5, 10]));
    });
  });
}
