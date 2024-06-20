import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';
import 'package:dev_play_tictactuple/src/pre_pop_scope.dart';
import 'package:dev_play_tictactuple/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The `OrientationScreenGameEntry()` class
/// that is provided as the `orientationScreen` parameter
/// injects both the [[Portrait]] and [[Landscape]] classes below.
///
class GameEntryScreen extends StatelessWidget {
  const GameEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrePopScope(
      currentRoutePath: '/',
      child: Builder(
        builder: (context) {
          return SafeArea(
            child: Scaffold(
              body: MultiBlocListener(
                listeners: [
                  BlocListener<GamePlayBloc, GamePlayState>(
                    listenWhen: (previous, current) =>
                        previous.currentGame.gameStatus != current.currentGame.gameStatus &&
                        current.currentGame.gameStatus == const GameStatusComplete(),
                    listener: (context, state) async {
                      await winnerWinnerListener(context);
                    },
                  ),
                  BlocListener<GamePlayBloc, GamePlayState>(
                    listenWhen: (previous, current) =>
                        previous.currentGame.gameId != current.currentGame.gameId,
                    listener: (context, state) async {
                      if (state.currentGame.gameId > -1) {
                        await Navigator.pushNamed(context, '/play');
                      } else {
                        // Pop to root.
                        Navigator.popUntil(context, (route) => route.isFirst);
                      }
                    },
                  ),
                ],
                child: const GameOrientationLayout(
                  orientationScreen: OrientationScreenGameEntry(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> winnerWinnerListener(BuildContext context) async {
    //
    // @TODO: Play a 'great game' popup animation.
    //        For now, we'll just show a dialog screen with a message.

    // Check if there was a winner in the last game.
    // If so, use the winner's name in the end game status message.
    //
    // allGames.entries: { gameId, gameData }.value => gameData
    final lastGame = context.read<GamePlayBloc>().currentScorebookData.allGames.entries.last.value;

    final winnerId = lastGame.winnerId;
    final lastPlayerWasWinner = winnerId != -1;
    final lastPlayerName = !lastPlayerWasWinner
        ? ''
        : lastGame.players
            .firstWhere(
              (PlayerData player) => player.playerId == winnerId,
              orElse: () => const PlayerData(playerNum: -1),
            )
            .playerName;

    final endGameStatusMessage =
        !lastPlayerWasWinner ? 'Well played!!' : 'Congratulations $lastPlayerName!!';

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.bottomCenter,
          title: const Text(AppConstants.gameOverTitle),
          content: Text(endGameStatusMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(AppConstants.buttonStartNewGame),
            ),
          ],
        );
      },
    ).then<void>((_) {
      context.read<GamePlayBloc>().add(const GamePlayResetGameEvent());
    });
  }
}

class GameEntryLayoutPortrait extends StatelessWidget {
  const GameEntryLayoutPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    /// This `Column` has a fixed size from within the `GameOrientationLayout()`.
    return const SingleChildScrollView(
      child: Column(
        children: [
          GameTitleRow(),
          SizedBox(height: 35),
          GameEntryNameList(),
          SizedBox(height: 20),
          GameEntryBoardSizeRow(),
          SizedBox(height: 20),
          GameEntryButtonsRow(),
        ],
      ),
    );
  }
}

class GameEntryLayoutLandscape extends StatelessWidget {
  const GameEntryLayoutLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: GameEntryNameList(),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                GameTitleRow(),
                SizedBox(height: 10),
                GameEntryBoardSizeRow(),
                SizedBox(height: 20),
                Expanded(child: GameEntryButtonsRow()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
