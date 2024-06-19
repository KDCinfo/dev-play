import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/data/models/models.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameBoardPlayerPanel extends StatelessWidget {
  const GameBoardPlayerPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth * 0.9,
          child: Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: BlocBuilder<GamePlayBloc, GamePlayState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      GameBoardPlayerPanelTitle(
                        playerCount: state.currentGame.players.length,
                      ),
                      const SizedBox(height: 8),
                      GameBoardPlayerPanelNames(
                        players: state.currentGame.players,
                        currentPlayerIndex:
                            state.currentGame.gameStatus == const GameStatusComplete()
                                ? state.currentGame.currentPlayerIndex == 0
                                    ? state.currentGame.players.length - 1
                                    : state.currentGame.currentPlayerIndex - 1
                                : state.currentGame.currentPlayerIndex,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

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

class GameBoardPlayerPanelNames extends StatelessWidget {
  const GameBoardPlayerPanelNames({
    required this.players,
    required this.currentPlayerIndex,
    super.key,
  });

  final List<PlayerData> players;
  final int currentPlayerIndex;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        for (var idx = 0; idx < players.length; idx++)
          Text(
            '[ ${players.elementAtOrNull(idx)?.playerName ?? 'Missing a name'} ]',
            style: TextStyle(
              fontWeight: idx == currentPlayerIndex ? FontWeight.bold : FontWeight.normal,
            ),
          ),
      ],
    );
  }
}
