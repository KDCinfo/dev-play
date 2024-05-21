import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/data/blocs/blocs.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameEntryBoardSizeRow extends StatelessWidget {
  const GameEntryBoardSizeRow({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const boardSizeLabel = AppConstants.boardSizeLabel;
    const boardSizeLabelKey = Key(AppConstants.boardSizeLabelKey);
    const boardSizes = AppConstants.boardSizes;
    const boardSizeSliderKey = Key(AppConstants.boardSizeSliderKey);

    const boardSizesOffset = AppConstants.boardSizesOffset;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            boardSizeLabel,
            key: boardSizeLabelKey,
            style: textTheme.headlineSmall,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var labelIndex = 0; labelIndex < boardSizes.length; labelIndex++)
                  Text(
                    boardSizes.elementAtOrNull(labelIndex) ?? '3x3',
                    key: Key(AppConstants.sliderLabelKey(labelIndex)),
                  ),
              ],
            ),
          ),
          BlocBuilder<GameEntryBloc, GameEntryState>(
            builder: (context, state) {
              return Slider(
                key: boardSizeSliderKey,
                value: state.edgeSize.toDouble() - boardSizesOffset,
                max: boardSizes.length.toDouble() - 1,
                onChanged: (value) {},
                onChangeEnd: (value) {
                  final edgeSize = value.toInt() + boardSizesOffset;
                  context.read<GameEntryBloc>().add(GameEntryEdgeSizeEvent(edgeSize: edgeSize));
                },
                divisions: boardSizes.length - 1,
              );
            },
          ),
        ],
      ),
    );
  }
}
