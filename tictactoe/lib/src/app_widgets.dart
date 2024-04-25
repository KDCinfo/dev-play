import 'dart:developer';

import 'package:flutter/material.dart';

class ButtonUp extends StatelessWidget {
  const ButtonUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF800000).withOpacity(0.5),
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
          ),
          BoxShadow(
            offset: Offset(2.0, 2.0),
            color: Color(0xFF800000),
            spreadRadius: -1.0,
            blurRadius: 4.0,
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
  const ButtonDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.brown,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF400000),
          ),
          BoxShadow(
            offset: Offset(3.0, 3.0),
            color: Color(0xFF800000),
            spreadRadius: -4.0,
            blurRadius: 6.0,
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
              onTap: () {
                runTap();
              },
              child: const ButtonUp(),
            ),
            const ButtonSpacer(),
            InkWell(
              onTap: () {
                runTap();
              },
              child: const ButtonUp(),
            ),
            const ButtonSpacer(),
            InkWell(
              onTap: () {
                runTap();
              },
              child: const ButtonDown(),
            ),
            const ButtonSpacer(),
            InkWell(
              onTap: () {
                runTap();
              },
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
              onTap: () {
                runTap();
              },
              child: const ButtonUp(),
            ),
            const ButtonSpacer(),
            InkWell(
              onTap: () {
                runTap();
              },
              child: const ButtonDown(),
            ),
            const ButtonSpacer(),
            InkWell(
              onTap: () {
                runTap();
              },
              child: const ButtonDown(),
            ),
            const ButtonSpacer(),
            InkWell(
              onTap: () {
                runTap();
              },
              child: const ButtonDown(),
            ),
          ],
        ),
      ),
    );
  }
}