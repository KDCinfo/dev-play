import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GamePlayer tests:', () {
    test('GamePlayer should be a [GamePlayer]', () {
      const gamePlayer = GamePlayer(
        playerNum: 1,
        playerId: 123,
        playerName: 'John',
        playerType: PlayerTypeBot(),
        userSymbol: UserSymbolEmpty(),
      );

      expect(gamePlayer, isA<GamePlayer>());
    });

    test('GamePlayer [label] should return the correct player label', () {
      const gamePlayer = GamePlayer(playerNum: 2);

      expect(gamePlayer.label, equals('Player 2 Name:'));
    });

    test('GamePlayer [toString] should return the correct string representation', () {
      const gamePlayer = GamePlayer(
        playerNum: 1,
        playerId: 123,
        playerName: 'John',
        playerType: PlayerTypeBot(),
        userSymbol: UserSymbolEmpty(),
      );

      expect(
        gamePlayer.toString(),
        equals('GamePlayer(1, 123, John, PlayerTypeBot(PlayerTypeEnum.bot), UserSymbolEmpty(?))'),
      );
    });

    test('GamePlayer [copyWith] should return a new GamePlayer with updated values', () {
      const gamePlayer = GamePlayer(
        playerNum: 1,
        playerId: 123,
        playerName: 'John',
        playerType: PlayerTypeBot(),
        userSymbol: UserSymbolEmpty(),
      );

      final updatedPlayer = gamePlayer.copyWith(
        playerId: 456,
        playerName: 'Jane',
        playerType: const PlayerTypeHuman(),
        userSymbol: const UserSymbolX(),
      );

      expect(updatedPlayer.playerNum, equals(gamePlayer.playerNum));
      expect(updatedPlayer.playerId, equals(456));
      expect(updatedPlayer.playerName, equals('Jane'));
      expect(updatedPlayer.playerType, isA<PlayerTypeHuman>());
      expect(updatedPlayer.userSymbol, isA<UserSymbolX>());
    });

    group('Equatable:', () {
      test('GamePlayer should be an [Equatable]', () {
        const gamePlayer = GamePlayer(
          playerNum: 1,
          playerId: 123,
          playerName: 'John',
          playerType: PlayerTypeBot(),
          userSymbol: UserSymbolEmpty(),
        );

        expect(gamePlayer, isA<Equatable>());
      });

      test('GamePlayer [props] should return the correct list of properties', () {
        const gamePlayer = GamePlayer(
          playerNum: 1,
          playerId: 123,
          playerName: 'John',
          playerType: PlayerTypeBot(),
          userSymbol: UserSymbolEmpty(),
        );

        expect(
          gamePlayer.props,
          equals([
            1,
            123,
            'John',
            const PlayerTypeBot(),
            const UserSymbolEmpty(),
          ]),
        );
      });
    });

    group('Equality:', () {
      test('GamePlayer [==] should return true if two GamePlayers are equal', () {
        const gamePlayer1 = GamePlayer(
          playerNum: 1,
          playerId: 123,
          playerName: 'John',
          playerType: PlayerTypeBot(),
          userSymbol: UserSymbolEmpty(),
        );

        const gamePlayer2 = GamePlayer(
          playerNum: 1,
          playerId: 123,
          playerName: 'John',
          playerType: PlayerTypeBot(),
          userSymbol: UserSymbolEmpty(),
        );

        expect(gamePlayer1 == gamePlayer2, isTrue);
      });

      test('GamePlayer [==] should return false if two GamePlayers are not equal', () {
        const gamePlayer1 = GamePlayer(
          playerNum: 1,
          playerId: 123,
          playerName: 'John',
          playerType: PlayerTypeBot(),
          userSymbol: UserSymbolEmpty(),
        );

        const gamePlayer2 = GamePlayer(
          playerNum: 2,
          playerId: 456,
          playerName: 'Jane',
          playerType: PlayerTypeHuman(),
          userSymbol: UserSymbolX(),
        );

        expect(gamePlayer1 == gamePlayer2, isFalse);
      });
    });

    group('Hashes:', () {
      test(
          'GamePlayer PlayerTypeBot [hashCode] should return '
          'consistent results for equal objects', () {
        const gamePlayer1 = GamePlayer(
          playerNum: 1,
          playerId: 123,
          playerName: 'John',
          playerType: PlayerTypeBot(),
          userSymbol: UserSymbolEmpty(),
        );
        const gamePlayer2 = GamePlayer(
          playerNum: 1,
          playerId: 123,
          playerName: 'John',
          playerType: PlayerTypeBot(),
          userSymbol: UserSymbolEmpty(),
        );

        expect(gamePlayer1.hashCode, equals(gamePlayer2.hashCode));
      });
      test('GamePlayer PlayerTypeBot [hashCode] should be based on properties', () {
        const playerTypeBot = PlayerTypeBot();
        const anotherPlayerTypeBot = PlayerTypeBot();

        expect(playerTypeBot.hashCode, equals(anotherPlayerTypeBot.hashCode));
      });
    });
  });
}
