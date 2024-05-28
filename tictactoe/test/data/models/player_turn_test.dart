import 'package:dev_play_tictactuple/src/data/models/models.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[PlayerTurn] Testing:', () {
    const playerTurnId = 0;
    // const duration = Duration(seconds: 1);
    const occupiedById = 0;

    test(
        'PlayerTurn [copyWith] method should return '
        'a new PlayerTurn instance with updated values', () {
      const originalPlayerTurn = PlayerTurn(
        playerTurnId: playerTurnId,
        tileIndex: 2,
        // duration: duration,
        occupiedById: occupiedById,
      );

      final updatedPlayerTurn = originalPlayerTurn.copyWith(
        playerTurnId: 1,
        duration: const Duration(seconds: 5),
        occupiedById: 5,
      );

      /// Test for `copyWith` nullables #1.
      final updatedPlayerTurn2 = updatedPlayerTurn.copyWith(
        playerTurnId: 2,
        tileIndex: 5,
      );

      /// Test for `copyWith` nullables #2.
      final updatedPlayerTurn3 = updatedPlayerTurn2.copyWith(
        tileIndex: 3,
      );

      expect(updatedPlayerTurn.playerTurnId, 1);
      expect(updatedPlayerTurn.tileIndex, 2);
      expect(updatedPlayerTurn.duration, const Duration(seconds: 5));
      expect(updatedPlayerTurn.occupiedById, 5);

      /// Test for `copyWith` nullables #1.
      expect(updatedPlayerTurn2.playerTurnId, 2);
      expect(updatedPlayerTurn2.tileIndex, 5);
      // Props not changed.
      expect(updatedPlayerTurn2.duration, const Duration(seconds: 5));
      expect(updatedPlayerTurn2.occupiedById, 5);

      /// Test for `copyWith` nullables #2.
      expect(updatedPlayerTurn3.tileIndex, 3);
      // Props not changed.
      expect(updatedPlayerTurn3.playerTurnId, 2);
    });

    group('PlayerTurn [JSON]:', () {
      test('toJson', () {
        const playerTurn = PlayerTurn(
          playerTurnId: playerTurnId,
          tileIndex: 2,
          duration: Duration(seconds: 5),
          occupiedById: occupiedById,
        );
        expect(
          playerTurn.toJson(),
          equals({
            'playerTurnId': 0,
            'tileIndex': 2,
            'duration': 5,
            'occupiedById': 0,
          }),
        );
      });
      test('fromJson', () {
        const playerTurn = PlayerTurn(
          playerTurnId: playerTurnId,
          tileIndex: 2,
          duration: Duration(seconds: 5),
          occupiedById: occupiedById,
        );
        final playerTurnJson = playerTurn.toJson();
        final playerTurnFromJson = PlayerTurn.fromJson(playerTurnJson);
        expect(playerTurn, equals(playerTurnFromJson));
      });
    });

    test('PlayerTurn [props] should return the correct list of properties', () {
      const playerTurn = PlayerTurn(
        playerTurnId: 0,
        tileIndex: 2,
        // duration: Duration(seconds: 1),
        occupiedById: occupiedById,
      );

      expect(
        playerTurn.props,
        equals([
          0,
          2,
          const Duration(seconds: 1),
          occupiedById,
        ]),
      );
    });
  });
}
