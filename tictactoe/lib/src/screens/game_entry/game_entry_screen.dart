import 'package:dev_play_tictactoe/src/src.dart';

import 'package:flutter/material.dart';

class GameEntry extends StatelessWidget {
  const GameEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Builder(builder: (context) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GameEntryTitleRow(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
