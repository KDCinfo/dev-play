import 'dart:developer';

import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/blocs/blocs.dart';
import 'package:dev_play_tictactuple/src/data/service_repositories/service_repositories.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameTitleRow extends StatelessWidget {
  const GameTitleRow({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final headlineLargeBold = textTheme
        .copyWith(
          headlineLarge: TextStyle(
            fontSize: textTheme.headlineLarge?.fontSize ?? 32.0,
            fontWeight: FontWeight.bold,
          ),
        )
        .headlineLarge;

    const screenTitle = AppConstants.appTitle;
    const titleKey = Key(AppConstants.appTitleKey);

    return InkWell(
      onTap: () {
        if (AppConstants.canPrint) {
          // Print both bloc states.
          log('GameEntryBloc state: ${context.read<GameEntryBloc>().state}');
          log('GamePlayBloc state: ${context.read<GamePlayBloc>().state}');

          // Print `currentScorebookData` in `scorebookRepository`.
          log(context.read<ScorebookRepository>().currentScorebookData.toString());

          // Print all local storage keys (i.e. `SharedPreferences`).
          context.read<ScorebookRepository>().printLocalStorage();
        }
      },
      child: Text(
        screenTitle,
        key: titleKey,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: headlineLargeBold?.copyWith(
              fontFamily: 'Quicksand', // Rounded
              color: Colors.yellow,
              shadows: [
                const Shadow(
                  color: AppConstants.primaryTileColor,
                  offset: Offset(1, 1),
                  blurRadius: 3,
                ),
              ],
            ) ??
            const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato',
            ),
      ),
    );
  }
}
