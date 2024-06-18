import 'package:dev_play_tictactuple/src/data/models/models.dart';

import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  LinePainter({required this.startIndex, required this.endIndex, required this.positions});

  final int startIndex;
  final int endIndex;
  final TilePositionModel positions;

  @override
  void paint(Canvas canvas, Size size) {
    final start = positions.getPosition(startIndex);
    final end = positions.getPosition(endIndex);

    if (start != null && end != null) {
      final paint = Paint()
        ..color = Colors.blue
        ..strokeWidth = 4.0
        ..style = PaintingStyle.stroke;

      canvas.drawLine(start, end, paint);

      debugPrint('[check] Drawing line from $start to $end');
    }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return startIndex != oldDelegate.startIndex ||
        endIndex != oldDelegate.endIndex ||
        positions != oldDelegate.positions;
  }

  /// Using `GlobalObjectKey`:
  ///
  /// Couldn't use this approach because all tiles performed the 'play' animation.
  ///
  // @override
  // void paint(Canvas canvas, Size size) {
  //   // Using `ValueKey`: The getter 'currentContext' isn't defined for the type 'ValueKey<String>'.
  //   final startBox = startIndex.currentContext?.findRenderObject() as RenderBox?;
  //   final endBox = endIndex.currentContext?.findRenderObject() as RenderBox?;
  //
  //   if (startBox != null && endBox != null) {
  //     final start = startBox.localToGlobal(Offset.zero);
  //     final end = endBox.localToGlobal(Offset.zero);
  //
  //     final paint = Paint()
  //       ..color = Colors.red
  //       ..strokeWidth = 4.0
  //       ..style = PaintingStyle.stroke;
  //
  //     canvas.drawLine(start, end, paint);
  //   }
  // }
  //
  // @override
  // bool shouldRepaint(LinePainter oldDelegate) {
  //   return startIndex != oldDelegate.startIndex || endIndex != oldDelegate.endIndex;
  // }
}
