import 'package:dev_play_tictactoe/src/screens/game_play/game_play.dart';
import 'package:dev_play_tictactoe/src/screens/game_widgets/game_widgets.dart';

import 'package:flutter/material.dart';

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
  const GameBoardLayoutPortrait({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 30),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GameTitleRow(),
            SizedBox(height: 10),
            Expanded(child: GameBoardPanel()),
            SizedBox(height: 20),
            // GameBoardPlayerPanel(),
            SizedBox(height: 20),
            // GameBoardButtonsRow(),
          ],
        ),
      ),
    );
  }
}

class GameBoardLayoutLandscape extends StatelessWidget {
  const GameBoardLayoutLandscape({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 30),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GameTitleRow(),
            SizedBox(height: 10),
            Expanded(child: GameBoardPanel()),
            SizedBox(height: 20),
            // GameBoardPlayerPanel(),
            SizedBox(height: 20),
            // GameBoardButtonsRow(),
          ],
        ),
      ),
    );
  }
}
