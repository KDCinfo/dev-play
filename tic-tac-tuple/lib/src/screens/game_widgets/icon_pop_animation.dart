import 'package:flutter/material.dart';

class IconPopAnimation extends StatelessWidget {
  IconPopAnimation({
    required this.size,
    required this.playerIcon,
    required this.controller,
    super.key,
  })  : scaleAnimation = TweenSequence(
          [
            TweenSequenceItem<double>(
              tween: Tween<double>(begin: 0.5, end: 2.5).chain(
                CurveTween(curve: Curves.easeOut),
              ),
              weight: 50,
            ),
            TweenSequenceItem<double>(
              tween: Tween<double>(begin: 2.5, end: 1).chain(
                CurveTween(curve: Curves.easeIn),
              ),
              weight: 50,
            ),
          ],
        ).animate(controller),
        fadeAnimation = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.easeIn,
          ),
        );

  final double size;
  final IconData? playerIcon;
  final Animation<double> controller;

  final Animation<double> scaleAnimation;
  final Animation<double> fadeAnimation;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(
            playerIcon,
            size: size * 0.75,
            color: Colors.yellowAccent.withOpacity(0.9),
            shadows: const [
              Shadow(
                offset: Offset(-4, -4),
                blurRadius: 14,
              ),
              Shadow(
                color: Colors.white54,
                offset: Offset(4, 4),
                blurRadius: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
