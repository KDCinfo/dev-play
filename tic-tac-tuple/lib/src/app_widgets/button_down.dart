import 'package:dev_play_tictactuple/src/app_constants.dart';

import 'package:flutter/material.dart';

class ButtonDown extends StatelessWidget {
  const ButtonDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.brown,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: const [
          BoxShadow(color: Color(0xFF400000)),
          BoxShadow(
            offset: Offset(3, 3),
            color: AppConstants.primaryTileColor,
            spreadRadius: -4,
            blurRadius: 6,
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
