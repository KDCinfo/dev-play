// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLoadBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    print('[base_bloc_observer.dart] onEvent(${bloc.runtimeType}, $event)');
  }

  @override
  void onChange(
    BlocBase<dynamic> bloc,
    Change<dynamic> change,
  ) {
    super.onChange(bloc, change);
    print('[base_bloc_observer.dart] onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    print('[base_bloc_observer.dart] onTransition');
    print(transition);
  }

  @override
  void onError(
    BlocBase<dynamic> bloc,
    Object error,
    StackTrace stackTrace,
  ) {
    super.onError(bloc, error, stackTrace);
    print('[base_bloc_observer.dart] onError');
    print(error);
    print(stackTrace);
  }
}

///
Future<void> appLoadBlocObserver(
  FutureOr<Widget> Function() childBaseApp,
) async {
  Bloc.observer = AppLoadBlocObserver();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runApp(await childBaseApp());
}
