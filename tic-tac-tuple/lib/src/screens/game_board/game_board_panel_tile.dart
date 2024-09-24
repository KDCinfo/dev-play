import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:flutter/material.dart';

class GameBoardPanelTile extends StatelessWidget {
  const GameBoardPanelTile(
    this.index, {
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppConstants.primaryTileColor.withValues(alpha: 0.5),
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: const [
          BoxShadow(color: Colors.white),
          BoxShadow(
            offset: Offset(2, 2),
            color: AppConstants.primaryTileColor,
            spreadRadius: -1,
            blurRadius: 4,
          ),
        ],
      ),
      child: const Center(
        child: SizedBox(),
      ),
    );
  }
}
