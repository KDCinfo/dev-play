import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameEntryButtonsRow extends StatelessWidget {
  const GameEntryButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    const buttonPlayText = AppConstants.buttonPlayText;
    const buttonPlayKey = Key(AppConstants.buttonPlayKey);
    const buttonReset = AppConstants.buttonReset;
    const buttonResetKey = Key(AppConstants.buttonResetKey);

    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(elevation: 3),
          onPressed: () => startNewGame(context),
          child: Text(
            buttonPlayText,
            key: buttonPlayKey,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 24,
                ),
          ),
        ),
        TextButton(
          onPressed: () => resetGame(context),
          child: const Text(
            buttonReset,
            key: buttonResetKey,
          ),
        ),
      ],
    );
  }

  Future<void> startNewGame(BuildContext context) async {
    // Let's validate the fields.
    final validateMessage = validateFields(
      statePlayers: context.read<GameEntryBloc>().state.players,
      stateEdgeSize: context.read<GameEntryBloc>().state.edgeSize,
    );

    if (validateMessage.isEmpty) {
      context.read<GameEntryBloc>().add(const GameEntryStartGameEvent());
    } else {
      // Show a dialog with validation message.
      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            alignment: Alignment.bottomCenter,
            title: const Text(AppConstants.gameOverTitle),
            content: Text(
              // End each message with a carriage return.
              // Then display them all.
              validateMessage.join('\n'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(AppConstants.buttonStartNewGame),
              ),
            ],
          );
        },
      ).then<void>((_) {
        context.read<GamePlayBloc>().add(const GamePlayResetGameEvent());
      });
    }
  }

  void resetGame(BuildContext context) {
    context.read<GameEntryBloc>().add(const GameEntryResetGameEvent());
  }

  List<String> validateFields({
    required List<PlayerData> statePlayers,
    required int stateEdgeSize,
  }) {
    final messageList = <String>[];
    try {
      /// First let's remove the last player if the name is empty.
      final workingList = List<PlayerData>.of(statePlayers)
        ..removeWhere(
          (player) => player.playerNum == statePlayers.length && player.playerName.isEmpty,
        );

      /// Then let's ensure we have the proper data to start a game.
      /// - Edge size must be between 3-5.
      /// - The game must have between 2-4 players.
      /// - All players must have a name.
      /// - No two player names can be the same.
      ///
      if (stateEdgeSize < AppConstants.defaultEdgeSizeMin) {
        messageList.add(AppConstants.boardSizeMinMsg);
      }
      if (stateEdgeSize > AppConstants.defaultEdgeSizeMax) {
        messageList.add(AppConstants.boardSizeMaxMsg);
      }
      if (workingList.length < AppConstants.playerListMin) {
        messageList.add(AppConstants.playerListMinMsg);
      }
      if (workingList.length > AppConstants.playerListMax) {
        messageList.add(AppConstants.playerListMaxMsg);
      }
      if (workingList.any((player) => player.playerName.isEmpty)) {
        messageList.add(AppConstants.emptyNameMsg);
      }
      if (workingList.map((player) => player.playerName).toSet().length != workingList.length) {
        messageList.add(AppConstants.uniqueNameMsg);
      }
    } catch (e) {
      messageList.add(AppConstants.errorOccurredMsg);
      debugPrint('validateFields [catch]: $e');
    }
    return messageList;
  }
}
