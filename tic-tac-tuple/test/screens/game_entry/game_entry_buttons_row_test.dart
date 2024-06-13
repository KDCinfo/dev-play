import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';
import 'package:dev_play_tictactuple/src/data/service_repositories/service_repositories.dart';
import 'package:dev_play_tictactuple/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('GameEntry Testing:', () {
    late Widget widgetToTest;
    late Widget wrappedWidget;

    late ScorebookRepository mockScorebookRepository;
    late GameEntryBloc mockGameEntryBloc;
    late GamePlayBloc mockGamePlayBloc;

    ///
    /// [ GameEntry Buttons ]
    ///

    group('GameEntry Buttons', () {
      setUp(() async {
        mockScorebookRepository = MockScorebookRepository();
        mockGameEntryBloc = MockGameEntryBloc();
        mockGamePlayBloc = MockGamePlayBloc();

        widgetToTest = const GameEntryButtonsRow();
        wrappedWidget = await PumpApp.providerWrappedMaterialApp(
          scorebookRepository: mockScorebookRepository,
          gameEntryBloc: mockGameEntryBloc,
          gamePlayBloc: mockGamePlayBloc,
          child: widgetToTest,
        );

        when(() => mockScorebookRepository.scorebookDataStream)
            .thenAnswer((_) => Stream.value(const ScorebookData()));
        when(() => mockGameEntryBloc.state).thenReturn(const GameEntryState());
        when(() => mockGamePlayBloc.state).thenReturn(const GamePlayState());
      });

      testWidgets('[GameEntry Buttons] renders properly.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);

        final widgetFinderButtons = find.byType(GameEntryButtonsRow);
        expect(widgetFinderButtons, findsNWidgets(1));
      });

      testWidgets('[GameEntry Buttons] has a play button.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);

        final widgetFinderButtonPlay = find.byKey(const ValueKey(AppConstants.buttonPlayKey));
        expect(widgetFinderButtonPlay, findsOneWidget);

        final buttonPlayWidget = tester.widget(widgetFinderButtonPlay) as Text;
        expect(
          buttonPlayWidget,
          isA<Text>().having(
            (t) => t.data,
            'text',
            equals(AppConstants.buttonPlayText),
          ),
        );
      });

      testWidgets(
        '[GameEntry Buttons] play button onPressed calls StartGameEvent.',
        (WidgetTester tester) async {
          when(() => mockGameEntryBloc.state).thenReturn(const GameEntryState());

          await tester.pumpWidget(wrappedWidget);

          final widgetFinderButtonTextKey = find.byKey(const ValueKey(AppConstants.buttonPlayKey));
          final textParentButtonFinder = find.ancestor(
            of: widgetFinderButtonTextKey,
            matching: find.byType(ElevatedButton),
          );
          expect(textParentButtonFinder, findsOneWidget);
          final buttonWidget = tester.widget(textParentButtonFinder) as ElevatedButton;

          await tester.tap(find.byWidget(buttonWidget));

          verify(() => mockGameEntryBloc.add(const GameEntryStartGameEvent())).called(1);
          verifyNever(() => mockGameEntryBloc.add(const GameEntryResetGameEvent()));
        },
      );

      testWidgets('[GameEntry Buttons] has a reset button.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidget);

        final widgetFinderButtonReset = find.byKey(const ValueKey(AppConstants.buttonResetKey));
        expect(widgetFinderButtonReset, findsOneWidget);

        final buttonResetWidget = tester.widget(widgetFinderButtonReset) as Text;
        expect(
          buttonResetWidget,
          isA<Text>().having(
            (t) => t.data,
            'text',
            equals(AppConstants.buttonReset),
          ),
        );
      });

      testWidgets(
        '[GameEntry Buttons] reset button onPressed calls ResetGameEvent.',
        (WidgetTester tester) async {
          when(() => mockGameEntryBloc.state).thenReturn(const GameEntryState());

          await tester.pumpWidget(wrappedWidget);

          final widgetFinderButtonTextKey = find.byKey(const ValueKey(AppConstants.buttonResetKey));
          final textParentButtonFinder = find.ancestor(
            of: widgetFinderButtonTextKey,
            matching: find.byType(TextButton),
          );
          expect(textParentButtonFinder, findsOneWidget);
          final buttonWidget = tester.widget(textParentButtonFinder) as TextButton;

          await tester.tap(find.byWidget(buttonWidget));

          verifyNever(() => mockGameEntryBloc.add(const GameEntryStartGameEvent()));
          verify(() => mockGameEntryBloc.add(const GameEntryResetGameEvent())).called(1);
        },
      );
    });
  });
}
