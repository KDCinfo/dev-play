import 'package:dev_play_tictactoe/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactoe/src/data/models/models.dart';
import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameEntryNameListRow extends StatefulWidget {
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
  State<GameEntryNameListRow> createState() => _GameEntryNameListRowState();
}

class _GameEntryNameListRowState extends State<GameEntryNameListRow> {
  late TextEditingController _textFormFieldController;

  @override
  void initState() {
    super.initState();
    _textFormFieldController = TextEditingController(
      text: widget.playerData.playerName,
    );
  }

  @override
  void dispose() {
    _textFormFieldController.dispose();
    super.dispose();
  }

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
              player: widget.playerData,
              availableSymbols: widget.availableSymbols,
              onChanged: (String newName) => nameFieldUpdated(newName, context),
              textFormFieldController: _textFormFieldController,
            ),
          ),
          ConstrainedBox(
            // Set a maxWidth to match the TextField.
            constraints: const BoxConstraints(maxWidth: 150),
            child: PlayerList(
              playerList: widget.listRowPlayerList,
              onSelected: (int value) => useSavedName(value, context),
            ),
          ),
        ],
      ),
    );
  }

  /// Updating the player list occurs when the user:
  /// - changes the name.
  /// - selects a previously saved name from the list
  ///   (which then populates the player name field and calls this method).
  /// - selects a different marker from the marker menu.
  ///
  /// 2nd slot name change: 3rd slot added; player type changed to human.
  /// 3rd slot name change: 4th slot added.
  ///
  /// [GameEntryChangeNameEvent] | [GameEntry PlayerList Event]
  ///
  /// Input | onChanged: (String newName) => nameFieldUpdated(newName, context),
  void nameFieldUpdated(String newName, BuildContext context) {
    context.read<GameEntryBloc>().add(
          GameEntryChangeNameEvent(
            playerNum: widget.playerData.playerNum,
            playerName: newName,
          ),
        );
  }

  /// This method will assign the new input value to the controller, then,
  /// because programmatic updates to a `TextFormField` don't trigger the
  /// `onChanged` event, an imperative call to `nameFieldUpdated` is made.
  ///
  /// PlayerList | onSelected: (int value) => useSavedName(value, context),
  void useSavedName(int value, BuildContext context) {
    final newName = widget.listRowPlayerList[value];

    // Don't fire if the selected name is the same as the player's current name.
    if (newName.toLowerCase() != widget.playerData.playerName.toLowerCase()) {
      // log('Selected Index: $value');
      // log('Selected Name: $newName');

      _textFormFieldController.text = newName;

      nameFieldUpdated(newName, context);
    }
  }
}
