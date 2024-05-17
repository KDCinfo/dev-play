import 'package:dev_play_tictactoe/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactoe/src/data/service_repositories/scorebook_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The `AppProviderWrapper` class allows
/// repositories and blocs to be provided
/// to the app above the `MaterialApp` for global access.
///
/// It also allows for injecting repositories
/// (like `ScorebookRepository`) into blocs
/// that need them, such as the `GameEntryBloc`.
///
class AppProviderWrapper extends StatelessWidget {
  const AppProviderWrapper({
    required this.scorebookRepository,
    required this.child,
    super.key,
  });

  final Widget child;

  final ScorebookRepository scorebookRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: scorebookRepository,
      child: BlocProvider(
        create: (context) => GameEntryBloc(
          scorebookRepository: scorebookRepository,
        ),
        child: child,
      ),
    );
  }
}
