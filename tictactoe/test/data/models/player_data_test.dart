import 'package:dev_play_tictactuple/src/data/models/models.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlayerData tests:', () {
    test('PlayerData should be a [PlayerData]', () {
      const playerData = PlayerData(
        playerNum: 1,
        playerId: 123,
        playerName: 'John',
        // playerType: PlayerTypeBot(),
        userSymbol: UserSymbolEmpty(),
      );

      expect(playerData, isA<PlayerData>());
    });

    test('PlayerData [label] should return the correct player label', () {
      const playerData = PlayerData(playerNum: 2);

      expect(playerData.label, equals('Player 2 Name:'));
    });

    test('PlayerData [toString] should return the correct string representation', () {
      const playerData = PlayerData(
        playerNum: 1,
        playerId: 123,
        playerName: 'John',
        // playerType: PlayerTypeBot(),
        userSymbol: UserSymbolEmpty(),
      );

      expect(
        playerData.toString(),
        equals('PlayerData(1, 123, John, PlayerTypeBot(PlayerTypeEnum.bot), UserSymbolEmpty(?))'),
      );
    });

    test('PlayerData [copyWith] should return a new PlayerData with updated values', () {
      const playerData = PlayerData(
        playerNum: 1,
        playerId: 123,
        playerName: 'John',
        // playerType: PlayerTypeBot(),
        userSymbol: UserSymbolEmpty(),
      );

      final updatedPlayer = playerData.copyWith(
        playerId: 456,
        playerName: 'Jane',
        playerType: const PlayerTypeHuman(),
        userSymbol: const UserSymbolX(),
      );

      expect(updatedPlayer.playerNum, equals(playerData.playerNum));
      expect(updatedPlayer.playerId, equals(456));
      expect(updatedPlayer.playerName, equals('Jane'));
      expect(updatedPlayer.playerType, isA<PlayerTypeHuman>());
      expect(updatedPlayer.userSymbol, isA<UserSymbolX>());

      final updatedPlayer2 = updatedPlayer.copyWith(
        playerNum: 3,
      );

      expect(updatedPlayer2.playerNum, equals(3));
      // Nothing else changes from first copyWith
      expect(updatedPlayer2.playerId, equals(456));
      expect(updatedPlayer2.playerName, equals('Jane'));
      expect(updatedPlayer2.playerType, isA<PlayerTypeHuman>());
      expect(updatedPlayer2.userSymbol, isA<UserSymbolX>());
    });

    group('Equatable:', () {
      test('PlayerData should be an [Equatable]', () {
        const playerData = PlayerData(
          playerNum: 1,
          playerId: 123,
          playerName: 'John',
          // playerType: PlayerTypeBot(),
          userSymbol: UserSymbolEmpty(),
        );

        expect(playerData, isA<Equatable>());
      });

      test('PlayerData [props] should return the correct list of properties', () {
        const playerData = PlayerData(
          playerNum: 1,
          playerId: 123,
          playerName: 'John',
          // playerType: PlayerTypeBot(),
          userSymbol: UserSymbolEmpty(),
        );

        expect(
          playerData.props,
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

    group('PlayerData [JSON]:', () {
      test('toJson', () {
        const playerData = PlayerData(
          playerNum: 1,
          playerId: 123,
          playerName: 'John',
          playerType: PlayerTypeHuman(),
          userSymbol: UserSymbolEmpty(),
        );
        expect(
          playerData.toJson(),
          equals({
            'playerNum': 1,
            'playerId': 123,
            'playerName': 'John',
            'playerType': {'playerType': 'PlayerTypeEnum.human'},
            'userSymbol': {'markerKey': '?'},
          }),
        );
      });
      test('fromJson', () {
        const playerData = PlayerData(
          playerNum: 1,
          playerId: 123,
          playerName: 'John',
          playerType: PlayerTypeHuman(),
          userSymbol: UserSymbolEmpty(),
        );
        final playerDataJson = playerData.toJson();
        final playerDataFromJson = PlayerData.fromJson(playerDataJson);
        expect(playerData, equals(playerDataFromJson));
      });
    });

    group('Equality:', () {
      test('PlayerData [==] should return true if two PlayerDatas are equal', () {
        const playerData1 = PlayerData(
          playerNum: 1,
          playerId: 123,
          playerName: 'John',
          // playerType: PlayerTypeBot(),
          userSymbol: UserSymbolEmpty(),
        );

        const playerData2 = PlayerData(
          playerNum: 1,
          playerId: 123,
          playerName: 'John',
          // playerType: PlayerTypeBot(),
          userSymbol: UserSymbolEmpty(),
        );

        expect(playerData1 == playerData2, isTrue);
      });

      test('PlayerData [==] should return false if two PlayerDatas are not equal', () {
        const playerData1 = PlayerData(
          playerNum: 1,
          playerId: 123,
          playerName: 'John',
          // playerType: PlayerTypeBot(),
          userSymbol: UserSymbolEmpty(),
        );

        const playerData2 = PlayerData(
          playerNum: 2,
          playerId: 456,
          playerName: 'Jane',
          playerType: PlayerTypeHuman(),
          userSymbol: UserSymbolX(),
        );

        expect(playerData1 == playerData2, isFalse);
      });
    });

    group('Hashes:', () {
      test(
        'PlayerData PlayerTypeBot [hashCode] should return '
        'consistent results for equal objects',
        () {
          const playerData1 = PlayerData(
            playerNum: 1,
            playerId: 123,
            playerName: 'John',
            // playerType: PlayerTypeBot(),
            userSymbol: UserSymbolEmpty(),
          );
          const playerData2 = PlayerData(
            playerNum: 1,
            playerId: 123,
            playerName: 'John',
            // playerType: PlayerTypeBot(),
            userSymbol: UserSymbolEmpty(),
          );

          expect(playerData1.hashCode, equals(playerData2.hashCode));
        },
      );
      test('PlayerData PlayerTypeBot [hashCode] should be based on properties', () {
        const playerTypeBot = PlayerTypeBot();
        const anotherPlayerTypeBot = PlayerTypeBot();

        expect(playerTypeBot.hashCode, equals(anotherPlayerTypeBot.hashCode));
      });
    });
  });
}
