import 'package:dev_play_tictactoe/src/app_constants.dart';
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
    return BlocBuilder<GameEntryBloc, GameEntryState>(
      builder: (context, state) {
        // AppConstants.markerList
        final usedSymbolList = state.players
            .map((player) => MapEntry(player.userSymbol, player.playerNum)) as MarkerListDef;
        final unusedSymbolList = AppConstants.markerList.keys.where(
          (symbol) => !usedSymbolList.containsKey(symbol),
        ) as MarkerListDef;

        /// The `SingleChildScrollView` is needed for scrolling
        /// in landscape mode or on small screens.
        return SingleChildScrollView(
          child: Column(
            children: [
              for (final player in state.players)
                GameEntryNameListRow(
                  playerData: player,
                  playerList: player.playerNum == 2
                      // Insert `playerBotName` at beginning of list.
                      ? [AppConstants.playerBotName, ...state.allSavedPlayerNames]
                      : state.allSavedPlayerNames,
                  availableSymbols: unusedSymbolList
                    ..addAll(
                      MapEntry(
                        player.userSymbol.markerKey,
                        player.userSymbol.markerIcon,
                      ) as MarkerListDef,
                    ),
                ),
            ],
          ),
        );
      },
    );
  }
}
