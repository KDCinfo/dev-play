import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockRoute extends Mock implements Route<void> {}

class FakeRoute extends Fake implements Route<void> {}
