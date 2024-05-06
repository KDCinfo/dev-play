import 'package:dev_play_tictactoe/src/screens/game_play/game_play.dart';

import 'package:flutter/material.dart';

class GameBoardPanel extends StatelessWidget {
  const GameBoardPanel({super.key, this.edgeSize = 3});

  // @TODO: This will be derived from the `BlocBuilder` below.
  // In the meantime, we'll allow the value to be injected for testing.
  final int edgeSize; // = 3;

  @override
  Widget build(BuildContext context) {
    //
    // @TODO: Add a `BlocBuilder` here for `edgeSize`.
    //
    return LayoutBuilder(builder: (context, constraints) {
      final tileCount = edgeSize * edgeSize;

      return Align(
        alignment: Alignment.center,
        child: AspectRatio(
          aspectRatio: 1,
          child: GridView.builder(
            itemCount: tileCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: edgeSize, // Number of columns.
              childAspectRatio: 1, // Aspect ratio of each tile.
            ),
            itemBuilder: (context, index) {
              return GridTile(
                child: GameBoardPanelTile(index),
              );
            },
          ),
        ),
      );
    });
  }
}
