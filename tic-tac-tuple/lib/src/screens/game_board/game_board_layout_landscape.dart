import 'package:dev_play_tictactuple/src/screens/screens.dart';

import 'package:flutter/material.dart';

class GameBoardLayoutLandscape extends StatelessWidget {
  const GameBoardLayoutLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GameBoardPanel(),
            // edgeSize: 5
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GameTitleRow(),
                  SizedBox(height: 20),
                  GameBoardPlayerPanel(),
                  SizedBox(height: 20),
                  GameBoardButtonPanel(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
