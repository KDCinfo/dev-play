// ignore_for_file: prefer_const_constructors

import 'package:dev_play_tictactuple/src/app_main/app_load_bloc_observer.dart';

import 'package:flutter_test/flutter_test.dart';

import 'helpers/helpers.dart';

/// All the tests within were borrowed from the
/// Flutter Bloc library `flutter_firebase_login` example.
///
void main() {
  group('[AppLoadBlocObserver] Testing:', () {
    setUp(testPrintLogs.clear);

    group('when showLog constant is true:', () {
      test(
        '[onEvent] prints events.',
        overridePrint(() {
          final bloc = FakeBloc();
          final event = FakeEvent();
          AppLoadBlocObserver(showLogBlocObservers: true).onEvent(bloc, event);
          expect(testPrintLogs, equals(getLog('onEvent', event)));
        }),
      );

      test(
        '[onChange] prints changes.',
        overridePrint(() {
          final bloc = FakeBloc();
          final change = FakeChange();
          AppLoadBlocObserver(showLogBlocObservers: true).onChange(bloc, change);
          expect(testPrintLogs, equals(getLog('onChange', change)));
        }),
      );

      test(
        '[onTransition] prints transitions.',
        overridePrint(() {
          final bloc = FakeBloc();
          final transition = FakeTransition();
          AppLoadBlocObserver(showLogBlocObservers: true).onTransition(bloc, transition);
          expect(
            testPrintLogs,
            equals([
              '[base_bloc_observer.dart] onTransition',
              '$transition',
            ]),
          );
        }),
      );

      test(
        '[onError] prints errors.',
        overridePrint(() {
          final bloc = FakeBloc();
          final error = Object();
          final stackTrace = FakeStackTrace();
          AppLoadBlocObserver().onError(bloc, error, stackTrace);
          expect(
            testPrintLogs,
            equals([
              '[base_bloc_observer.dart] onError',
              '$error',
              '$stackTrace',
            ]),
          );
        }),
      );
    });

    group('when showLog constant is false:', () {
      test(
        '[onEvent] does not print events.',
        overridePrint(() {
          final bloc = FakeBloc();
          final event = FakeEvent();
          AppLoadBlocObserver().onEvent(bloc, event);
          expect(testPrintLogs, equals([]));
        }),
      );

      test(
        '[onChange] does not print changes.',
        overridePrint(() {
          final bloc = FakeBloc();
          final change = FakeChange();
          AppLoadBlocObserver().onChange(bloc, change);
          expect(testPrintLogs, equals([]));
        }),
      );

      test(
        '[onTransition] does not print transitions.',
        overridePrint(() {
          final bloc = FakeBloc();
          final transition = FakeTransition();
          AppLoadBlocObserver().onTransition(bloc, transition);
          expect(
            testPrintLogs,
            equals([]),
          );
        }),
      );
    });
  });
}
