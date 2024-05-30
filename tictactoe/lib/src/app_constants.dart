import 'package:dev_play_tictactuple/src/data/models/models.dart';

typedef AppReturnObjDef = Map<String, List<dynamic>>;
typedef PlayerListMapsByIdDef = List<Map<int, PlayerData>>;

abstract class AppConstants {
  /// Do not allow printing or logging when `inProd: true`.
  static const canPrint = true;

  /// Standard App Config Values
  static const defaultEdgeSize = 3;
  static const defaultEdgeSizeMin = 3;
  static const defaultEdgeSizeMax = 5;

  /// App Title
  static const appTitle = 'Tic Tac Tuple';
  static const appTitleKey = 'ticTacTupleKey';

  /// Player Names List
  static const playerListMin = 2;
  static const playerListMax = 4;
  static String playerLabel(int playerNum) => 'Player $playerNum Name:';
  static const playerNameHintText = 'Enter name';
  static const playerListHintText = 'Previous';
  static const playerBotName = 'TicTacBot';
  static const playerListResetMsg = 'Resetting...';
  static const nameListFontSize = 24.0;
  static const nameListSize = 32.0;
  // - The `GameEntryBloc` state needs 2 initial `PlayerData` players; 1 human, 1 bot.
  // 	When text is added to the bot name, a 3rd player can be added to the playerList.
  static const playerBot = PlayerData(
    playerNum: 2,
    playerName: playerBotName,
    userSymbol: UserSymbolO(),
  );
  static const List<PlayerData> playerListDefault = [
    PlayerData(
      playerNum: 1,
      playerName: 'Player 1',
      userSymbol: UserSymbolX(),
      playerType: PlayerTypeHuman(),
    ),
    playerBot,
  ];

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
  static const buttonStartNewGame = 'Start a New Game';

  /// Storage Keys
  static const storageKeyScorebook = 'scorebookData';

  static void appPrint({
    String? message,
    Object? error,
    StackTrace? stacktrace,
  }) {
    if (!canPrint) {
      if (message != null) {
        // ignore: avoid_print
        print('message: $message');
      }
      if (error != null) {
        // ignore: avoid_print
        print('error: $error');
      }
      if (stacktrace != null) {
        // ignore: avoid_print
        print('stacktrace: $stacktrace');
      }
    }
  }
}

enum GameStatusEnum implements Comparable<GameStatusEnum> {
  entryMode(statusStr: 'Entry Mode'),
  inProgress(statusStr: 'In Progress'),
  complete(statusStr: 'Complete');

  // final String entryMode: 'Entry Mode';
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

enum MatchTupleEnum {
  row,
  column,
  diagonal,
}
