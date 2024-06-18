import 'package:dev_play_tictactuple/src/data/models/models.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TilePositionModel', () {
    test('updatePosition should update the position for the given index', () {
      final model = TilePositionModel();
      const index = 0;
      const position = Offset(10, 20);

      model.updatePosition(index, position);

      expect(model.getPosition(index), equals(position));
    });

    test('getPosition should return the position for the given index', () {
      final model = TilePositionModel();
      const index = 0;
      const position = Offset(10, 20);

      model.updatePosition(index, position);

      expect(model.getPosition(index), equals(position));
    });

    test('getPosition should return null if position is not set for the given index', () {
      final model = TilePositionModel();
      const index = 0;

      expect(model.getPosition(index), isNull);
    });
  });
}
