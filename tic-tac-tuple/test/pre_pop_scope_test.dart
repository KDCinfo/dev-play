import 'package:dev_play_tictactuple/src/app_main/pre_pop_scope.dart';
import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'helpers/helpers.dart';

void main() {
  group('[PrePopScope] Testing:', () {
    late Widget Function(String routePath) widgetToTest;
    late Widget wrappedWidgetRoot;
    late Widget wrappedWidgetPlay;
    late GamePlayBloc mockGamePlayBloc;
    late NavigatorObserver mockObserver;

    setUpAll(() {
      // Create a dummy instance of `Route<dynamic>` to satisfy the `Navigator`.
      registerFallbackValue(FakeRoute());
    });

    setUp(() async {
      mockObserver = MockNavigatorObserver();
      mockGamePlayBloc = MockGamePlayBloc();

      widgetToTest = (String routePath) => Builder(
            builder: (_) {
              return PrePopScope(
                currentRoutePath: routePath, // ['/', '/play']
                child: SafeArea(
                  child: Scaffold(
                    body: Builder(
                      builder: (context) {
                        return Center(
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.maybePop(context);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
      wrappedWidgetRoot = PumpApp.materialAppPopScopeTest(
        widgetToTest('/'),
        mockObserver,
        mockGamePlayBloc,
      );
      wrappedWidgetPlay = PumpApp.materialAppPopScopeTest(
        widgetToTest('/play'),
        mockObserver,
        mockGamePlayBloc,
      );

      when(() => mockGamePlayBloc.state).thenReturn(const GamePlayState());
    });

    group('renderer', () {
      testWidgets('should build without error.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidgetRoot);
        final widgetFinderScreen = find.byType(PrePopScope);
        expect(widgetFinderScreen, findsOneWidget);
      });

      testWidgets('should find a PopScope.', (WidgetTester tester) async {
        await tester.pumpWidget(wrappedWidgetRoot);
        final widgetFinderScreen = find.byType(PopScope);
        expect(widgetFinderScreen, findsOneWidget);
      });

      testWidgets(
        'should not pop when currentRoutePath is in pathsToNotPop.',
        (WidgetTester tester) async {
          await tester.pumpWidget(wrappedWidgetRoot);

          await tester.tap(find.byType(IconButton));
          await tester.pump();

          // Assert specific navigation did not occur.
          verifyNever(() => mockObserver.didPop(captureAny(), any()));
        },
      );

      testWidgets(
        'should pop once when currentRoutePath is not in pathsToNotPop.',
        (WidgetTester tester) async {
          await tester.pumpWidget(wrappedWidgetPlay);

          await tester.tap(find.byType(IconButton));
          await tester.pump();

          verify(() => mockObserver.navigator).called(1);
          verify(() => mockObserver.didPush(any(), any())).called(1);
          verify(() => mockObserver.didPop(any(), any())).called(1);
        },
      );
    });
  });
}
