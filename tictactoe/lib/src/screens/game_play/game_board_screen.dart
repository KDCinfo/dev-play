import 'package:dev_play_tictactoe/src/screens/screens.dart';

import 'package:flutter/material.dart';

class GameBoardScreen extends StatelessWidget {
  const GameBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GameTitleRow(),
                SizedBox(height: 10),
                // GameBoardPanel(),
                SizedBox(height: 20),
                // GameBoardPlayerPanel(),
                SizedBox(height: 20),
                // GameBoardButtonsRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
