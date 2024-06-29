import 'package:dev_play_tictactuple/src/data/models/models.dart';

import 'package:flutter/material.dart';

class GameBoardPlayerPanelNames extends StatelessWidget {
  const GameBoardPlayerPanelNames({
    required this.players,
    required this.currentPlayerIndex,
    super.key,
  });

  final List<PlayerData> players;
  final int currentPlayerIndex;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        for (var idx = 0; idx < players.length; idx++)
          Text(
            '[ ${players.elementAtOrNull(idx)?.playerName ?? 'Missing a name'} ]',
            style: TextStyle(
              fontWeight: idx == currentPlayerIndex ? FontWeight.bold : FontWeight.normal,
            ),
          ),
      ],
    );
  }
}
