import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/screens/game_widgets/game_widgets.dart';

import 'package:flutter/material.dart';

/// This waiting indicator is used in one-player games
/// where the player is waiting for the bot to make a move.
class WaitForBotIndicator extends StatefulWidget {
  const WaitForBotIndicator({
    required this.waitingOnBot,
    super.key,
  });

  final bool waitingOnBot;
  @override
  State<WaitForBotIndicator> createState() => _WaitForBotIndicatorState();
}

class _WaitForBotIndicatorState extends State<WaitForBotIndicator> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      key: AppConstants.ignorePointerKey,
      ignoring: !widget.waitingOnBot,
      child: AnimatedOpacity(
        opacity: widget.waitingOnBot ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 800),
        child: const Center(
          child: SizedBox(
            height: 100,
            width: 120,
            // child: StaticProgressIndicator(),
            child: AnimatedLinearProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
