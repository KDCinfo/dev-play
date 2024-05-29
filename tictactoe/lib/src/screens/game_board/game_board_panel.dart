import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/screens/game_board/game_board.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameBoardPanel extends StatelessWidget {
  const GameBoardPanel({super.key, this.edgeSize = 3});

  // @TODO: This will be derived from the `BlocBuilder` below.
  // In the meantime, we'll allow the value to be injected for testing.
  final int edgeSize; // = 3;

  void gridTileCallback(int index, BuildContext context) {
    context.read<GamePlayBloc>().add(GamePlayMoveEvent(tileIndex: index));
  }

  @override
  Widget build(BuildContext context) {
    //
    // @TODO: Add a `BlocBuilder` here for `edgeSize`.
    //
    return LayoutBuilder(
      builder: (context, constraints) {
        final tileCount = edgeSize * edgeSize;

        return BlocBuilder<GamePlayBloc, GamePlayState>(
          builder: (context, state) {
            bool clickableTile(int index) =>
                state.currentGame.gameBoardData.availableTileIndexes.contains(index);

            return Align(
              // alignment: Alignment.center,
              // Although `.center` is the default, the `Align` wrapper is still required
              // in conjunction with the `AspectRatio` widget wrapper to contain the grid
              // within the available viewing area, else it will expand and get cropped.
              child: AspectRatio(
                aspectRatio: 1,
                child: GridView.builder(
                  itemCount: tileCount,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: edgeSize, // Number of columns.
                    // childAspectRatio: 1, // Aspect ratio of each tile.
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: clickableTile(index) ? () => gridTileCallback(index, context) : null,
                      child: GridTile(
                        child: Stack(
                          children: [
                            GameBoardPanelTile(index),
                            // @TODO: Maybe try to make the icon pop up when tapped.
                            Positioned(
                              // Max width and height of the clickable area.
                              // height: double.infinity,
                              // width: double.infinity,
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: GameBoardPanelTileOverlay(
                                index: index,
                                currentGame: state.currentGame,
                                isClickableTile: clickableTile(index),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
