import 'package:dev_play_tictactuple/src/screens/screens.dart';

import 'package:flutter/material.dart';

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
