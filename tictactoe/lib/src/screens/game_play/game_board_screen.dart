import 'package:dev_play_tictactoe/src/screens/game_play/game_play.dart';
import 'package:dev_play_tictactoe/src/screens/game_widgets/game_widgets.dart';

import 'package:flutter/material.dart';

/// The `OrientationScreenGameBoard()` class
/// that is provided as the `orientationScreen` parameter
/// injects both the [[Portrait]] and [[Landscape]] classes below.
///
class GameBoardScreen extends StatelessWidget {
  const GameBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GameOrientationLayout(
          orientationScreen: OrientationScreenGameBoard(),
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
        Expanded(flex: 2, child: GameBoardPanel()), // edgeSize: 5
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
            child: GameBoardPanel(), // edgeSize: 5
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
