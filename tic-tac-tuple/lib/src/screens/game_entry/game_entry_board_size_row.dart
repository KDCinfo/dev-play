import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameEntryBoardSizeRow extends StatefulWidget {
  const GameEntryBoardSizeRow({super.key});

  @override
  State<GameEntryBoardSizeRow> createState() => _GameEntryBoardSizeRowState();
}

class _GameEntryBoardSizeRowState extends State<GameEntryBoardSizeRow> {
  //
  late double currentBoardSize;

  final boardSizeLabel = AppConstants.boardSizeLabel;
  final boardSizeLabelKey = const Key(AppConstants.boardSizeLabelKey);
  final boardSizes = AppConstants.boardSizes;
  final boardSizeSliderKey = const Key(AppConstants.boardSizeSliderKey);
  final boardSizesOffset = AppConstants.boardSizesOffset;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentBoardSize = context.read<GameEntryBloc>().state.edgeSize.toDouble() - boardSizesOffset;
  }

  /// Update the board size, then persist the change to the bloc.
  void inputChangeCompleted(double value) {
    inputChanged(value);

    context.read<GameEntryBloc>().add(
          GameEntryEdgeSizeEvent(
            edgeSize: value.toInt() + boardSizesOffset,
          ),
        );
  }

  /// Update the current board size so the slider will reflect the change.
  void inputChanged(double value) {
    setState(() {
      currentBoardSize = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameEntryBloc, GameEntryState>(
      listenWhen: (previous, current) => previous.edgeSize != current.edgeSize,
      listener: (context, state) {
        setState(() {
          currentBoardSize = state.edgeSize.toDouble() - boardSizesOffset;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              boardSizeLabel,
              key: boardSizeLabelKey,
              style: AppConstants.headlineSmallTextStyle,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Container(
              width: MediaQuery.sizeOf(context).width * 0.4,
              height: 1,
              color: AppConstants.primaryTileColor.withValues(alpha: 0.1),
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
                  value: currentBoardSize,
                  max: boardSizes.length.toDouble() - 1,
                  onChanged: inputChanged,
                  onChangeEnd: inputChangeCompleted,
                  divisions: boardSizes.length - 1,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
