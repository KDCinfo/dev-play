import 'package:flutter/material.dart';

class GameEntryNameListRow extends StatelessWidget {
  const GameEntryNameListRow({
    super.key,
    required this.playerNum,
  });

  final int playerNum;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Player $playerNum Name:'),
        const Row(
          children: [
            // GameEntryNameListRowInputName(),
            // GameEntryNameListRowPlayerList(),
          ],
        ),
      ],
    );
  }
}
