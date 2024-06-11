// ignore_for_file: prefer_const_constructors

import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[WaitForBotEvent] Testing:', () {
    group('[WaitForBotOnEvent]', () {
      test('supports value [equality]', () {
        expect(
          WaitForBotOnEvent(),
          equals(
            WaitForBotOnEvent(),
          ),
        );
      });

      test('[props] are correct', () {
        expect(
          WaitForBotOnEvent().props,
          equals(<Object?>[]),
        );
      });
    });

    group('[WaitForBotOffEvent]', () {
      test('supports value [equality]', () {
        expect(
          WaitForBotOffEvent(),
          equals(
            WaitForBotOffEvent(),
          ),
        );
      });

      test('[props] are correct', () {
        expect(
          WaitForBotOffEvent().props,
          equals(<Object?>[]),
        );
      });
    });
  });
}
