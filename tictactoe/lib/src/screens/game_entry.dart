import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/src.dart';

import 'package:flutter/material.dart';

class GameEntry extends StatelessWidget {
  const GameEntry({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        body: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppConstants.appTitle,
                      key: const Key(AppConstants.appTitleKey),
                      style: textTheme.headlineLarge,
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
