// ignore_for_file: avoid_print

import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Note: This widget needs to be constrained (vertically) by its parent.
///
class GameEntryNameList extends StatelessWidget {
  const GameEntryNameList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameEntryBloc, GameEntryState>(
      // ignore: avoid-shadowing
      builder: (context, state) {
        /// A base list without the saved name `TicTacBot`.
        final allSavedPlayerNames =
            state.allSavedPlayerNames.where((name) => name != AppConstants.playerBotName).toList();

        /// The `SingleChildScrollView` is needed for scrolling
        /// in landscape mode or on small screens.
        return SingleChildScrollView(
          child: Column(
            children: [
              for (final player in state.players)
                GameEntryNameListRow(
                  playerData: player,
                  listRowPlayerList: player.playerNum == 2
                      // Insert `playerBotName` at beginning of list.
                      ? [AppConstants.playerBotName, ...allSavedPlayerNames]
                      : allSavedPlayerNames,
                  // Add `UserSymbol` from current player.
                  availableSymbols: state.unusedSymbolList
                    ..putIfAbsent(
                      player.userSymbol.markerKey,
                      () => player.userSymbol.markerIcon,
                    ),
                ),
            ],
          ),
        );
      },
    );
  }
}
