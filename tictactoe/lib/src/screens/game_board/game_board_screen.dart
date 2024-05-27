import 'package:dev_play_tictactoe/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactoe/src/data/models/models.dart';
import 'package:dev_play_tictactoe/src/pre_pop_scope.dart';
import 'package:dev_play_tictactoe/src/screens/screens.dart';

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
    return PrePopScope(
      currentRoutePath: '/play',
      child: Builder(
        builder: (context) {
          return const SafeArea(
            child: Scaffold(
              body: GameOrientationLayout(
                orientationScreen: OrientationScreenGameBoard(),
              ),
            ),
          );
        },
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
    return Column(
      children: [
        const GameTitleRow(),
        const SizedBox(height: 10),
        Expanded(
          flex: 2,
          child: BlocBuilder<GamePlayBloc, GamePlayState>(
            builder: (context, state) {
              return GameBoardPanel(
                edgeSize: state.currentGame.gameBoardData.edgeSize,
              );
            },
          ),
        ), // edgeSize: 5
        const SizedBox(height: 20),
        const GameBoardPlayerPanel(),
        const SizedBox(height: 20),
        const GameBoardButtonPanel(),
        const Spacer(),
      ],
    );
  }
}

class GameBoardLayoutLandscape extends StatelessWidget {
  const GameBoardLayoutLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: BlocBuilder<GamePlayBloc, GamePlayState>(
              builder: (context, state) {
                return GameBoardPanel(
                  edgeSize: state.currentGame.gameBoardData.edgeSize,
                );
              },
            ),
            // edgeSize: 5
          ),
          const Expanded(
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
