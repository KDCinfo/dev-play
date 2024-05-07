import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';

class GameEntryNameListRow extends StatelessWidget {
  const GameEntryNameListRow({
    required this.playerNum,
    super.key,
  });

  final int playerNum;

  @override
  Widget build(BuildContext context) {
    final player = GamePlayer(playerNum: playerNum);

    final inputName = GameEntryNameListRowInputName(player: player);
    const savedNames = PlayerList();

    return SingleChildScrollView(
      child: Wrap(
        // Adds spacing horizontally between wrapped children.
        spacing: 10,
        // Adds spacing vertically between wrapped lines.
        runSpacing: 4,
        children: <Widget>[
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 150),
            child: inputName,
          ),
          ConstrainedBox(
            // Set a maxWidth to match the TextField.
            constraints: const BoxConstraints(maxWidth: 150),
            child: savedNames,
          ),
        ],
      ),
    );
  }
}
