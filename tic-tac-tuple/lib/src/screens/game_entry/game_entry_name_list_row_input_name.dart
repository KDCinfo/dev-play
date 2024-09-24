import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';
import 'package:dev_play_tictactuple/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameEntryNameListRowInputName extends StatelessWidget {
  const GameEntryNameListRowInputName({
    required this.player,
    required this.availableSymbols,
    required this.onChanged,
    required this.textFormFieldController,
    super.key,
  });

  final PlayerData player;
  final MarkerListDef availableSymbols;
  final void Function(String) onChanged;
  final TextEditingController textFormFieldController;

  @override
  Widget build(BuildContext context) {
    //
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: AppConstants.primaryTileColor.withValues(alpha: 0.3), width: 2),
          right: BorderSide(color: AppConstants.primaryTileColor.withValues(alpha: 0.3), width: 2),
          bottom: BorderSide(color: AppConstants.primaryTileColor.withValues(alpha: 0.3), width: 2),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Colors.yellow.withValues(alpha: 0.3),
            Colors.yellow.withValues(alpha: 0.1),
            Colors.white12,
            Colors.white,
          ],
          stops: const [0, 0.5, 0.7, 1],
        ),
      ),
      child: TextFormField(
        // initialValue: 'John',
        controller: textFormFieldController,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(left: 10),
          isDense: true,

          /// The `label` is shown instead of the `hintText` when the field is empty and unfocused.
          /// When focused, the label moves up, and the `hintText` is shown.
          hintText: AppConstants.playerNameHintText,
          label: Text(
            player.label,
            style: const TextStyle(
              color: AppConstants.primaryTileColor,
              // fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          labelStyle: const TextStyle(
            color: AppConstants.primaryTileColor,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
          suffixIcon: MarkerMenu(
            markerIcon: player.userSymbol.markerIcon,
            availableSymbols: availableSymbols,
            onPressed: (String value) => onSymbolIconPressed(context, value),
          ),
        ),
        style: const TextStyle(
          color: AppConstants.primaryTileColor,
        ),
      ),
    );
  }

  void onSymbolIconPressed(BuildContext context, String value) {
    context.read<GameEntryBloc>().add(
          GameEntrySymbolSelectedEvent(
            playerNum: player.playerNum,
            selectedSymbolKey: value,
          ),
        );
  }
}
