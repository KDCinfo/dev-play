import 'package:dev_play_tictactoe/src/app_constants.dart';

import 'package:flutter/material.dart';

class GameEntryBoardSizeRow extends StatelessWidget {
  const GameEntryBoardSizeRow({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const boardSizeLabel = AppConstants.boardSizeLabel;
    const boardSizeLabelKey = Key(AppConstants.boardSizeLabelKey);
    const boardSizes = AppConstants.boardSizes;
    const boardSizeSliderKey = Key(AppConstants.boardSizeSliderKey);

    const sliderWidth = 200.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          boardSizeLabel,
          key: boardSizeLabelKey,
          style: textTheme.headlineMedium,
        ),
        const SizedBox(height: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: sliderWidth - 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var labelIndex = 0; labelIndex < boardSizes.length; labelIndex++)
                    Text(
                      boardSizes[labelIndex],
                      key: Key(AppConstants.sliderLabelKey(labelIndex)),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: sliderWidth,
              child: Slider(
                key: boardSizeSliderKey,
                value: 1,
                min: 1,
                max: boardSizes.length.toDouble(),
                onChanged: (value) {},
                divisions: boardSizes.length - 1,
              ),
            )
          ],
        )
      ],
    );
  }
}
