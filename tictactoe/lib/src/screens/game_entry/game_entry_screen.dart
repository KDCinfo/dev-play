import 'package:dev_play_tictactoe/src/src.dart';

import 'package:flutter/material.dart';

class GameEntryScreen extends StatelessWidget {
  const GameEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(builder: (
          BuildContext context,
          BoxConstraints maxConstraints,
        ) {
          final maxWidth = maxConstraints.maxWidth;
          final maxHeight = maxConstraints.maxHeight;

          return ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
              maxHeight: maxHeight,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 30),
              child: LayoutBuilder(builder: (context, checkConstraints) {
                /// Determine available height minus static elements.
                final availableHeight = checkConstraints.maxHeight - 60 - 40 - 10;

                return availableHeight < 300 // + 110 == 410
                    // For landscape or small screens, we'll move the
                    // board size and buttons to the right of the player list.
                    ? const LayoutSmall()
                    : const LayoutLarge();
              }),
            ),
          );
        }),
      ),
    );
  }
}

class LayoutLarge extends StatelessWidget {
  const LayoutLarge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GameTitleRow(),
          SizedBox(height: 10),
          GameEntryNameList(),
          SizedBox(height: 20),
          GameEntryBoardSizeRow(),
          SizedBox(height: 20),
          GameEntryButtonsRow(),
        ],
      ),
    );
  }
}

class LayoutSmall extends StatelessWidget {
  const LayoutSmall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: constraints.maxHeight,
          maxWidth: constraints.maxWidth,
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GameTitleRow(),
            SizedBox(height: 10),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: GameEntryNameList(),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GameEntryBoardSizeRow(),
                              SizedBox(height: 20),
                              Expanded(child: GameEntryButtonsRow()),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
