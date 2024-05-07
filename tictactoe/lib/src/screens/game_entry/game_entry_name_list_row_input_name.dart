import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/data/models/models.dart';
import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';

class GameEntryNameListRowInputName extends StatelessWidget {
  const GameEntryNameListRowInputName({
    required this.player,
    super.key,
  });

  final GamePlayer player;

  @override
  Widget build(BuildContext context) {
    //
    return TextFormField(
      // initialValue: 'John',
      decoration: InputDecoration(
        /// The `label` is shown instead of the `hintText` when the field is empty and unfocused.
        /// When focused, the label moves up, and the `hintText` is shown.
        label: Text(
          player.label,
          style: const TextStyle(fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        hintText: AppConstants.playerNameHintText,
        isDense: true,
        border: const OutlineInputBorder(),
        suffixIcon: MarkerMenu(
          markerIcon: player.userSymbol.markerIcon,
        ),
      ),
    );
  }
}
