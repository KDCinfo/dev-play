import 'package:dev_play_tictactoe/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Note: This widget needs to be constrained (vertically) by its parent.
///
class GameEntryNameList extends StatelessWidget {
  const GameEntryNameList({super.key});

  @override
  Widget build(BuildContext context) {
    /// The `SingleChildScrollView` is needed for scrolling
    /// in landscape mode or on small screens.
    return BlocBuilder<GameEntryBloc, GameEntryState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              /// There will only be 1 row to start.
              /// Additional rows will be added as players are added.
              const GameEntryNameListRow(playerNum: 1),
              if (state.players.length == 1) const GameEntryNameListRow(playerNum: 2),

              if (state.players.length == 2) const GameEntryNameListRow(playerNum: 2),
              if (state.players.length == 2) const GameEntryNameListRow(playerNum: 3),

              if (state.players.length == 3) const GameEntryNameListRow(playerNum: 2),
              if (state.players.length == 3) const GameEntryNameListRow(playerNum: 3),
              if (state.players.length == 3) const GameEntryNameListRow(playerNum: 4),
            ],
          ),
        );
      },
    );
  }
}
