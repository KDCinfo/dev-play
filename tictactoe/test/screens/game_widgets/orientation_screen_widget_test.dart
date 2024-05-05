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

    group('[OrientationScreenGamePlay] screens', () {
      test('[portrait] should return [GameBoardScreenPortrait]', () {
        final gamePlay = OrientationScreenGamePlay();
        final portraitWidget = gamePlay.portrait;
        expect(portraitWidget, isA<GameBoardScreenPortrait>());
      });

      test('[landscape] should return [GameBoardScreenLandscape]', () {
        final gamePlay = OrientationScreenGamePlay();
        final landscapeWidget = gamePlay.landscape;
        expect(landscapeWidget, isA<GameBoardScreenLandscape>());
      });
    });
  });
}
