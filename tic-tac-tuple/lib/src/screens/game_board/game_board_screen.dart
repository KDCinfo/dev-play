// ignore_for_file: avoid-shadowing

import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/app_main/pre_pop_scope.dart';
import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';
import 'package:dev_play_tictactuple/src/screens/game_widgets/game_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The `OrientationScreenGameBoard()` class
/// that is provided as the `orientationScreen` parameter
/// injects both the [[Portrait]] and [[Landscape]] classes below.
///
class GameBoardScreen extends StatelessWidget {
  const GameBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WaitForBotBloc(),
      child: PrePopScope(
        currentRoutePath: '/play',
        child: Builder(
          builder: (context) {
            return SafeArea(
              child: Scaffold(
                backgroundColor: AppConstants.primaryBackgroundColor,
                body: BlocListener<GamePlayBloc, GamePlayState>(
                  listenWhen: (previous, current) =>
                      previous.currentGame.gameBoardData.plays.length !=
                          current.currentGame.gameBoardData.plays.length &&
                      current.currentGame.gameStatus == const GameStatusInProgress() &&
                      current.currentGame.currentPlayerIndex == 1 &&
                      current.currentGame.players
                              .elementAtOrNull(current.currentGame.currentPlayerIndex)
                              ?.playerType ==
                          const PlayerTypeBot(),
                  listener: (context, state) async {
                    // Show a waiting widget.
                    context.read<WaitForBotBloc>().add(
                          const WaitForBotOnEvent(),
                        );

                    // Let the bot do its thing...
                    await Future<void>.delayed(
                      const Duration(milliseconds: AppConstants.botDelay),
                      () => context.read<GamePlayBloc>().add(const GamePlayBotMoveRequestedEvent()),
                    ).then<void>((_) {
                      // Stop showing the waiting widget.
                      context.read<WaitForBotBloc>().add(
                            const WaitForBotOffEvent(),
                          );
                    });
                  },
                  child: const GameOrientationLayout(
                    orientationScreen: OrientationScreenGameBoard(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
