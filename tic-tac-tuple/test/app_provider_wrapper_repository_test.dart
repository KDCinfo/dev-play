import 'package:dev_play_tictactuple/src/app_main/app_provider_wrapper_repository.dart';
import 'package:dev_play_tictactuple/src/data/service_repositories/service_repositories.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'helpers/mocks.dart';

class MockAppBaseRepository extends Mock implements AppBaseRepository {}

void main() {
  group('[AppProviderWrapperRepository] Testing:', () {
    testWidgets('should build the [child widget].', (WidgetTester tester) async {
      // Arrange
      final child = Container();
      final repositories = <RepositoryTypeWrapper<AppBaseRepository>>[
        RepositoryTypeWrapper<AppBaseRepository>(
          repository: MockAppBaseRepository(),
        ),
      ];

      // Act
      await tester.pumpWidget(
        AppProviderWrapperRepository<AppBaseRepository>(
          repositories: repositories,
          child: child,
        ),
      );

      // Assert
      expect(find.byWidget(child), findsOneWidget);
    });

    testWidgets('should find the [Scorebook RepositoryProvider].', (WidgetTester tester) async {
      // Arrange
      final child = Container();
      final storageService = MockStorageAPI();
      final scorebookRepository = ScorebookRepository(storageService: storageService);
      final repositories = [
        RepositoryTypeWrapper<ScorebookRepository>(repository: scorebookRepository),
      ];
      final appProviderWrapperRepository = AppProviderWrapperRepository(
        repositories: repositories,
        child: child,
      );

      // Act
      await tester.pumpWidget(appProviderWrapperRepository);

      // Assert
      final repositoryProvider = find.ancestor(
        of: find.byType(Container),
        matching: find.byType(RepositoryProvider<ScorebookRepository>),
      );
      expect(repositoryProvider, findsOneWidget);
    });
  });
}
