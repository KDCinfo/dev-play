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
          /// There will only be 1 row to start
          /// with a line below it to add players.
          GameEntryNameListRow(playerNum: 1),

          /// if (playerList < AppConstants.playerListMax)
          ///   AddAPlayerButton('+ Add a Player')

          GameEntryNameListRow(playerNum: 2),
          GameEntryNameListRow(playerNum: 3),
          GameEntryNameListRow(playerNum: 4),
        ],
      ),
    );
  }
}
