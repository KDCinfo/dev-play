import 'dart:developer';

import 'package:dev_play_tictactuple/src/app_widgets/app_widgets.dart';

import 'package:flutter/material.dart';

class AppButtonRow1 extends StatelessWidget {
  const AppButtonRow1({super.key});

  void runTap() {
    log('Tapped');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.grey,
            width: 0,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: runTap,
              child: const ButtonUp(),
            ),
            const ButtonSpacer(),
            InkWell(
              onTap: runTap,
              child: const ButtonUp(),
            ),
            const ButtonSpacer(),
            InkWell(
              onTap: runTap,
              child: const ButtonDown(),
            ),
            const ButtonSpacer(),
            InkWell(
              onTap: runTap,
              child: const ButtonDown(),
            ),
          ],
        ),
      ),
    );
  }
}
