import 'package:dev_play_tictactuple/src/app_constants.dart';

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
        child: Center(
          child: SizedBox(
            height: 100,
            width: 120,
            child: LinearProgressIndicator(
              backgroundColor: AppConstants.primaryTileColor.withOpacity(0.7),
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.deepOrange.withOpacity(0.4),
              ),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ),
    );
  }
}
