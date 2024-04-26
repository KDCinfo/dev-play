abstract class AppConstants {
  /// App Title
  static const appTitle = 'Tic Tac Tuple';
  static const appTitleKey = 'ticTacTupleKey';

  /// Player Names List
  static const playerListMax = 4;
  static String playerLabel(int playerNum) => 'Player $playerNum Name:';

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
}
