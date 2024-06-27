import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/app_main/pre_pop_scope.dart';
import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';
import 'package:dev_play_tictactuple/src/screens/screens.dart';

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
                body: BlocListener<GamePlayBloc, GamePlayState>(
                  listenWhen: (previous, current) =>
                      previous.currentGame.gameBoardData.plays.length !=
                          current.currentGame.gameBoardData.plays.length &&
                      current.currentGame.gameStatus == const GameStatusInProgress() &&
                      current.currentGame.currentPlayerIndex == 1 &&
                      current.currentGame.players[current.currentGame.currentPlayerIndex]
                              .playerType ==
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

class GameBoardLayoutPortrait extends StatelessWidget {
  const GameBoardLayoutPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    ///
    /// This `Column` has a fixed size from within the `GameOrientationLayout()`.
    ///
    /// log('GameBoardLayoutPortrait: constraints: $constraints');
    /// [log] GameBoardLayoutPortrait: constraints: BoxConstraints(0.0<=w<=399.4, 0.0<=h<=806.3)
    return const Column(
      children: [
        GameTitleRow(),
        SizedBox(height: 10),
        Expanded(
          flex: 2,
          child: GameBoardPanel(),
        ), // edgeSize: 5
        SizedBox(height: 20),
        GameBoardPlayerPanel(),
        SizedBox(height: 20),
        GameBoardButtonPanel(),
        Spacer(),
      ],
    );
  }
}

class GameBoardLayoutLandscape extends StatelessWidget {
  const GameBoardLayoutLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GameBoardPanel(),
            // edgeSize: 5
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GameTitleRow(),
                  SizedBox(height: 20),
                  GameBoardPlayerPanel(),
                  SizedBox(height: 20),
                  GameBoardButtonPanel(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
