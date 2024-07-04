import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';
import 'package:dev_play_tictactuple/src/data/service_repositories/service_repositories.dart';
import 'package:dev_play_tictactuple/src/screens/game_entry/game_entry_board_size_row.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('[GameEntry BoardSize Widget] Testing:', () {
    late Widget widgetToTest;
    late Widget wrappedWidget;
    late ScorebookRepository mockScorebookRepository;
    late GameEntryBloc mockGameEntryBloc;

    setUpAll(() {
      registerFallbackValue(const ScorebookData());
      registerFallbackValue(const GameEntryState());
      registerFallbackValue(const GameEntryEdgeSizeEvent(edgeSize: 3));
    });

    setUp(() {
      mockScorebookRepository = MockScorebookRepository();
      mockGameEntryBloc = MockGameEntryBloc();

      widgetToTest = const GameEntryBoardSizeRow();
      wrappedWidget = PumpApp.providerWrappedMaterialApp(
        scorebookRepository: mockScorebookRepository,
        gameEntryBloc: mockGameEntryBloc,
        child: widgetToTest,
      );
    });

    ///
    /// Widget Testing
    ///

    group('[Widget]', () {
      // Stub stream
      setUp(() {
        when(() => mockScorebookRepository.currentScorebookData).thenReturn(const ScorebookData());
        when(() => mockScorebookRepository.scorebookDataStream).thenAnswer(
          (_) => Stream.value(const ScorebookData()),
        );
        when(() => mockGameEntryBloc.state).thenReturn(const GameEntryState());
      });

      testWidgets('[GameEntry Board Size] renders properly.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);

        /// [ Board Size Row ]
        ///
        final widgetFinderBoardSize = find.byType(GameEntryBoardSizeRow);
        expect(widgetFinderBoardSize, findsNWidgets(1));
      });

      testWidgets('[GameEntry Board Size] has a title.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);

        /// [ Board Size Labels ]
        ///
        final widgetFinderBoardSizeLabel = find.byKey(
          const ValueKey(AppConstants.boardSizeLabelKey),
        );
        expect(widgetFinderBoardSizeLabel, findsOneWidget);

        final boardSizeLabelWidget = tester.widget(widgetFinderBoardSizeLabel) as Text;
        expect(
          boardSizeLabelWidget,
          isA<Text>().having(
            (t) => t.data,
            'text',
            equals(AppConstants.boardSizeLabel),
          ),
        );
      });

      testWidgets('should find all the board size options.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);

        const boardSizes = AppConstants.boardSizes;

        for (var labelIndex = 0; labelIndex < boardSizes.length; labelIndex++) {
          // Find by Text.
          expect(
            find.text(boardSizes[labelIndex]),
            findsOneWidget,
          );

          // Find by Key with text.
          final widgetFinderSliderLabel = find.byKey(Key(AppConstants.sliderLabelKey(labelIndex)));
          final sliderLabelWidget = tester.widget(widgetFinderSliderLabel) as Text;
          expect(
            widgetFinderSliderLabel,
            findsOneWidget,
          );
          expect(
            sliderLabelWidget,
            isA<Text>().having(
              (t) => t.data,
              'text',
              equals(boardSizes[labelIndex]),
            ),
          );
        }
      });
    });

    /// Bloc Tests

    group('[BlocBuilder] with mocked bloc', () {
      setUp(() {
        when(() => mockScorebookRepository.currentScorebookData).thenReturn(const ScorebookData());
        when(() => mockScorebookRepository.scorebookDataStream).thenAnswer(
          (_) => Stream.value(const ScorebookData()),
        );
        // The state is stubbed in each test.
        // when(() => mockGameEntryBloc.state).thenReturn(const GameEntryState());
      });

      testWidgets(
        'should add an event when the slider is incremented.',
        (WidgetTester tester) async {
          const testEdgeSize = 3;

          when(() => mockGameEntryBloc.state).thenReturn(
            const GameEntryState(), // edgeSize: testEdgeSize | Default: 3
          );

          await tester.pumpWidget(wrappedWidget);

          final sliderFinder = find.byKey(const Key(AppConstants.boardSizeSliderKey));
          expect(sliderFinder, findsOneWidget);

          /// Initial Slider Value
          /// 3x3 = 0, 4x4 = 1, 5x5 = 2
          final slider = tester.widget(sliderFinder) as Slider;
          expect(slider.value, testEdgeSize - AppConstants.boardSizesOffset);

          /// Small Drag
          await tester.drag(sliderFinder, const Offset(50, 0));
          await tester.pumpAndSettle();
          verify(() => mockGameEntryBloc.add(any(that: isA<GameEntryEdgeSizeEvent>()))).called(1);

          /// Large Drag
          await tester.drag(sliderFinder, const Offset(180, 0));
          await tester.pumpAndSettle();
          verify(() => mockGameEntryBloc.add(any(that: isA<GameEntryEdgeSizeEvent>()))).called(1);
        },
      );

      testWidgets(
        'should add an event when the slider is decremented.',
        (WidgetTester tester) async {
          const testEdgeSize = 5;

          when(() => mockGameEntryBloc.state).thenReturn(
            const GameEntryState(edgeSize: testEdgeSize),
          );

          await tester.pumpWidget(wrappedWidget);

          final sliderFinder = find.byKey(const Key(AppConstants.boardSizeSliderKey));
          expect(sliderFinder, findsOneWidget);

          /// Initial Slider Value
          /// 3x3 = 0, 4x4 = 1, 5x5 = 2
          final slider = tester.widget(sliderFinder) as Slider;
          expect(slider.value, testEdgeSize - AppConstants.boardSizesOffset);

          /// Small Drag
          await tester.drag(sliderFinder, const Offset(-50, 0));
          await tester.pumpAndSettle();
          verify(() => mockGameEntryBloc.add(any(that: isA<GameEntryEdgeSizeEvent>()))).called(1);

          /// Large Drag
          await tester.drag(sliderFinder, const Offset(-180, 0));
          await tester.pumpAndSettle();
          verify(() => mockGameEntryBloc.add(any(that: isA<GameEntryEdgeSizeEvent>()))).called(1);
        },
      );
    });
  });
}
