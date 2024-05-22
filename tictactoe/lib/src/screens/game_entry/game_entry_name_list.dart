// ignore_for_file: avoid_print

import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactoe/src/data/models/models.dart';
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
        final usedSymbolList = Map<String, Icon>.fromEntries(
          state.players.map(
            (player) => MapEntry(player.userSymbol.markerKey, player.userSymbol.markerIcon),
          ),
        );

        final unusedSymbolList = Map<String, Icon>.fromEntries(
          UserSymbol.markerList.entries.where((symbol) {
            final keyUsed = usedSymbolList.containsKey(symbol.key);
            return !keyUsed;
          }).map((symbol) {
            final mapEntry = MapEntry(symbol.key, symbol.value);
            return mapEntry;
          }),
        );

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
                      ? [AppConstants.playerBotName, ...state.allSavedPlayerNames]
                      : state.allSavedPlayerNames,
                  // Add `UserSymbol` from current player.
                  availableSymbols: Map<String, Icon>.fromEntries(
                    unusedSymbolList.entries,
                  )..putIfAbsent(
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
