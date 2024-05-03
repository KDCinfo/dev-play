import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlayerType', () {
    test('PlayerTypeHuman should have correct playerType', () {
      const playerType = PlayerTypeHuman();
      expect(playerType.playerType, PlayerTypeEnum.human);
    });

    test('PlayerTypeBot should have correct playerType', () {
      const playerType = PlayerTypeBot();
      expect(playerType.playerType, PlayerTypeEnum.bot);
    });
  });
}
