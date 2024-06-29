import 'package:dev_play_tictactuple/src/screens/screens.dart';

import 'package:flutter/material.dart';

class GameEntryLayoutLandscape extends StatelessWidget {
  const GameEntryLayoutLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: GameEntryNameList(),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                GameTitleRow(),
                SizedBox(height: 10),
                GameEntryBoardSizeRow(),
                SizedBox(height: 20),
                Expanded(child: GameEntryButtonsRow()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
