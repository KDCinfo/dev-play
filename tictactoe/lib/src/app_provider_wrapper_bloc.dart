import 'package:dev_play_tictactoe/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactoe/src/data/service_repositories/service_repositories.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The `AppProviderWrapperBloc` class allows repositories
/// to be injected into blocs after the repositories have been
/// provided to the app via the `AppProviderWrapperRepository` widget.
///
class AppProviderWrapperBloc<T extends AppBaseRepository> extends StatelessWidget {
  const AppProviderWrapperBloc({
    required this.child,
    this.gameEntryBloc,
    super.key,
  });

  final Widget child;
  final GameEntryBloc? gameEntryBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          gameEntryBloc ??
          GameEntryBloc(
            scorebookRepository: context.read<ScorebookRepository>(),
          ),
      child: Builder(
        builder: (context) {
          return child;
        },
      ),
    );
  }
}
