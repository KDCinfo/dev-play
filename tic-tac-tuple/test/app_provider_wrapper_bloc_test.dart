import 'package:dev_play_tictactuple/src/app_provider_wrapper_bloc.dart';
import 'package:dev_play_tictactuple/src/data/data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppProviderWrapperBloc', () {
    testWidgets('should successfully find a Container widget.', (WidgetTester tester) async {
      // Arrange
      final appProviderWrapperBloc = AppProviderWrapperBloc<AppBaseRepository>(
        child: Container(),
      );

      // Act
      await tester.pumpWidget(appProviderWrapperBloc);

      // Assert
      final gameEntryBloc = tester.widget(find.byType(Container));
      expect(gameEntryBloc, isA<Container>());
    });

    testWidgets('should find the [GameEntryBloc BlocProvider].', (WidgetTester tester) async {
      // Arrange
      final appProviderWrapperBloc = AppProviderWrapperBloc<AppBaseRepository>(
        child: Container(),
      );

      // Act
      await tester.pumpWidget(appProviderWrapperBloc);

      // Assert
      final blocProvider = find.ancestor(
        of: find.byType(Container),
        matching: find.byType(BlocProvider<GameEntryBloc>),
      );
      expect(blocProvider, findsOneWidget);
    });
  });
}
