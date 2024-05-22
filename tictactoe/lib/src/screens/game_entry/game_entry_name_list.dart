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
              for (final player in state.players) GameEntryNameListRow(playerData: player),
            ],
          ),
        );
      },
    );
  }
}
