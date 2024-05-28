import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';
import 'package:dev_play_tictactuple/src/pre_pop_scope.dart';
import 'package:dev_play_tictactuple/src/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The `OrientationScreenGameEntry()` class
/// that is provided as the `orientationScreen` parameter
/// injects both the [[Portrait]] and [[Landscape]] classes below.
///
class GameEntryScreen extends StatelessWidget {
  const GameEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrePopScope(
      currentRoutePath: '/',
      child: Builder(
        builder: (context) {
          return SafeArea(
            child: Scaffold(
              body: BlocListener<GamePlayBloc, GamePlayState>(
                listenWhen: (previous, current) =>
                    previous.currentGame.gameId != current.currentGame.gameId,
                listener: (context, state) {
                  if (state.currentGame.gameId > -1) {
                    Navigator.pushNamed(context, '/play');
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: const GameOrientationLayout(
                  orientationScreen: OrientationScreenGameEntry(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class GameEntryLayoutPortrait extends StatelessWidget {
  const GameEntryLayoutPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    /// This `Column` has a fixed size from within the `GameOrientationLayout()`.
    return const SingleChildScrollView(
      child: Column(
        children: [
          GameTitleRow(),
          SizedBox(height: 35),
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
