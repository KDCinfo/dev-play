import 'package:bloc_test/bloc_test.dart';

import 'package:dev_play_tictactuple/src/data/data.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  late WaitForBotBloc waitForBotBloc;

  group('[WaitForBotBloc] Testing:', () {
    setUp(() {
      waitForBotBloc = WaitForBotBloc();
    });

    tearDown(() {
      waitForBotBloc.close();
    });

    // Group: General bloc tests
    group('[blocTest] Testing:', () {
      blocTest<WaitForBotBloc, WaitForBotState>(
        'emits nothing when nothing is added.',
        build: () => waitForBotBloc,
        expect: () => const <WaitForBotState>[],
      );

      blocTest<WaitForBotBloc, WaitForBotState>(
        'emits expected state when waitBot is off.',
        build: () => waitForBotBloc,
        act: (bloc) => bloc.add(
          const WaitForBotOffEvent(),
        ),
        expect: () => const <WaitForBotState>[
          WaitForBotState(), // isWaiting: false
        ],
      );

      blocTest<WaitForBotBloc, WaitForBotState>(
        'emits expected state when waitBot is turned on.',
        build: () => waitForBotBloc,
        act: (bloc) => bloc.add(
          const WaitForBotOnEvent(),
        ),
        expect: () => const <WaitForBotState>[
          WaitForBotState(isWaiting: true),
        ],
      );
    });

    // Group: Event tests
    group('[Unit] Testing:', () {
      group('constructor', () {
        test(
          'works properly',
          () => expect(() => waitForBotBloc, returnsNormally),
        );

        test('has correct initial state', () {
          expect(
            waitForBotBloc.state,
            equals(
              const WaitForBotState(),
            ),
          );
        });
      });

      test('updates the bot wait state to off.', () {
        final expectedState = waitForBotBloc.state.copyWith(
          botIsThinking: false,
        );

        waitForBotBloc.add(
          const WaitForBotOffEvent(),
        );

        expectLater(waitForBotBloc.stream, emits(expectedState));
      });

      test('updates the bot wait state to on.', () {
        final expectedState = waitForBotBloc.state.copyWith(
          botIsThinking: true,
        );

        waitForBotBloc.add(
          const WaitForBotOnEvent(),
        );

        expectLater(waitForBotBloc.stream, emits(expectedState));
      });
    });
  });
}
