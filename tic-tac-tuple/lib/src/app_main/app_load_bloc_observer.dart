// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:developer';

import 'package:dev_play_tictactuple/src/app_constants.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLoadBlocObserver extends BlocObserver {
  const AppLoadBlocObserver({this.showLogBlocObservers = AppConstants.showLogBlocObservers});

  final bool showLogBlocObservers;

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    if (showLogBlocObservers) {
      print('[base_bloc_observer.dart] onEvent(${bloc.runtimeType}, $event)');
    }
  }

  @override
  void onChange(
    BlocBase<dynamic> bloc,
    Change<dynamic> change,
  ) {
    super.onChange(bloc, change);
    if (showLogBlocObservers) {
      print('[base_bloc_observer.dart] onChange(${bloc.runtimeType}, $change)');
    }
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    if (showLogBlocObservers) {
      print('[base_bloc_observer.dart] onTransition');
      print(transition);
    }
  }

  @override
  void onError(
    BlocBase<dynamic> bloc,
    Object error,
    StackTrace stackTrace,
  ) {
    super.onError(bloc, error, stackTrace);
    // Errors should always show when `canPrint` is enabled.
    if (AppConstants.canPrint) {
      print('[base_bloc_observer.dart] onError');
      print(error);
      print(stackTrace);
    }
  }
}

///
Future<void> appLoadBlocObserver(
  FutureOr<Widget> Function() childBaseApp,
) async {
  Bloc.observer = const AppLoadBlocObserver();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runApp(await childBaseApp());
}
