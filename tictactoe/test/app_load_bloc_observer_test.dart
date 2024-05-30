// ignore_for_file: prefer_const_constructors

import 'package:dev_play_tictactuple/src/app_load_bloc_observer.dart';

import 'package:flutter_test/flutter_test.dart';

import 'helpers/helpers.dart';

/// All the tests within were borrowed from the
/// Flutter Bloc library `flutter_firebase_login` example.
///
void main() {
  group('AppLoadBlocObserver', () {
    setUp(testPrintLogs.clear);

    test(
      'onEvent prints event',
      overridePrint(() {
        final bloc = FakeBloc();
        final event = FakeEvent();
        AppLoadBlocObserver().onEvent(bloc, event);
        expect(testPrintLogs, equals(getLog('onEvent', event)));
      }),
    );

    test(
      'onChange prints change',
      overridePrint(() {
        final bloc = FakeBloc();
        final change = FakeChange();
        AppLoadBlocObserver().onChange(bloc, change);
        expect(testPrintLogs, equals(getLog('onChange', change)));
      }),
    );

    test(
      'onTransition prints transition',
      overridePrint(() {
        final bloc = FakeBloc();
        final transition = FakeTransition();
        AppLoadBlocObserver().onTransition(bloc, transition);
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
      'onError prints error',
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
}
