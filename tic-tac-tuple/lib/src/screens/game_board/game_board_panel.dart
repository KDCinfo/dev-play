import 'dart:developer';

import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';
import 'package:dev_play_tictactuple/src/screens/game_board/game_board.dart';
import 'package:dev_play_tictactuple/src/screens/game_widgets/game_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class GameBoardPanel extends StatelessWidget {
  const GameBoardPanel({super.key});

  void gridTileCallback(int index, BuildContext context) {
    context.read<GamePlayBloc>().add(GamePlayMoveEvent(tileIndex: index));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TilePositionModel(),
      child: BlocBuilder<GamePlayBloc, GamePlayState>(
        buildWhen: (previous, current) => previous.currentGame != current.currentGame,
        builder: (context, stateGamePlayOuter) {
          final edgeSize = stateGamePlayOuter.currentGame.gameBoardData.edgeSize;
          final tileCount = edgeSize * edgeSize;

          bool clickableTile(int index) =>
              stateGamePlayOuter.currentGame.gameBoardData.availableTileIndexes.contains(index);

          if (AppConstants.canPrint) {
            log('[check] winnerRowColDiag: ${stateGamePlayOuter.currentGame.winnerRowColDiag}');
            log('[check] availableTileIndexes: ${stateGamePlayOuter.currentGame.gameBoardData.availableTileIndexes}');
          }

          return BlocBuilder<WaitForBotBloc, WaitForBotState>(
            builder: (context, waitState) {
              return Align(
                // alignment: Alignment.center,
                // Although `.center` is the default, the `Align` wrapper is still required
                // in conjunction with the `AspectRatio` widget wrapper to contain the grid
                // within the available viewing area, else it will expand and get cropped.
                child: AspectRatio(
                  aspectRatio: 1,
                  child: LayoutBuilder(
                    builder: (context, constraintsOuter) {
                      final gridBox = context.findAncestorRenderObjectOfType<RenderBox>();
                      return Stack(
                        children: [
                          KeyedSubtree(
                            key: const ValueKey('grid-view'),
                            child: GridView.builder(
                              itemCount: tileCount,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: edgeSize, // Number of columns.
                                // childAspectRatio: 1, // Aspect ratio of each tile.
                              ),
                              itemBuilder: (context, index) {
                                //
                                return InkWell(
                                  onTap: !waitState.isWaiting && clickableTile(index)
                                      ? () => gridTileCallback(index, context)
                                      : null,
                                  child: GridTile(
                                    key: ValueKey('grid-tile-$index'),
                                    child: Builder(
                                      builder: (context) {
                                        //
                                        // We only need to calculate the positions once,
                                        // which we'll do here on the first move.
                                        if (stateGamePlayOuter
                                                .currentGame.gameBoardData.plays.length ==
                                            1) {
                                          WidgetsBinding.instance.addPostFrameCallback((_) {
                                            final box = context.findRenderObject() as RenderBox?;
                                            if (box != null && gridBox != null) {
                                              final size = box.size;

                                              final globalPosition = box.localToGlobal(Offset.zero);
                                              final relativePosition =
                                                  gridBox.globalToLocal(globalPosition);
                                              final centerPosition = relativePosition +
                                                  Offset(size.width / 2, size.height / 2);

                                              // Update the model with the center position.
                                              context
                                                  .read<TilePositionModel>()
                                                  .updatePosition(index, centerPosition);
                                            }
                                          });
                                        }

                                        return Stack(
                                          children: [
                                            GameBoardPanelTile(index),
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
                                                currentGame: stateGamePlayOuter.currentGame,
                                                isClickableTile: clickableTile(index),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          WaitForBotIndicator(waitingOnBot: waitState.isWaiting),
                          Builder(
                            builder: (contextBuilder) {
                              if (stateGamePlayOuter.currentGame.winnerRowColDiag != null &&
                                  stateGamePlayOuter.currentGame.winnerId > -1 &&
                                  stateGamePlayOuter.currentGame.gameStatus ==
                                      const GameStatusComplete()) {
                                final lineData = stateGamePlayOuter.currentGame.winnerRowColDiag;
                                if (lineData != null) {
                                  final keyIndexes = transposeLineIndex(lineData, edgeSize);
                                  final positions = context.read<TilePositionModel>();

                                  if (keyIndexes != null) {
                                    return CustomPaint(
                                      size: Size(
                                        constraintsOuter.maxWidth,
                                        constraintsOuter.maxHeight,
                                      ),
                                      painter: LinePainter(
                                        startIndex: keyIndexes.$1,
                                        endIndex: keyIndexes.$2,
                                        positions: positions,
                                      ),
                                    );
                                  }
                                }
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  /// :: (int startIndex, int endIndex)
  (int, int)? transposeLineIndex(
    WinnerRowColDiagDef winnerRowColDiag,
    int edgeSize,
  ) {
    final lineIndex = winnerRowColDiag!.$2;
    int? tileIndexStart;
    int? tileIndexEnd;

    // [1st] => Top row to bottom row.
    if (winnerRowColDiag.$1 == MatchTupleEnum.row) {
      // Example 3x3 grid | lineIndexStart
      // [0, 1, 2] =>     |     0     * 3 == 0 <= start index
      // [3, 4, 5] =>     |     1     * 3 == 3 <= start index
      // [6, 7, 8] =>     |     2     * 3 == 6 <= start index
      // Example 4x4 grid    | lineIndexStart
      // [0, 1, 2, 3] =>     |     0     * 4 == 0 <= start index
      // [4, 5, 6, 7] =>     |     1     * 4 == 4 <= start index
      // [8, 9, 10, 11] =>   |     2     * 4 == 8 <= start index
      // [12, 13, 14, 15] => |     3     * 4 == 12 <= start index
      tileIndexStart = lineIndex * edgeSize;
      tileIndexEnd = tileIndexStart + edgeSize - 1;
    }

    // [2nd] => Left column to right column.
    if (winnerRowColDiag.$1 == MatchTupleEnum.column) {
      // Example 3x3 grid | lineIndexEnd
      // [0, 3, 6] =>     |     0     + 3 * (3 - 1) == 6 <= end index
      // [1, 4, 7] =>     |     1     + 3 * (3 - 1) == 7 <= end index
      // [2, 5, 8] =>     |     2     + 3 * (3 - 1) == 8 <= end index
      tileIndexStart = lineIndex;
      tileIndexEnd = tileIndexStart + edgeSize * (edgeSize - 1);
    }

    // [3rd] => Top left to bottom right.
    // [4th] => Top right to bottom left.
    if (winnerRowColDiag.$1 == MatchTupleEnum.diagonal) {
      // Example 3x3 grid.
      // [0, 4, 8] =>     | 0
      if (lineIndex == 0) {
        tileIndexStart = 0;
        tileIndexEnd = edgeSize * edgeSize - 1;
      }

      // Example 3x3 grid.
      // [2, 4, 6] =>     | 1
      if (lineIndex == 1) {
        tileIndexStart = edgeSize - 1;
        tileIndexEnd = edgeSize * (edgeSize - 1);
      }
    }

    // GlobalObjectKey? startKey;
    // GlobalObjectKey? endKey;
    // if (tileIndexStart != null && tileIndexEnd != null) {
    //   startKey = GlobalObjectKey('grid-tile-$tileIndexStart');
    //   endKey = GlobalObjectKey('grid-tile-$tileIndexEnd');
    // }
    // return startKey != null && endKey != null ? (startKey, endKey) : null;

    return tileIndexStart != null && tileIndexEnd != null ? (tileIndexStart, tileIndexEnd) : null;
  }
}
