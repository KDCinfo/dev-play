import 'package:dev_play_tictactoe/src/app_constants.dart';

import 'package:flutter/material.dart';

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

    return Text(
      screenTitle,
      key: titleKey,
      style: headlineLargeBold,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
    );
  }
}
