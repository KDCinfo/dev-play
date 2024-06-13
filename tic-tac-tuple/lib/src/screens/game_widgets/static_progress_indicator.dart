import 'package:dev_play_tictactuple/src/app_constants.dart';

import 'package:flutter/material.dart';

/// This widget is a simple static indicator intended as a
/// replacement for bypassing the infinite animation widget.
///
class StaticProgressIndicator extends StatelessWidget {
  const StaticProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppConstants.primaryTileColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Center(
        child: Text(
          'Waiting...',
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
