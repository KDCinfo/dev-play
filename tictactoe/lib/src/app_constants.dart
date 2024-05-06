import 'package:flutter/material.dart';

abstract class AppConstants {
  /// App Title
  static const appTitle = 'Tic Tac Tuple';
  static const appTitleKey = 'ticTacTupleKey';

  /// Player Names List
  static const playerListMax = 4;
  static String playerLabel(int playerNum) => 'Player $playerNum Name:';
  static const hintText = 'Enter name';
  static const markerFontSize = 24.0;
  static const markerSize = 32.0;
  static Map<String, Icon> markerList = {
    '?': const Icon(Icons.list),
    'x': const Icon(Icons.close),
    'o': const Icon(Icons.mood),
    '+': const Icon(Icons.favorite),
    '*': const Icon(Icons.star_border),
  };
  static const nameListFontSize = 24.0;
  static const nameListSize = 32.0;

  /// Board Size
  static const boardSizeLabel = "Board Size";
  static const boardSizeLabelKey = "BoardSizeKey";
  static const boardSizeSliderKey = "BoardSizeSliderKey";
  static const boardSizes = ["3x3", "4x4", "5x5"];
  static String sliderLabelKey(int labelIndex) => 'SliderLabelKey$labelIndex';

  /// Buttons
  static const buttonPlayText = "Let's Play!";
  static const buttonPlayKey = "LetsPlayButtonKey";
  static const buttonReset = 'Reset';
  static const buttonResetKey = 'ResetButtonKey';
  static const buttonReturnHome = 'Return to Home';
  static const buttonReturnHomeKey = 'ReturnToHomeKey';
  static const buttonReturnHomeMsg = '(game is saved)';
}
