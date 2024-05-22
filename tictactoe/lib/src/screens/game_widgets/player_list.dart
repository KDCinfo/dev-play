import 'package:dev_play_tictactoe/src/app_constants.dart';

import 'package:flutter/material.dart';

/// This list is meant to merely prepulate its sibling `TextFormField` input.
class PlayerList extends StatelessWidget {
  const PlayerList({
    required this.playerList,
    required this.onSelected,
    super.key,
  });

  final List<String> playerList;

  /// Callback function returning the index (`playerList[index]`) of the selected player.
  final void Function(int?) onSelected;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        //
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
              /// 'Select from previously used names:'
              ...playerList.map((String entry) {
                return DropdownMenuEntry(
                  value: playerList.indexOf(entry),
                  label: entry,
                );
              }),
            ],
            onSelected: onSelected,
          ),
        );
      },
    );
  }
}
