import 'package:dev_play_tictactuple/src/app_main/app_main.dart';
import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/data/service_repositories/service_repositories.dart';
import 'package:dev_play_tictactuple/src/screens/screens.dart';

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
    late GamePlayBloc mockGamePlayBloc;

    setUp(() {
      mockScorebookRepository = MockScorebookRepository();
      mockGameEntryBloc = MockGameEntryBloc();
      mockGamePlayBloc = MockGamePlayBloc();

      widgetToTest = const AppWrapper();
      wrappedWidget = PumpApp.providerWrappedWithNoMaterialApp(
        scorebookRepository: mockScorebookRepository,
        gameEntryBloc: mockGameEntryBloc,
        gamePlayBloc: mockGamePlayBloc,
        child: widgetToTest,
      );

      when(() => mockGameEntryBloc.state).thenReturn(const GameEntryState());
      when(() => mockGamePlayBloc.state).thenReturn(const GamePlayState());
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
