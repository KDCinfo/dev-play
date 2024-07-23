import 'dart:developer';

import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/screens/game_board/game_board.dart';
import 'package:dev_play_tictactuple/src/screens/game_widgets/game_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Revised Implementation with GlobalObjectKey

/// Here's an implementation that dynamically assigns GlobalObjectKey to tiles involved in the winning line:

/// Widget Code

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
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      children: [
                        GridView.builder(
                          itemCount: tileCount,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: edgeSize,
                          ),
                          itemBuilder: (context, index) {
                            // final key = state.currentGame.lineData != null &&
                            //         (state.currentGame.lineData!.startIndex == index ||
                            //             state.currentGame.lineData!.endIndex == index)
                            //     ? GlobalObjectKey('grid-tile-$index')
                            //     : ValueKey('grid-tile-$index');

                            return InkWell(
                              onTap: !waitState.isWaiting && clickableTile(index)
                                  ? () => gridTileCallback(index, context)
                                  : null,
                              child: GridTile(
                                key: key, // Assign either GlobalObjectKey or ValueKey
                                child: Stack(
                                  children: [
                                    GameBoardPanelTile(index),
                                    Positioned(
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
                        WaitForBotIndicator(waitingOnBot: waitState.isWaiting),
                        BlocBuilder<GamePlayBloc, GamePlayState>(
                          builder: (context, state) {
                            // Define how you get line data
                            // final lineData = state.currentGame.lineData;
                            (int, int)? lineData;
                            lineData = 0 == 0 ? (0, 0) : null;
                            if (lineData != null) {
                              return CustomPaint(
                                size: Size(constraints.maxWidth, constraints.maxHeight),
                                painter: LinePainter(
                                  startKey: GlobalObjectKey('grid-tile-${lineData.$1}'),
                                  endKey: GlobalObjectKey('grid-tile-${lineData.$2}'),
                                  // startKey: GlobalObjectKey('grid-tile-${lineData.startIndex}'),
                                  // endKey: GlobalObjectKey('grid-tile-${lineData.endIndex}'),
                                ),
                              );
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
    );
  }
}

/// LinePainter Code

class LinePainter extends CustomPainter {
  LinePainter({required this.startKey, required this.endKey});

  final GlobalObjectKey startKey;
  final GlobalObjectKey endKey;

  @override
  void paint(Canvas canvas, Size size) {
    final startBox = startKey.currentContext?.findRenderObject() as RenderBox?;
    final endBox = endKey.currentContext?.findRenderObject() as RenderBox?;

    if (startBox != null && endBox != null) {
      final start = startBox.localToGlobal(Offset.zero);
      final end = endBox.localToGlobal(Offset.zero);

      final paint = Paint()
        ..color = Colors.red
        ..strokeWidth = 4.0
        ..style = PaintingStyle.stroke;

      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return startKey != oldDelegate.startKey || endKey != oldDelegate.endKey;
  }
}
