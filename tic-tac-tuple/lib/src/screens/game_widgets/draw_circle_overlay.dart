import 'package:flutter/material.dart';

class DrawCircleOverlay {
  DrawCircleOverlay({
    required BuildContext context,
    required this.globalPosition,
    required this.radius,
    required this.index,
    this.color = Colors.red,
  }) {
    debugPrint('[check] Drawing circle at [ $globalPosition ] with radius [ $radius ]');

    final overlay = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: globalPosition.dx - radius,
          top: globalPosition.dy - radius,
          child: Container(
            width: radius * 2,
            height: radius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Text(
              index.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(overlay);

    // Future.delayed(const Duration(seconds: 1), overlay.remove);
  }

  final Offset globalPosition;
  final double radius;
  final int index;
  final Color color;
}
