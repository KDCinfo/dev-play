import 'package:dev_play_tictactuple/src/screens/screens.dart';

import 'package:flutter/material.dart';

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
