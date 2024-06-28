import 'package:dev_play_tictactuple/src/app_constants.dart';

import 'package:flutter/material.dart';

class ButtonUp extends StatelessWidget {
  const ButtonUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppConstants.primaryTileColor.withOpacity(0.5),
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: const [
          BoxShadow(color: Colors.white),
          BoxShadow(
            offset: Offset(2, 2),
            color: AppConstants.primaryTileColor,
            spreadRadius: -1,
            blurRadius: 4,
          ),
        ],
      ),
      child: const Text(
        'Settings',
        style: TextStyle(
          color: Color(0xFFFFDDDD),
        ),
      ),
    );
  }
}
