// ignore_for_file: avoid-inferrable-type-arguments

import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/data/service_repositories/service_repositories.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// For the app's normal flow, blocs are created below, using the
/// repositories provided by the `AppProviderWrapperRepository` widget.
///
/// For testing purposes, this widget allows for blocs to
/// be injected, allowing for the use of mocked repositories.
///
class AppProviderWrapperBloc extends StatelessWidget {
  const AppProviderWrapperBloc({
    required this.child,
    this.gameEntryBloc,
    this.gamePlayBloc,
    super.key,
  });

  final Widget child;

  /// For testing purposes, these blocs are injected via the `PumpApp` helper,
  /// allowing for the use of mocked repositories.
  final GameEntryBloc? gameEntryBloc;
  final GamePlayBloc? gamePlayBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              gameEntryBloc ??
              GameEntryBloc(
                scorebookRepository: context.read<ScorebookRepository>(),
              ),
        ),
        BlocProvider(
          create: (context) =>
              gamePlayBloc ??
              GamePlayBloc(
                scorebookRepository: context.read<ScorebookRepository>(),
              ),
        ),
      ],
      child: Builder(
        builder: (context) {
          return child;
        },
      ),
    );
  }
}
