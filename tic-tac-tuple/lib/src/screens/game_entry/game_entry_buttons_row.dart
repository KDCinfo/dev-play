import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';

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

  void startNewGame(BuildContext context) {
    context.read<GameEntryBloc>().add(const GameEntryStartGameEvent());
  }

  void resetGame(BuildContext context) {
    context.read<GameEntryBloc>().add(const GameEntryResetGameEvent());
  }
}
