import 'dart:developer';

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

class ButtonSpacer extends StatelessWidget {
  const ButtonSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(
          width: 1.5,
          height: 50,
          // child: ColoredBox(
          //   color: Colors.white,
          // ),
        ),
        // SizedBox(
        //   width: 1,
        //   height: 50,
        //   child: ColoredBox(
        //     color: Colors.teal,
        //   ),
        // ),
        // SizedBox(
        //   width: 1,
        //   height: 50,
        //   child: ColoredBox(
        //     color: Colors.white,
        //   ),
        // ),
      ],
    );
  }
}

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

class AppButtonRow2 extends StatelessWidget {
  const AppButtonRow2({super.key});

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
        // border: Border.all(
        //   color: Colors.grey,
        //   width: 1,
        // ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          children: [
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
