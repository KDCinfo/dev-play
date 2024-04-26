import 'package:dev_play_tictactoe/src/src.dart';
import 'package:flutter/material.dart';

class GameEntryNameListRow extends StatelessWidget {
  const GameEntryNameListRow({
    super.key,
    required this.playerNum,
  });

  final int playerNum;

  @override
  Widget build(BuildContext context) {
    /// 'Player $playerNum Name:'
    final playerLabel = AppConstants.playerLabel(playerNum);

    return Column(
      children: [
        Text(playerLabel),
        const Row(
          children: [
            // GameEntryNameListRowInputName(),
            // GameEntryNameListRowPlayerNameList(),
          ],
        ),
      ],
    );
  }
}
