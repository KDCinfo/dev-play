import 'package:dev_play_tictactoe/src/data/models/player_data.dart';

import 'package:flutter/material.dart';

typedef AppReturnObjDef = Map<String, List<dynamic>>;
typedef PlayerListMapsByIdDef = List<Map<int, PlayerData>>;

abstract class AppConstants {
  /// Standard App Config Values
  static const defaultEdgeSize = 3;

  /// App Title
  static const appTitle = 'Tic Tac Tuple';
  static const appTitleKey = 'ticTacTupleKey';

  /// Player Names List
  static const playerListMax = 4;
  static String playerLabel(int playerNum) => 'Player $playerNum Name:';
  static const playerNameHintText = 'Enter name';
  static const playerListHintText = 'Previous';
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
  static const boardSizeLabel = 'Board Size';
  static const boardSizeLabelKey = 'BoardSizeKey';
  static const boardSizeSliderKey = 'BoardSizeSliderKey';
  static const boardSizes = ['3x3', '4x4', '5x5'];
  // Offset: 3x3 => [3] is the base edgeSize ==> [0] is the min slider value: [3] - Offset = [0]
  static const boardSizesOffset = 3;
  static String sliderLabelKey(int labelIndex) => 'SliderLabelKey$labelIndex';

  /// Buttons
  static const buttonPlayText = "Let's Play!";
  static const buttonPlayKey = 'LetsPlayButtonKey';
  static const buttonReset = 'Reset';
  static const buttonResetKey = 'ResetButtonKey';
  static const buttonReturnHome = 'Return to Home';
  static const buttonReturnHomeKey = 'ReturnToHomeKey';
  static const buttonReturnHomeMsg = '(game is saved)';

  /// Storage Keys
  static const storageKeyScorebook = 'scorebookData';
}

enum GameStatusEnum implements Comparable<GameStatusEnum> {
  inProgress(statusStr: 'In Progress'),
  complete(statusStr: 'Complete');

  // final String inProgress: 'In Progress';
  // final String complete: 'Complete';
  const GameStatusEnum({
    required this.statusStr,
  });

  final String statusStr;

  @override
  int compareTo(GameStatusEnum other) => statusStr.length - other.statusStr.length;
}

enum PlayerTypeEnum {
  human,
  bot,
}
