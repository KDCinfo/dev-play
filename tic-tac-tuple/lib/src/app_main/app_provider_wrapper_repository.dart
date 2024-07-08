// ignore_for_file: avoid-shadowing

import 'package:dev_play_tictactuple/src/data/service_repositories/service_repositories.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The `AppProviderWrapperRepository` class allows repositories
/// to be provided to the app above the `MaterialApp` for global access.
///
/// It also allows for injecting repositories (like `ScorebookRepository`)
/// into blocs via the `AppProviderWrapperBloc` widget.
///
class AppProviderWrapperRepository<T extends AppBaseRepository> extends StatelessWidget {
  const AppProviderWrapperRepository({
    required this.repositories,
    required this.child,
    super.key,
  });

  final List<RepositoryTypeWrapper<T>> repositories;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        for (final repositoryWrapper in repositories)
          RepositoryProvider(
            create: (context) => repositoryWrapper.repository, // as ScorebookRepository,
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
