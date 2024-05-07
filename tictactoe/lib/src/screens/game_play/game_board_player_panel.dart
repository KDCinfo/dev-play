import 'package:flutter/material.dart';

class GameBoardPlayerPanel extends StatelessWidget {
  const GameBoardPlayerPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth * 0.9,
          child: const Card(
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                children: [
                  GameBoardPlayerPanelTitle(),
                  SizedBox(height: 8),
                  GameBoardPlayerPanelNames(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class GameBoardPlayerPanelTitle extends StatelessWidget {
  const GameBoardPlayerPanelTitle({super.key});

  @override
  Widget build(BuildContext context) {
    const playerCount = 2;

    // @TODO: Wrap with a `BlocBuilder`.
    return const Text('Players: [ $playerCount ]');
  }
}

class GameBoardPlayerPanelNames extends StatelessWidget {
  const GameBoardPlayerPanelNames({super.key});

  @override
  Widget build(BuildContext context) {
    const currentPlayer = 0;
    const players = <String>['John', 'Jane'];

    // @TODO: Wrap with a `BlocBuilder`.
    return Wrap(
      spacing: 10,
      children: [
        for (var idx = 0; idx < players.length; idx++)
          Text(
            '[ ${players.elementAtOrNull(idx) ?? 'Missing a name'} ]',
            style: TextStyle(
              fontWeight: idx == currentPlayer ? FontWeight.bold : FontWeight.normal,
            ),
          ),
      ],
    );
  }
}
