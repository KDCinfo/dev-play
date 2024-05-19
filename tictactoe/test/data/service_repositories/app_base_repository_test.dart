import 'package:dev_play_tictactoe/src/data/service_repositories/service_repositories.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mocks.dart';

void main() {
  group('AppBaseRepository', () {
    late AppBaseRepository appBaseRepository;
    late MockStorageAPI mockStorageAPI;

    setUp(() {
      mockStorageAPI = MockStorageAPI();
      appBaseRepository = ScorebookRepository(
        storageService: mockStorageAPI,
      );
    });

    test('should initialize repository', () {
      // The `init` function is called when the repository is instantiated.
      // Calling it here would result in two calls.
      // appBaseRepository.initRepository();

      expect(appBaseRepository, isA<AppBaseRepository>());
      expect(appBaseRepository, isA<ScorebookRepository>());

      verify(() => mockStorageAPI.prefsGetString(any())).called(1);
    });
  });
}
