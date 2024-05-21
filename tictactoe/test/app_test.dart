import 'package:dev_play_tictactoe/src/app.dart';
import 'package:dev_play_tictactoe/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactoe/src/data/service_repositories/service_repositories.dart';
import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'helpers/helpers.dart';

void main() {
  group('MyWidget', () {
    late Widget widgetToTest;
    late Widget wrappedWidget;
    late ScorebookRepository mockScorebookRepository;
    late GameEntryBloc mockGameEntryBloc;

    setUp(() async {
      mockScorebookRepository = MockScorebookRepository();
      mockGameEntryBloc = MockGameEntryBloc();

      widgetToTest = const MyApp();
      wrappedWidget = await PumpApp.providerWrappedWithNoMaterialApp(
        scorebookRepository: mockScorebookRepository,
        gameEntryBloc: mockGameEntryBloc,
        child: widgetToTest,
      );

      when(() => mockGameEntryBloc.state).thenReturn(const GameEntryState());
    });

    testWidgets('[MyWidget] has a MaterialApp', (WidgetTester tester) async {
      await tester.pumpWidget(wrappedWidget);
      final materialAppFinder = find.byType(MaterialApp);

      expect(materialAppFinder, findsOneWidget);
    });

    testWidgets('[MyWidget] has either a GameEntry or GameBoard', (WidgetTester tester) async {
      await tester.pumpWidget(wrappedWidget);
      final materialAppFinderEntry = find.byType(GameEntryScreen);
      final materialAppFinderBoard = find.byType(GameBoardScreen);

      // Ensure that only one of the two screens is present, not both:
      final foundEntry = tester.any(materialAppFinderEntry);
      final foundBoard = tester.any(materialAppFinderBoard);

      // Ensure that exactly one of these is true.
      expect(
        foundEntry != foundBoard,
        isTrue,
        reason: 'Should find exactly one of GameEntry or GameBoard',
      );
    });
  });
}
