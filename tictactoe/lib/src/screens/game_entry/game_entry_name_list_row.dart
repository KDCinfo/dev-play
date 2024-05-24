import 'dart:developer';

import 'package:dev_play_tictactoe/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactoe/src/data/models/models.dart';
import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameEntryNameListRow extends StatelessWidget {
  const GameEntryNameListRow({
    required this.playerData,
    required this.listRowPlayerList,
    required this.availableSymbols,
    super.key,
  });

  final PlayerData playerData;
  final List<String> listRowPlayerList;
  // Filtered map of unused symbols.
  final MarkerListDef availableSymbols;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        // Adds spacing horizontally between wrapped children.
        spacing: 10,
        // Adds spacing vertically between wrapped lines.
        runSpacing: 4,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 150),
            child: GameEntryNameListRowInputName(
              player: playerData,
              availableSymbols: availableSymbols,
              onChanged: (String newName) => nameFieldUpdated(newName, context),
            ),
          ),
          ConstrainedBox(
            // Set a maxWidth to match the TextField.
            constraints: const BoxConstraints(maxWidth: 150),
            child: PlayerList(
              playerList: listRowPlayerList,
              onSelected: (int value) => useSavedName(value, context),
            ),
          ),
        ],
      ),
    );
  }

  void nameFieldUpdated(String newName, BuildContext context) {
    context.read<GameEntryBloc>().add(
            playerNum: playerData.playerNum,
          GameEntryChangeNameEvent(
            playerName: newName,
          ),
        );
  }

  void useSavedName(int value, BuildContext context) {
    log('Selected Index: $value');
    log('Selected Name: ${listRowPlayerList[value]}');
    context.read<GameEntryBloc>().add(
          GameEntryNameSelectedEvent(
            playerNum: playerData.playerNum,
            selectedPlayerName: listRowPlayerList[value],
          ),
        );
  }
}
