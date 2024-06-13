import 'package:dev_play_tictactuple/src/data/models/models.dart';
import 'package:dev_play_tictactuple/src/screens/game_widgets/game_widgets.dart';

import 'package:flutter/material.dart';

class GameBoardPanelTileOverlay extends StatelessWidget {
  const GameBoardPanelTileOverlay({
    required this.index,
    required this.currentGame,
    required this.isClickableTile,
    super.key,
  });

  final int index;
  final GameData currentGame;
  final bool isClickableTile;

  @override
  Widget build(BuildContext context) {
    return isClickableTile
        ? const SizedBox()
        : LayoutBuilder(
            builder: (context, constraints) {
              final size = constraints.maxWidth;

              final playerId = currentGame.gameBoardData.plays.isEmpty
                  ? -1
                  : currentGame.gameBoardData.plays
                          .where((PlayerTurn play) => play.tileIndex == index)
                          .firstOrNull
                          ?.occupiedById ??
                      -1;
              final playerIcon = currentGame.players
                      .where((player) => player.playerId == playerId)
                      .firstOrNull
                      ?.userSymbol
                      .markerIcon
                      .icon ??
                  const Icon(Icons.error).icon;

              return IconPop(size: size, playerIcon: playerIcon);
            },
          );
  }
}
