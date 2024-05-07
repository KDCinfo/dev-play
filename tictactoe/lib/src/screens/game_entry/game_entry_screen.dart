import 'package:dev_play_tictactoe/src/data/models/models.dart';
import 'package:dev_play_tictactoe/src/screens/game_entry/game_entry.dart';
import 'package:dev_play_tictactoe/src/screens/game_widgets/game_widgets.dart';

import 'package:flutter/material.dart';

/// The `OrientationScreenGameEntry()` class
/// that is provided as the `orientationScreen` parameter
/// injects both the [[Portrait]] and [[Landscape]] classes below.
///
class GameEntryScreen extends StatelessWidget {
  const GameEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: GameOrientationLayout(
          orientationScreen: OrientationScreenGameEntry(),
        ),
      ),
    );
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
          SizedBox(height: 10),
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
