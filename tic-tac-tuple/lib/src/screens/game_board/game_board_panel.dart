// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';
import 'package:dev_play_tictactuple/src/screens/game_board/game_board.dart';
import 'package:dev_play_tictactuple/src/screens/game_widgets/draw_circle_overlay.dart';
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

          return LayoutBuilder(
            builder: (context, constraintsOuter) {
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
                          KeyedSubtree(
                            key: const ValueKey('grid-view'),
                            child: GridView.builder(
                              itemCount: tileCount,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: edgeSize, // Number of columns.
                                // childAspectRatio: 1, // Aspect ratio of each tile.
                              ),
                              itemBuilder: (context, index) {
                                /// I'm not fond of swapping out these keys.
                                /// They're assigned for a purpose, not a multi-purpose.
                                /// Swapping them out feels to be not only an anti-pattern,
                                /// but just flat out the wrong way of doing something.
                                /// It's hacky.
                                /// It's a hack.
                                // final key = state.currentGame.winnerRowColDiag != null &&
                                //         (state.currentGame.winnerRowColDiag!.$1 == index ||
                                //             state.currentGame.lineData!.endIndex == index)
                                //     ? GlobalObjectKey('grid-tile-$index')
                                //     : ValueKey('grid-tile-$index');
                                //
                                return InkWell(
                                  onTap: !waitState.isWaiting && clickableTile(index)
                                      ? () => gridTileCallback(index, context)
                                      : null,
                                  child: GridTile(
                                    // key: Key('grid-tile-$index'), // Assign a unique key
                                    // key: GlobalObjectKey('grid-tile-$index'), // Assign a unique key
                                    key: ValueKey('grid-tile-$index'), // Assign a unique key
                                    child: Builder(
                                      builder: (context) {
                                        // if (stateGamePlayOuter.currentGame.winnerRowColDiag !=
                                        //         null &&
                                        //     // stateGamePlayOuter.currentGame.gameStatus == const GameStatusInProgress() &&
                                        //     stateGamePlayOuter.currentGame.winnerId > -1) {

                                        // We only need to calculate the positions once,
                                        // which we'll do here on the first move.
                                        if (stateGamePlayOuter
                                                .currentGame.gameBoardData.plays.length ==
                                            1) {
                                          // WidgetsBinding.instance.addPostFrameCallback((_) {
                                          //   final box = context.findRenderObject() as RenderBox?;
                                          //   final gridBox = context.findAncestorRenderObjectOfType<RenderBox>();
                                          //   debugPrint('[check] Tile $index');
                                          //   if (box != null && gridBox != null) {
                                          //     final globalPosition = box.localToGlobal(Offset.zero);
                                          //     debugPrint('[check] Global Position: $globalPosition');
                                          //     // Draw a circle at this position
                                          //     DrawCircleOverlay(
                                          //       context: context,
                                          //       globalPosition: globalPosition,
                                          //       radius: 10,
                                          //       index: index,
                                          //     );
                                          //     final size = box.size;
                                          //     debugPrint('[check] Size $size');
                                          //     // final centerPosition = relativePosition + Offset(size.width / 2, size.height / 2);
                                          //     final centerPosition = Offset(
                                          //       globalPosition.dx,
                                          //       globalPosition.dy,
                                          //       // globalPosition.dx + (size.width / 2),
                                          //       // globalPosition.dy + (size.height / 2),
                                          //       // globalPosition.dx - (size.width / 2),
                                          //       // globalPosition.dy - (size.height / 2),
                                          //     );
                                          //     debugPrint('[check] globalPosition.dx | ${globalPosition.dx}');
                                          //     debugPrint('[check] size.width | ${size.width / 2}');
                                          //     debugPrint('[check] globalPosition.dy | ${globalPosition.dy}');
                                          //     debugPrint('[check] size.height | ${size.height / 2}');
                                          //     debugPrint('[check] Center: $centerPosition');
                                          //     context.read<TilePositionModel>().updatePosition(index, centerPosition);
                                          //     // Log the positions for debugging
                                          //     debugPrint('[check] Grid Position: ${gridBox.localToGlobal(Offset.zero)}');
                                          //   }
                                          // });
                                          // WidgetsBinding.instance.addPostFrameCallback((_) {
                                          //   final box = context.findRenderObject() as RenderBox?;
                                          //   final gridBox = context.findAncestorRenderObjectOfType<RenderBox>();
                                          //   if (box != null && gridBox != null) {
                                          //     final globalPosition = box.localToGlobal(Offset.zero);
                                          //     // final relativePosition = gridBox.globalToLocal(globalPosition);
                                          //     // final size = box.size;
                                          //     // final centerPosition = relativePosition + Offset(size.width / 2, size.height / 2);
                                          //     context.read<TilePositionModel>().updatePosition(index, globalPosition);
                                          //     // .updatePosition(index, centerPosition);
                                          //     debugPrint('[check] Tile $index - Global Position: $globalPosition');
                                          //     // debugPrint('[check] Tile $index - '
                                          //     //     'Global Position: $globalPosition, '
                                          //     //     'Relative Position: $relativePosition, '
                                          //     //     'Center: $centerPosition');
                                          //   }
                                          // });
                                          WidgetsBinding.instance.addPostFrameCallback((_) {
                                            final box = context.findRenderObject() as RenderBox?;
                                            final gridBox =
                                                context.findRenderObject() as RenderBox?;

                                            if (box != null && gridBox != null) {
                                              final globalPosition = box.localToGlobal(Offset.zero);
                                              final relativePosition =
                                                  gridBox.globalToLocal(globalPosition);
                                              final size = box.size;
                                              final centerPosition = relativePosition +
                                                  Offset(size.width / 2, size.height / 2);

                                              final offsetGlobal = Offset(
                                                globalPosition.dx + (size.width / 2),
                                                globalPosition.dy + (size.height / 2),
                                              );

                                              DrawCircleOverlay(
                                                context: context,
                                                globalPosition: globalPosition,
                                                radius: 10,
                                                index: index,
                                              );
                                              DrawCircleOverlay(
                                                context: context,
                                                globalPosition: offsetGlobal,
                                                radius: 4,
                                                index: index,
                                                color: Colors.green,
                                              );
                                              DrawCircleOverlay(
                                                context: context,
                                                globalPosition: centerPosition,
                                                radius: 7,
                                                index: index,
                                                color: Colors.orange,
                                              );

                                              context
                                                  .read<TilePositionModel>()
                                                  .updatePosition(index, offsetGlobal);
                                              // .updatePosition(index, centerPosition);

                                              debugPrint('[check] Tile $index - '
                                                  'Global Position: $globalPosition, '
                                                  'offsetGlobal Position: $offsetGlobal, '
                                                  'Relative Position: $relativePosition, '
                                                  'Center: $centerPosition');
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
                            // buildWhen: (previousGamePlay, currentGamePlay) {
                            //   final diagChanged = previousGamePlay.currentGame.winnerRowColDiag !=
                            //       currentGamePlay.currentGame.winnerRowColDiag;
                            //   final winnerRowColDiag =
                            //       currentGamePlay.currentGame.winnerRowColDiag != null;
                            //   final winnerIdValid = currentGamePlay.currentGame.winnerId > -1;
                            //   // final isInProgress = currentGamePlay.currentGame.gameStatus ==
                            //   //     const GameStatusInProgress();

                            //   debugPrint('[check] diagChanged: $diagChanged');
                            //   debugPrint('[check] winnerRowColDiag: $winnerRowColDiag');
                            //   // debugPrint('[check] isInProgress: $isInProgress');
                            //   debugPrint('[check] winnerIdValid: $winnerIdValid');
                            //   return diagChanged &&
                            //       winnerRowColDiag &&
                            //       // isInProgress &&
                            //       winnerIdValid;
                            // },
                            // builder: (context, stateGamePlay) {
                            builder: (context) {
                              if (stateGamePlayOuter.currentGame.winnerRowColDiag != null &&
                                  stateGamePlayOuter.currentGame.winnerId > -1 &&
                                  stateGamePlayOuter.currentGame.gameStatus ==
                                      const GameStatusComplete()) {
                                final lineData = stateGamePlayOuter.currentGame.winnerRowColDiag;
                                if (lineData != null) {
                                  final keyIndexes = transposeLineIndex(lineData, edgeSize);
                                  // final positions = context.watch<TilePositionModel>();
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
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  // final (GlobalObjectKey startKey, GlobalObjectKey endKey) keyIndexes =
  //   transposeLineIndex(state.currentGame.winnerRowColDiag,);
  // (GlobalObjectKey startKey, GlobalObjectKey endKey)? transposeLineIndex(
  (int startIndex, int endIndex)? transposeLineIndex(
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
        // tileIndexEnd = edgeSize * (edgeSize - 1);
        tileIndexEnd = edgeSize * (edgeSize + 1) - 1;
      }

      // Example 3x3 grid.
      // [2, 4, 6] =>     | 1
      if (lineIndex == 1) {
        tileIndexStart = edgeSize - 1;
        tileIndexEnd = edgeSize * (edgeSize - 1) + edgeSize - 1;
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
