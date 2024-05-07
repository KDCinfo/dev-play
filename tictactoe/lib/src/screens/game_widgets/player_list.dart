import 'dart:developer';

import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/models/models.dart';

import 'package:flutter/material.dart';

/// This list is meant to merely prepulate the TextFormField input;
///   the playerNum will depended on the slot selected, and the symbol
///   will still need to be selected for the current game.
class PlayerList extends StatelessWidget {
  const PlayerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        //
        // @TODO: To be replaced by a BlocBuilder.
        final playerList = AppDataFake.fakePlayerList3;

        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 150),
          child: DropdownMenu<int>(
            // initialSelection: 0,
            // width: 125,
            // Hintext should be a label less than 10 characters
            hintText: AppConstants.playerListHintText,
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              isDense: true,
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.only(left: 10),
            ),
            dropdownMenuEntries: [
              /// 'Select from previous names:'
              ...playerList.map((GamePlayer entry) {
                return DropdownMenuEntry(
                  // A player can't be stored without a 'playerId'.
                  value: entry.playerId!,
                  label: entry.playerName,
                );
              }),
            ],
            onSelected: (int? value) {
              log('Selected: ${value ?? 'null'}');
            },
          ),
        );
      },
    );
  }
}
