import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[OrientationScreenWidget] tests', () {
    group('[OrientationScreenGameEntry] screens', () {
      test('[portrait] should return [GameEntryLayoutPortrait]', () {
        final gameEntry = OrientationScreenGameEntry();
        final portraitWidget = gameEntry.portrait;
        expect(portraitWidget, isA<GameEntryLayoutPortrait>());
      });

      test('[landscape] should return [GameEntryLayoutLandscape]', () {
        final gameEntry = OrientationScreenGameEntry();
        final landscapeWidget = gameEntry.landscape;
        expect(landscapeWidget, isA<GameEntryLayoutLandscape>());
      });
    });

    group('[OrientationScreenGameBoard] screens', () {
      test('[portrait] should return [GameBoardLayoutPortrait]', () {
        final gameBoard = OrientationScreenGameBoard();
        final portraitWidget = gameBoard.portrait;
        expect(portraitWidget, isA<GameBoardLayoutPortrait>());
      });

      test('[landscape] should return [GameBoardLayoutLandscape]', () {
        final gameBoard = OrientationScreenGameBoard();
        final landscapeWidget = gameBoard.landscape;
        expect(landscapeWidget, isA<GameBoardLayoutLandscape>());
      });
    });
  });
}
