import 'package:dev_play_tictactoe/src/app_constants.dart';

import 'package:flutter/material.dart';

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
          onPressed: () {},
          child: const Text(
            buttonPlayText,
            key: buttonPlayKey,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            buttonReset,
            key: buttonResetKey,
          ),
        ),
      ],
    );
  }
}
