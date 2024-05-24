import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLoadBlocObserver extends BlocObserver {
  @override
  void onChange(
    BlocBase<dynamic> bloc,
    Change<dynamic> change,
  ) {
    super.onChange(bloc, change);
    log('[base_bloc_observer.dart] onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    log('[base_bloc_observer.dart] onTransition(${bloc.runtimeType}, $onTransition)');
  }

  @override
  void onError(
    BlocBase<dynamic> bloc,
    Object error,
    StackTrace stackTrace,
  ) {
    super.onError(bloc, error, stackTrace);
    log('[base_bloc_observer.dart] onError(${bloc.runtimeType}, $error, $stackTrace)');
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
