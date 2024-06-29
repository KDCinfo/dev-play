import 'package:dev_play_tictactuple/src/data/service_repositories/service_repositories.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../helpers/mocks.dart';

void main() {
  group('RepositoryTypeWrapper', () {
    test('should store a MockRepository correctly', () {
      const repository = MockRepository();
      const wrapper = RepositoryTypeWrapper<MockRepository>(repository: repository);

      expect(wrapper.repository, equals(repository));
    });

    test('should store the ScorebookRepository correctly', () {
      final repository = ScorebookRepository(storageService: MockStorageAPI());
      final wrapper = RepositoryTypeWrapper<ScorebookRepository>(repository: repository);

      expect(wrapper.repository, equals(repository));
    });
  });
}
