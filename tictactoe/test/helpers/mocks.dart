import 'package:base_services/base_services.dart';

import 'package:dev_play_tictactoe/src/data/data.dart';

import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

class MockStorageAPI extends Mock implements StorageServiceApi {}

class MockScorebookRepository extends Mock implements ScorebookRepository {}

/// Navigation Mocks

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockRoute extends Mock implements Route<void> {}

class FakeRoute extends Fake implements Route<void> {}
