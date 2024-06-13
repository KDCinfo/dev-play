import 'package:dev_play_tictactuple/src/screens/game_widgets/game_widgets.dart';

import 'package:flutter/material.dart';

class IconPop extends StatefulWidget {
  const IconPop({
    required this.size,
    required this.playerIcon,
    super.key,
  });

  final double size;
  final IconData? playerIcon;

  @override
  State<IconPop> createState() => IconPopState();
}

class IconPopState extends State<IconPop> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconPopAnimation(
      size: widget.size,
      playerIcon: widget.playerIcon,
      controller: controller.view,
    );
  }
}
