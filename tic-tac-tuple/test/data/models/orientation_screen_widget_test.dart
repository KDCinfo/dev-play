import 'package:dev_play_tictactuple/src/data/models/models.dart';
import 'package:dev_play_tictactuple/src/screens/screens.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[OrientationScreenWidget] tests', () {
    group('[OrientationScreenGameEntry] screens', () {
      test('[portrait] should return [GameEntryLayoutPortrait]', () {
        const gameEntry = OrientationScreenGameEntry();
        final portraitWidget = gameEntry.portrait;
        expect(portraitWidget, isA<GameEntryLayoutPortrait>());
      });

      test('[landscape] should return [GameEntryLayoutLandscape]', () {
        const gameEntry = OrientationScreenGameEntry();
        final landscapeWidget = gameEntry.landscape;
        expect(landscapeWidget, isA<GameEntryLayoutLandscape>());
      });
    });

    group('[OrientationScreenGameBoard] screens', () {
      test('[portrait] should return [GameBoardLayoutPortrait]', () {
        const gameBoard = OrientationScreenGameBoard();
        final portraitWidget = gameBoard.portrait;
        expect(portraitWidget, isA<GameBoardLayoutPortrait>());
      });

      test('[landscape] should return [GameBoardLayoutLandscape]', () {
        const gameBoard = OrientationScreenGameBoard();
        final landscapeWidget = gameBoard.landscape;
        expect(landscapeWidget, isA<GameBoardLayoutLandscape>());
      });
    });
  });
}
