import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactoe/src/data/models/models.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameBoardButtonPanel extends StatelessWidget {
  const GameBoardButtonPanel({super.key});

  @override
  Widget build(BuildContext context) {
    const buttonReturn = AppConstants.buttonReturnHome;
    const buttonReturnKey = Key(AppConstants.buttonReturnHomeKey);
    const buttonReturnMsg = AppConstants.buttonReturnHomeMsg;

    const buttonFontSize = 18.0;
    const msgFontSize = 14.0;
    const lightBlack = Colors.black87;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            border: const Border(bottom: BorderSide(color: lightBlack)),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
            ),
            onPressed: () {
              // Navigator.pop(context);
              endGame(context);
            },
            child: const Text(
              buttonReturn,
              key: buttonReturnKey,
              softWrap: false,
              style: TextStyle(
                fontSize: buttonFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text(
            buttonReturnMsg,
            style: TextStyle(fontSize: msgFontSize, color: lightBlack),
          ),
        ),
      ],
    );
  }

  void endGame(BuildContext context) {
    final currentGameData = context.read<GamePlayBloc>().state.currentGame;
    final resetGameData = GameData.resetGame(currentGameData);
    context.read<GamePlayBloc>().add(
          GamePlayEndGameEvent(
            gameData: resetGameData,
          ),
        );
  }
}
