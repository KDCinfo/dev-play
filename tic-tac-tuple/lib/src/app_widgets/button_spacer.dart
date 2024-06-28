import 'package:flutter/material.dart';

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
