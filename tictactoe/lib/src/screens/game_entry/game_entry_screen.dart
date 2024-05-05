import 'package:dev_play_tictactoe/src/screens/game_entry/game_entry.dart';
import 'package:dev_play_tictactoe/src/screens/game_widgets/game_widgets.dart';
import 'package:flutter/material.dart';

class GameEntryScreen extends StatelessWidget {
  const GameEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GameOrientationLayout(
          orientationScreen: OrientationScreenGameEntry(),
        ),
      ),
    );
  }
}

class GameEntryLayoutPortrait extends StatelessWidget {
  const GameEntryLayoutPortrait({
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

class GameEntryLayoutLandscape extends StatelessWidget {
  const GameEntryLayoutLandscape({
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
