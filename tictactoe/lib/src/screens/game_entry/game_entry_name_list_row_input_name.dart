import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactoe/src/data/models/models.dart';
import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameEntryNameListRowInputName extends StatefulWidget {
  const GameEntryNameListRowInputName({
    required this.player,
    required this.availableSymbols,
    required this.onChanged,
    super.key,
  });

  final PlayerData player;
  final MarkerListDef availableSymbols;
  final void Function(String) onChanged;

  @override
  State<GameEntryNameListRowInputName> createState() => _GameEntryNameListRowInputNameState();
}

class _GameEntryNameListRowInputNameState extends State<GameEntryNameListRowInputName> {
  late TextEditingController _textFormFieldController;

  @override
  void initState() {
    super.initState();
    _textFormFieldController = TextEditingController(
      text: widget.player.playerName,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _textFormFieldController.text = widget.player.playerName;
  }

  @override
  void didUpdateWidget(GameEntryNameListRowInputName oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.player.playerName != widget.player.playerName) {
      _textFormFieldController.text = widget.player.playerName;
    }
  }

  @override
  void dispose() {
    _textFormFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    return TextFormField(
      // initialValue: 'John',
      controller: _textFormFieldController,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        /// The `label` is shown instead of the `hintText` when the field is empty and unfocused.
        /// When focused, the label moves up, and the `hintText` is shown.
        label: Text(
          widget.player.label,
          style: const TextStyle(fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        hintText: AppConstants.playerNameHintText,
        isDense: true,
        border: const OutlineInputBorder(),
        suffixIcon: MarkerMenu(
          markerIcon: widget.player.userSymbol.markerIcon,
          availableSymbols: widget.availableSymbols,
          onPressed: (String value) => onSymbolIconPressed(context, value),
        ),
      ),
    );
  }

  void onSymbolIconPressed(BuildContext context, String value) {
    context.read<GameEntryBloc>().add(
          GameEntrySymbolSelectedEvent(
            playerNum: widget.player.playerNum,
            selectedSymbolKey: value,
          ),
        );
  }
}
