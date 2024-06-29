import 'package:flutter/material.dart';

class GameBoardPlayerPanelTitle extends StatelessWidget {
  const GameBoardPlayerPanelTitle({
    required this.playerCount,
    super.key,
  });

  final int playerCount;

  @override
  Widget build(BuildContext context) {
    return Text('Players: [ $playerCount ]');
  }
}
