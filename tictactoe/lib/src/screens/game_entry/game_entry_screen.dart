import 'package:dev_play_tictactoe/src/src.dart';

import 'package:flutter/material.dart';

class GameEntryScreen extends StatelessWidget {
  const GameEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          ///
          /// Determine available height minus static elements.
          final availableHeight = constraints.maxHeight - 60 - 40 - 10;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 30),
            child: availableHeight < 300
                // For landscape or small screens, we'll move the
                // board size and buttons to the right of the player list.
                ? const Column(
                    children: [
                      Expanded(
                        child: ColoredBox(
                          color: Colors.lightBlue,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GameTitleRow(),
                              SizedBox(height: 10),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(child: GameEntryNameList()),
                                    SizedBox(width: 20),
                                    SizedBox(
                                      width: 300,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          GameEntryBoardSizeRow(),
                                          SizedBox(height: 20),
                                          GameEntryButtonsRow(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : const SingleChildScrollView(
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
                  ),
          );
        }),
      ),
    );
  }
}
