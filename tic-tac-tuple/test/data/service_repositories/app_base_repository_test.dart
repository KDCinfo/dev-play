import 'package:dev_play_tictactuple/src/data/service_repositories/service_repositories.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mocks.dart';

void main() {
  group('[AppBaseRepository] Testing:', () {
    late AppBaseRepository appBaseRepository;
    late MockStorageAPI mockStorageAPI;

    setUp(() {
      mockStorageAPI = MockStorageAPI();
      appBaseRepository = ScorebookRepository(
        storageService: mockStorageAPI,
      );
    });

    test('repository works properly.', () {
      expect(appBaseRepository, isA<AppBaseRepository>());
      expect(appBaseRepository, isA<ScorebookRepository>());

      verify(() => mockStorageAPI.prefsGetString(any())).called(1);
    });

    test('should initialize repository.', () {
      // The `init` function is called when the repository is instantiated.
      // Calling it explicitly results in two `prefsGetString` calls.
      appBaseRepository.initRepository();

      verify(() => mockStorageAPI.prefsGetString(any())).called(2);
    });
  });
}
