import 'dart:developer';

import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/screens/game_board/game_board.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameBoardPanel extends StatelessWidget {
  const GameBoardPanel({super.key});

  void gridTileCallback(int index, BuildContext context) {
    context.read<GamePlayBloc>().add(GamePlayMoveEvent(tileIndex: index));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamePlayBloc, GamePlayState>(
      builder: (context, state) {
        final edgeSize = state.currentGame.gameBoardData.edgeSize;
        final tileCount = edgeSize * edgeSize;

        bool clickableTile(int index) =>
            state.currentGame.gameBoardData.availableTileIndexes.contains(index);

        if (AppConstants.canPrint) {
          log('availableTileIndexes: ${state.currentGame.gameBoardData.availableTileIndexes}');
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            return BlocBuilder<WaitForBotBloc, WaitForBotState>(
              builder: (context, waitState) {
                return Align(
                  // alignment: Alignment.center,
                  // Although `.center` is the default, the `Align` wrapper is still required
                  // in conjunction with the `AspectRatio` widget wrapper to contain the grid
                  // within the available viewing area, else it will expand and get cropped.
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      children: [
                        GridView.builder(
                          itemCount: tileCount,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: edgeSize, // Number of columns.
                            // childAspectRatio: 1, // Aspect ratio of each tile.
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: !waitState.isWaiting && clickableTile(index)
                                  ? () => gridTileCallback(index, context)
                                  : null,
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
                        // const ColoredBox(color: Colors.green),
                        if (waitState.isWaiting)
                          Center(
                            child: SizedBox(
                              height: 100,
                              width: 120,
                              child: LinearProgressIndicator(
                                backgroundColor: AppConstants.primaryTileColor.withOpacity(0.7),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.deepOrange.withOpacity(0.4),
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
