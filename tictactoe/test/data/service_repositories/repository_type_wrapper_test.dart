import 'package:dev_play_tictactoe/src/data/service_repositories/service_repositories.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../helpers/mocks.dart';

void main() {
  group('RepositoryTypeWrapper', () {
    test('should store the repository correctly', () {
      final repository = MockRepository();
      final wrapper = RepositoryTypeWrapper<MockRepository>(repository: repository);

      expect(wrapper.repository, equals(repository));
    });

    test('should store the repository correctly', () {
      final repository = ScorebookRepository(storageService: MockStorageAPI());
      final wrapper = RepositoryTypeWrapper<ScorebookRepository>(repository: repository);

      expect(wrapper.repository, equals(repository));
    });
  });
}

class MockRepository {}
