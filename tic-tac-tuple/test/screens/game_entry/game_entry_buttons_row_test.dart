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

    //
    // [ GameEntry Buttons ]
    //

    group('GameEntry Buttons', () {
      setUp(() {
        mockScorebookRepository = MockScorebookRepository();
        mockGameEntryBloc = MockGameEntryBloc();
        mockGamePlayBloc = MockGamePlayBloc();

        widgetToTest = const GameEntryButtonsRow();
        wrappedWidget = PumpApp.providerWrappedMaterialApp(
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
          when(() => mockGameEntryBloc.state).thenReturn(
            GameEntryState(players: [...playerList]),
          );

          await tester.pumpWidget(wrappedWidget);

          final widgetFinderButtonTextKey = find.byKey(const ValueKey(AppConstants.buttonPlayKey));
          final textParentButtonFinder = find.ancestor(
            of: widgetFinderButtonTextKey,
            matching: find.byType(ElevatedButton),
          );
          expect(textParentButtonFinder, findsOneWidget);
          final buttonWidget = tester.widget(textParentButtonFinder) as ElevatedButton;

          await tester.tap(find.byWidget(buttonWidget));

          // MockGameEntryBloc.stream, MockGameEntryBloc.state
          verify(() => mockGameEntryBloc.add(const GameEntryStartGameEvent())).called(1);
          verifyNever(() => mockGameEntryBloc.add(const GameEntryResetGameEvent()));
        },
      );

      testWidgets(
        '[GameEntry Buttons] has a reset button.',
        (WidgetTester tester) async {
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
        },
        // See @TODO: at:
        // > lib.src.screens.game_entry.game_entry_buttons_row.GameEntryButtonsRow.build
        skip: true,
      );

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
        // See @TODO: at:
        // > lib.src.screens.game_entry.game_entry_buttons_row.GameEntryButtonsRow.build
        skip: true,
      );
    });

    //
    // [ Unit Tests ]
    //

    group('[Unit Tests]', () {
      group('[validateFields]', () {
        // - Edge size must be between 3-5.
        // - The game must have between 2-4 players.
        // - All players must have a name.
        // - No two player names can be the same.
        test('returns empty list when all fields are valid.', () {
          const gameEntryButtonsRow = GameEntryButtonsRow();
          final messageList = gameEntryButtonsRow.validateFields(
            statePlayers: [...playerList],
            stateEdgeSize: 3,
          );
          expect(messageList, isEmpty);
        });
        test('returns list with 1 item when edgeSize is too small.', () {
          const gameEntryButtonsRow = GameEntryButtonsRow();
          final messageList = gameEntryButtonsRow.validateFields(
            statePlayers: [...playerList],
            stateEdgeSize: 2,
          );
          expect(messageList, isNotEmpty);
          expect(messageList, hasLength(1));
          expect(messageList, contains(AppConstants.boardSizeMinMsg));
        });
        test('returns list with 1 item when edgeSize is too large.', () {
          const gameEntryButtonsRow = GameEntryButtonsRow();
          final messageList = gameEntryButtonsRow.validateFields(
            statePlayers: [...playerList],
            stateEdgeSize: 10,
          );
          expect(messageList, isNotEmpty);
          expect(messageList, hasLength(1));
          expect(messageList, contains(AppConstants.boardSizeMaxMsg));
        });
        test('returns list with 1 item when playerList is too small.', () {
          const gameEntryButtonsRow = GameEntryButtonsRow();
          final messageList = gameEntryButtonsRow.validateFields(
            statePlayers: [...playerListSingle],
            stateEdgeSize: 3,
          );
          expect(messageList, isNotEmpty);
          expect(messageList, hasLength(1));
          expect(messageList, contains(AppConstants.playerListMinMsg));
        });
        test('returns list with 1 item when playerList is too large.', () {
          final playerAtIndex = playerListPlayer1a.elementAtOrNull(0);
          if (playerAtIndex != null) {
            const gameEntryButtonsRow = GameEntryButtonsRow();
            final messageList = gameEntryButtonsRow.validateFields(
              statePlayers: [
                ...playerListAddFourth,
                // playerListPlayer1a[0],
                playerAtIndex,
              ],
              stateEdgeSize: 3,
            );
            expect(messageList, isNotEmpty);
            expect(messageList, hasLength(1));
            expect(messageList, contains(AppConstants.playerListMaxMsg));
          } else {
            fail('too large - playerAtIndex is null.');
          }
        });
        test('returns list with 1 item when playerList has empty name.', () {
          final playerListEmptyName = List<PlayerData>.of(playerList);
          final playerAtIndex = playerListEmptyName.elementAtOrNull(0);
          if (playerAtIndex != null) {
            playerListEmptyName[0] = playerAtIndex.copyWith(playerName: '');
            const gameEntryButtonsRow = GameEntryButtonsRow();
            final messageList = gameEntryButtonsRow.validateFields(
              statePlayers: playerListEmptyName,
              stateEdgeSize: 3,
            );
            expect(messageList, isNotEmpty);
            expect(messageList, hasLength(1));
            expect(messageList, contains(AppConstants.emptyNameMsg));
          } else {
            fail('empty name - playerAtIndex is null.');
          }
        });
        test('returns list with 1 item when playerList has duplicate name.', () {
          final playerListDuplicateName = List<PlayerData>.of(playerList);
          final playerAtIndex = playerListDuplicateName.elementAtOrNull(0);
          if (playerAtIndex != null) {
            playerListDuplicateName[1] = playerAtIndex;
            const gameEntryButtonsRow = GameEntryButtonsRow();
            final messageList = gameEntryButtonsRow.validateFields(
              statePlayers: playerListDuplicateName,
              stateEdgeSize: 3,
            );
            expect(messageList, isNotEmpty);
            expect(messageList, hasLength(1));
            expect(messageList, contains(AppConstants.uniqueNameMsg));
          } else {
            fail('duplicate name - playerAtIndex is null.');
          }
        });
        test(
          'returns list with 2 items with 4 players '
          'having an empty player name and 2 duplicate names.',
          () {
            final playerListDuplicateName = List<PlayerData>.of(playerListAddFourth);
            final playerAtIndex = playerListDuplicateName.elementAtOrNull(0);
            if (playerAtIndex != null) {
              // Duplicate player check.
              playerListDuplicateName[1] = playerAtIndex;
              // Empty name check.
              playerListDuplicateName[2] = playerAtIndex.copyWith(playerName: '');

              const gameEntryButtonsRow = GameEntryButtonsRow();
              final messageList = gameEntryButtonsRow.validateFields(
                statePlayers: playerListDuplicateName,
                stateEdgeSize: 3,
              );
              expect(messageList, isNotEmpty);
              expect(messageList, hasLength(2));
              expect(messageList, contains(AppConstants.uniqueNameMsg));
              expect(messageList, contains(AppConstants.emptyNameMsg));
            } else {
              fail('2 duplicate names - playerAtIndex is null.');
            }
          },
        );
      });
    });
  });
}
