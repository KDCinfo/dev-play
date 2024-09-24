import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:flutter/material.dart';

class AnimatedLinearProgressIndicator extends StatelessWidget {
  const AnimatedLinearProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: AppConstants.primaryTileColor.withValues(alpha: 0.7),
      valueColor: AlwaysStoppedAnimation<Color>(
        Colors.deepOrange.withValues(alpha: 0.4),
      ),
      borderRadius: BorderRadius.circular(50),
    );
  }
}
