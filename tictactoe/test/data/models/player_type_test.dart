import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/data/models/models.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlayerType tests:', () {
    group('PlayerType [type]:', () {
      test('PlayerTypeHuman should have [correct playerType]', () {
        const playerType = PlayerTypeHuman();
        expect(playerType.playerType, PlayerTypeEnum.human);
      });
      test('PlayerTypeBot should have [correct playerType]', () {
        const playerType = PlayerTypeBot();
        expect(playerType.playerType, PlayerTypeEnum.bot);
      });
    });

    group('PlayerType [toString]:', () {
      test('PlayerTypeHuman [toString] should return the correct string', () {
        const playerType = PlayerTypeHuman();
        expect(playerType.toString(), equals('PlayerTypeHuman(PlayerTypeEnum.human)'));
      });
      test('PlayerTypeBot [toString] should return the correct string', () {
        const playerType = PlayerTypeBot();
        expect(playerType.toString(), equals('PlayerTypeBot(PlayerTypeEnum.bot)'));
      });
    });

    group('PlayerType [JSON]:', () {
      group('PlayerTypeHuman:', () {
        test('toJson', () {
          const playerType = PlayerTypeHuman();
          expect(playerType.toJson(), equals({'playerType': 'PlayerTypeEnum.human'}));
        });
        test('fromJson', () {
          const playerType = PlayerTypeHuman();
          final playerTypeJson = playerType.toJson();
          final playerTypeFromJson = PlayerType.fromJson(playerTypeJson);
          expect(playerType, equals(playerTypeFromJson));
        });
      });
      group('PlayerTypeBot:', () {
        test('toJson', () {
          const playerType = PlayerTypeBot();
          expect(playerType.toJson(), equals({'playerType': 'PlayerTypeEnum.bot'}));
        });
        test('fromJson', () {
          const playerType = PlayerTypeBot();
          final playerTypeJson = playerType.toJson();
          final playerTypeFromJson = PlayerType.fromJson(playerTypeJson);
          expect(playerType, equals(playerTypeFromJson));
        });
      });
    });

    group('PlayerType [Equatable]:', () {
      /// Types
      test('PlayerTypeHuman should be an [Equatable]', () {
        const playerType = PlayerTypeHuman();
        expect(playerType, isA<PlayerType>());
      });
      test('PlayerTypeBot should be an [Equatable]', () {
        const playerType = PlayerTypeBot();
        expect(playerType, isA<PlayerType>());
      });

      /// Props
      test('PlayerTypeHuman [props] should return the correct list of properties', () {
        const playerType = PlayerTypeHuman();
        expect(playerType.props, equals([PlayerTypeEnum.human]));
      });
      test('PlayerTypeBot [props] should return the correct list of properties', () {
        const playerType = PlayerTypeBot();
        expect(playerType.props, equals([PlayerTypeEnum.bot]));
      });
    });

    group('PlayerType [Equality]:', () {
      // == Equal
      test('PlayerTypeHuman [==] should return true if two PlayerTypes are equal', () {
        const playerType1 = PlayerTypeHuman();
        const playerType2 = PlayerTypeHuman();
        expect(playerType1, equals(playerType2));
      });
      test('PlayerTypeBot [==] should return true if two PlayerTypes are equal', () {
        const playerType1 = PlayerTypeBot();
        const playerType2 = PlayerTypeBot();
        expect(playerType1, equals(playerType2));
      });

      // == Not Equal
      test('PlayerTypeHuman [==] should return false if two PlayerTypes are not equal', () {
        const playerType1 = PlayerTypeHuman();
        const playerType2 = PlayerTypeBot();
        expect(playerType1 == playerType2, isFalse);
      });
    });

    // hash
    group('Hashes:', () {
      test('PlayerTypeHuman [hashCode] should return consistent results for equal objects', () {
        const playerTypeHuman = PlayerTypeHuman();
        const anotherPlayerTypeHuman = PlayerTypeHuman();

        expect(playerTypeHuman.hashCode, equals(anotherPlayerTypeHuman.hashCode));
      });
      test('PlayerTypeBot [hashCode] should return consistent results for equal objects ', () {
        const playerTypeBot = PlayerTypeBot();
        const anotherPlayerTypeBot = PlayerTypeBot();

        expect(playerTypeBot.hashCode, equals(anotherPlayerTypeBot.hashCode));
      });
    });
  });
}
