import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/screens/game_board/game_board.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

/// Example Implementation Using ChangeNotifier and Provider

/// Define a Model to [ Store Positions ]:

class TilePositionModel extends ChangeNotifier {
  final Map<int, Offset> _positions = {};

  void updatePosition(int index, Offset position) {
    _positions[index] = position;
    notifyListeners();
  }

  Offset? getPosition(int index) {
    return _positions[index];
  }
}

/// Update Positions in the Grid Tile:

class GameBoardPanelTile extends StatelessWidget {
  const GameBoardPanelTile(this.index, {super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final box = context.findRenderObject() as RenderBox?;
          final position = box?.localToGlobal(Offset.zero) ?? Offset.zero;
          context.read<TilePositionModel>().updatePosition(index, position);
        });

        return Container(
            // Your tile content
            );
      },
    );
  }
}

/// Draw Line Using Stored Positions:

class LinePainter extends CustomPainter {
  LinePainter({required this.startIndex, required this.endIndex, required this.positions});

  final int startIndex;
  final int endIndex;
  final TilePositionModel positions;

  @override
  void paint(Canvas canvas, Size size) {
    final start = positions.getPosition(startIndex);
    final end = positions.getPosition(endIndex);

    if (start != null && end != null) {
      final paint = Paint()
        ..color = Colors.red
        ..strokeWidth = 4.0
        ..style = PaintingStyle.stroke;

      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return startIndex != oldDelegate.startIndex ||
        endIndex != oldDelegate.endIndex ||
        positions != oldDelegate.positions;
  }
}

/// Use LinePainter in the Widget Tree:

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
        builder: (context, state) {
          final edgeSize = state.currentGame.gameBoardData.edgeSize;
          final tileCount = edgeSize * edgeSize;

          bool clickableTile(int index) =>
              state.currentGame.gameBoardData.availableTileIndexes.contains(index);

          return LayoutBuilder(
            builder: (context, constraints) {
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
                          return InkWell(
                            // onTap: !waitState.isWaiting && clickableTile(index)
                            //     ? () => gridTileCallback(index, context)
                            //     : null,
                            child: GridTile(
                              key: ValueKey('grid-tile-$index'), // Assign a unique key
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
                      // WaitForBotIndicator(
                      //   waitingOnBot: waitState.isWaiting,
                      // ),
                      BlocBuilder<GamePlayBloc, GamePlayState>(
                        builder: (context, state) {
                          // Define how you get line data
                          // final lineData = state.currentGame.lineData;
                          (int, int)? lineData;
                          lineData = 0 == 0 ? (0, 0) : null;
                          if (lineData != null) {
                            final positions = context.watch<TilePositionModel>();
                            return CustomPaint(
                              size: Size(constraints.maxWidth, constraints.maxHeight),
                              painter: LinePainter(
                                // startIndex: lineData.startIndex,
                                // endIndex: lineData.endIndex,
                                startIndex: lineData.$1,
                                endIndex: lineData.$2,
                                positions: positions,
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
      ),
    );
  }
}
