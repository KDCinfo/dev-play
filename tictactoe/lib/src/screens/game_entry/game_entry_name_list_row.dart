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

    final screenWidth = MediaQuery.sizeOf(context).width;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 90,
        maxWidth: screenWidth * 0.9,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(playerLabel),
          ),
          const SizedBox(height: 5),
          const Row(
            children: [
              // GameEntryNameListRowInputName(),
              // GameEntryNameListRowPlayerNameList(),
              // 50% width for each widget.
              Expanded(
                child: GameEntryNameListRowInputName(),
              ),
              GameEntryNameListRowPlayerNameList(),
            ],
          ),
        ],
      ),
    );
  }
}
