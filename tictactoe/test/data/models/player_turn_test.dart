import 'package:dev_play_tictactoe/src/data/models/models.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[PlayerTurn] Testing:', () {
    const playerTurnId = 0;
    const playerId = 0;
    // const duration = Duration(seconds: 1);
    const occupiedBy = PlayerData(
      playerNum: 1,
      playerId: 0,
      playerName: 'Player 1',
      userSymbol: UserSymbolX(),
    );

    test(
        'PlayerTurn [copyWith] method should return '
        'a new PlayerTurn instance with updated values', () {
      const originalPlayerTurn = PlayerTurn(
        playerTurnId: playerTurnId,
        tileIndex: 2,
        playerId: playerId,
        // duration: duration,
        occupiedBy: occupiedBy,
      );

      final updatedPlayerTurn = originalPlayerTurn.copyWith(
        playerTurnId: 1,
        playerId: 5,
        duration: const Duration(seconds: 5),
        occupiedBy: const PlayerData(
          playerNum: 2,
          playerId: 5,
          playerName: 'Player 2',
          userSymbol: UserSymbolO(),
        ),
      );

      /// Test for `copyWith` nullables #1.
      final updatedPlayerTurn2 = updatedPlayerTurn.copyWith(
        playerTurnId: 2,
        tileIndex: 5,
      );

      /// Test for `copyWith` nullables #2.
      final updatedPlayerTurn3 = updatedPlayerTurn2.copyWith(
        playerId: 7,
        tileIndex: 3,
      );

      expect(updatedPlayerTurn.playerTurnId, 1);
      expect(updatedPlayerTurn.tileIndex, 2);
      expect(updatedPlayerTurn.playerId, 5);
      expect(updatedPlayerTurn.duration, const Duration(seconds: 5));
      expect(updatedPlayerTurn.occupiedBy.playerNum, 2);
      expect(updatedPlayerTurn.occupiedBy.playerId, 5);
      expect(updatedPlayerTurn.occupiedBy.playerName, 'Player 2');
      expect(updatedPlayerTurn.occupiedBy.userSymbol, const UserSymbolO());

      /// Test for `copyWith` nullables #1.
      expect(updatedPlayerTurn2.playerTurnId, 2);
      expect(updatedPlayerTurn2.tileIndex, 5);
      // Props not changed.
      expect(updatedPlayerTurn2.playerId, 5);
      expect(updatedPlayerTurn2.duration, const Duration(seconds: 5));
      expect(updatedPlayerTurn2.occupiedBy.playerNum, 2);
      expect(updatedPlayerTurn2.occupiedBy.playerId, 5);
      expect(updatedPlayerTurn2.occupiedBy.playerName, 'Player 2');
      expect(updatedPlayerTurn2.occupiedBy.userSymbol, const UserSymbolO());

      /// Test for `copyWith` nullables #2.
      expect(updatedPlayerTurn3.playerId, 7);
      expect(updatedPlayerTurn3.tileIndex, 3);
      // Props not changed.
      expect(updatedPlayerTurn3.playerTurnId, 2);
    });

    group('PlayerTurn [JSON]:', () {
      test('toJson', () {
        const playerTurn = PlayerTurn(
          playerTurnId: playerTurnId,
          tileIndex: 2,
          playerId: playerId,
          duration: Duration(seconds: 5),
          occupiedBy: occupiedBy,
        );
        expect(
          playerTurn.toJson(),
          equals({
            'playerTurnId': 0,
            'tileIndex': 2,
            'playerId': 0,
            'duration': 5,
            'occupiedBy': {
              'playerNum': 1,
              'playerId': 0,
              'playerName': 'Player 1',
              'playerType': {
                'playerType': 'PlayerTypeEnum.bot',
              },
              'userSymbol': {
                'markerKey': 'x',
              },
            },
          }),
        );
      });
      test('fromJson', () {
        const playerTurn = PlayerTurn(
          playerTurnId: playerTurnId,
          tileIndex: 2,
          playerId: playerId,
          duration: Duration(seconds: 5),
          occupiedBy: occupiedBy,
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
        playerId: 0,
        // duration: Duration(seconds: 1),
        occupiedBy: occupiedBy,
      );

      expect(
        playerTurn.props,
        equals([
          0,
          2,
          0,
          const Duration(seconds: 1),
          occupiedBy,
        ]),
      );
    });
  });
}
