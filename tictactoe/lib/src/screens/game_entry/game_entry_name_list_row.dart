import 'dart:developer';

import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactoe/src/data/models/models.dart';
import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameEntryNameListRow extends StatelessWidget {
  const GameEntryNameListRow({
    required this.playerData,
    required this.playerList,
    required this.availableSymbols,
    super.key,
  });

  final PlayerData playerData;
  final List<String> playerList;
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
            ),
          ),
          ConstrainedBox(
            // Set a maxWidth to match the TextField.
            constraints: const BoxConstraints(maxWidth: 150),
            child: PlayerList(
              playerList: playerList,
              onSelected: (int? value) => useSavedName(value, context),
            ),
          ),
        ],
      ),
    );
  }

  void useSavedName(int? value, BuildContext context) {
    log('Selected Index: ${value ?? 'null'}');
    if (value != null) {
      log('Selected Name: ${playerList[value]}');
      context.read<GameEntryBloc>().add(
            GameEntryNameSelectedEvent(
              playerNum: playerData.playerNum,
              selectedPlayerName: playerList[value],
            ),
          );
    }
  }
}
