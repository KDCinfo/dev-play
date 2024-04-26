import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';

/// Note: This widget needs to be constrained (vertically) by its parent.
///
class GameEntryNameList extends StatelessWidget {
  const GameEntryNameList({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          GameEntryNameListRow(playerNum: 1),
          GameEntryNameListRow(playerNum: 2),
          GameEntryNameListRow(playerNum: 3),
          GameEntryNameListRow(playerNum: 4),
        ],
      ),
    );
  }
}
