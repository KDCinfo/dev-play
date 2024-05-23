import 'package:dev_play_tictactoe/src/app_constants.dart';

import 'package:flutter/material.dart';

/// This list is meant to merely prepulate its sibling `TextFormField` input.
class PlayerList extends StatefulWidget {
  const PlayerList({
    required this.playerList,
    required this.onSelected,
    super.key,
  });

  final List<String> playerList;

  /// Callback function returning the index (`playerList[index]`) of the selected player.
  final void Function(int) onSelected;

  @override
  State<PlayerList> createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  late TextEditingController _dropdownController;

  @override
  void initState() {
    super.initState();
    _dropdownController = TextEditingController();
  }

  @override
  void dispose() {
    _dropdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        //
        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 150),
          child: DropdownMenu<int>(
            controller: _dropdownController,
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
              ...widget.playerList.map((String entry) {
                return DropdownMenuEntry(
                  value: widget.playerList.indexOf(entry),
                  label: entry,
                );
              }),
            ],
            onSelected: processOnSelected,
          ),
        );
      },
    );
  }

  /// Let's return the index of the selected player so it can be used to
  /// update the `TextFormField` input, and if 'TicTacBot' was selected,
  /// then display a brief message inidicating the fields are being reset.
  ///
  void processOnSelected(int? value) {
    if (value != null) {
      widget.onSelected(value);
      if (widget.playerList[value] == AppConstants.playerBotName) {
        _dropdownController.text = AppConstants.playerListResetMsg;
        Future.delayed(
          const Duration(milliseconds: 800),
          () {
            _dropdownController.text = '';
          },
        );
      } else {
        _dropdownController.text = widget.playerList[value];
      }
    }
  }
}
