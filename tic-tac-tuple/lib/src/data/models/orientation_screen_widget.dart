import 'package:dev_play_tictactuple/src/screens/screens.dart';

import 'package:flutter/material.dart';

abstract interface class OrientationScreenWidget {
  Widget get portrait;
  Widget get landscape;
}

class OrientationScreenGameEntry implements OrientationScreenWidget {
  const OrientationScreenGameEntry();

  @override
  Widget get portrait => const GameEntryLayoutPortrait();

  @override
  Widget get landscape => const GameEntryLayoutLandscape();
}

class OrientationScreenGameBoard implements OrientationScreenWidget {
  const OrientationScreenGameBoard();

  @override
  Widget get portrait => const GameBoardLayoutPortrait();

  @override
  Widget get landscape => const GameBoardLayoutLandscape();
}
