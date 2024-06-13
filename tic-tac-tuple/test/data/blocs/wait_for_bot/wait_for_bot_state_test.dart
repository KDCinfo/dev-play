// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:dev_play_tictactuple/src/data/data.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[WaitForBotState] Testing:', () {
    WaitForBotState createSubject() {
      return WaitForBotState();
    }

    test('supports value [equality].', () {
      expect(
        createSubject(),
        equals(createSubject()),
      );
    });

    test('[props] are correct.', () {
      expect(
        createSubject().props,
        equals(<Object>[false]),
      );
    });

    group('[copyWith]', () {
      test('returns the [same object if no arguments] are provided.', () {
        expect(
          createSubject().copyWith(
            botIsThinking: false,
          ),
          equals(
            createSubject(),
          ),
        );
      });

      test('retains the old value for every parameter if [null] is provided.', () {
        expect(
          createSubject().copyWith(
            botIsThinking: true,
          ),
          equals(
            WaitForBotState(isWaiting: true),
          ),
        );
      });

      test('replaces every [non-null] parameter.', () {
        expect(
          createSubject().copyWith(
            botIsThinking: true,
          ),
          equals(
            WaitForBotState(isWaiting: true),
          ),
        );
      });
    });
  });
}
