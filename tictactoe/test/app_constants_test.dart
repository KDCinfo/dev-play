import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/data/models/models.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('[AppConstants] Testing:', () {
    group('checks', () {
      test('defaultEdgeSize should be 3.', () {
        expect(AppConstants.defaultEdgeSize, 3);
      });

      test('defaultEdgeSizeMin should be 3.', () {
        expect(AppConstants.defaultEdgeSizeMin, 3);
      });

      test('defaultEdgeSizeMax should be 5.', () {
        expect(AppConstants.defaultEdgeSizeMax, 5);
      });

      test('appTitle should be "Tic Tac Tuple".', () {
        expect(AppConstants.appTitle, 'Tic Tac Tuple');
      });

      test('appTitleKey should be "ticTacTupleKey".', () {
        expect(AppConstants.appTitleKey, 'ticTacTupleKey');
      });

      test('playerListMin should be 2.', () {
        expect(AppConstants.playerListMin, 2);
      });

      test('playerListMax should be 4.', () {
        expect(AppConstants.playerListMax, 4);
      });

      test('playerLabel should return the correct label for player 1.', () {
        expect(AppConstants.playerLabel(1), 'Player 1 Name:');
      });

      test('playerNameHintText should be "Enter name".', () {
        expect(AppConstants.playerNameHintText, 'Enter name');
      });

      test('playerListHintText should be "Previous".', () {
        expect(AppConstants.playerListHintText, 'Previous');
      });

      test('playerBotName should be "TicTacBot".', () {
        expect(AppConstants.playerBotName, 'TicTacBot');
      });

      test('playerListResetMsg should be "Resetting...".', () {
        expect(AppConstants.playerListResetMsg, 'Resetting...');
      });

      test('nameListFontSize should be 24.0.', () {
        expect(AppConstants.nameListFontSize, 24.0);
      });

      test('nameListSize should be 32.0.', () {
        expect(AppConstants.nameListSize, 32.0);
      });

      test('playerBot should be an instance of PlayerData.', () {
        expect(AppConstants.playerBot, isA<PlayerData>());
      });

      test('playerListDefault should contain 2 players.', () {
        expect(AppConstants.playerListDefault.length, 2);
      });

      test('boardSizeLabel should be "Board Size".', () {
        expect(AppConstants.boardSizeLabel, 'Board Size');
      });

      test('boardSizeLabelKey should be "BoardSizeKey".', () {
        expect(AppConstants.boardSizeLabelKey, 'BoardSizeKey');
      });

      test('boardSizeSliderKey should be "BoardSizeSliderKey".', () {
        expect(AppConstants.boardSizeSliderKey, 'BoardSizeSliderKey');
      });

      test('boardSizes should contain ["3x3", "4x4", "5x5"].', () {
        expect(AppConstants.boardSizes, ['3x3', '4x4', '5x5']);
      });

      test('boardSizesOffset should be 3.', () {
        expect(AppConstants.boardSizesOffset, 3);
      });

      test('sliderLabelKey should return the correct key for label index 0.', () {
        expect(AppConstants.sliderLabelKey(0), 'SliderLabelKey0');
      });

      test('buttonPlayText should be "Let\'s Play!".', () {
        expect(AppConstants.buttonPlayText, "Let's Play!");
      });

      test('buttonPlayKey should be "LetsPlayButtonKey".', () {
        expect(AppConstants.buttonPlayKey, 'LetsPlayButtonKey');
      });

      test('buttonReset should be "Reset".', () {
        expect(AppConstants.buttonReset, 'Reset');
      });

      test('buttonResetKey should be "ResetButtonKey".', () {
        expect(AppConstants.buttonResetKey, 'ResetButtonKey');
      });

      test('buttonReturnHome should be "Return to Home".', () {
        expect(AppConstants.buttonReturnHome, 'Return to Home');
      });

      test('buttonReturnHomeKey should be "ReturnToHomeKey".', () {
        expect(AppConstants.buttonReturnHomeKey, 'ReturnToHomeKey');
      });

      test('buttonReturnHomeMsg should be "(game is saved)".', () {
        expect(AppConstants.buttonReturnHomeMsg, '(game is saved)');
      });

      test('storageKeyScorebook should be "scorebookData".', () {
        expect(AppConstants.storageKeyScorebook, 'scorebookData');
      });
    });

    group('[GameStatusEnum]', () {
      test('inProgress statusStr should be "In Progress".', () {
        expect(GameStatusEnum.inProgress.statusStr, 'In Progress');
      });

      test('complete statusStr should be "Complete".', () {
        expect(GameStatusEnum.complete.statusStr, 'Complete');
      });
    });

    group('[PlayerTypeEnum]', () {
      test('human should be an instance of PlayerTypeEnum.', () {
        expect(PlayerTypeEnum.human, isA<PlayerTypeEnum>());
      });

      test('bot should be an instance of PlayerTypeEnum.', () {
        expect(PlayerTypeEnum.bot, isA<PlayerTypeEnum>());
      });
    });
  });
}
