import 'package:dev_play_tictactoe/src/data/models/models.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[PlayerTurn] Testing:', () {
    const playerTurnId = 0;
    const playerId = 0;
    const duration = Duration(seconds: 1);
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
        playerId: playerId,
        duration: duration,
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

      expect(updatedPlayerTurn.playerTurnId, 1);
      expect(updatedPlayerTurn.playerId, 5);
      expect(updatedPlayerTurn.duration, const Duration(seconds: 5));
      expect(updatedPlayerTurn.occupiedBy.playerNum, 2);
      expect(updatedPlayerTurn.occupiedBy.playerId, 5);
      expect(updatedPlayerTurn.occupiedBy.playerName, 'Player 2');
      expect(updatedPlayerTurn.occupiedBy.userSymbol, const UserSymbolO());
    });

    test('props should return a list of all the properties of PlayerTurn', () {
      const playerTurn = PlayerTurn(
        playerTurnId: playerTurnId,
        playerId: playerId,
        duration: duration,
        occupiedBy: occupiedBy,
      );

      expect(playerTurn.props, [
        playerTurnId,
        playerId,
        duration,
        occupiedBy,
      ]);
    });
  });
}
