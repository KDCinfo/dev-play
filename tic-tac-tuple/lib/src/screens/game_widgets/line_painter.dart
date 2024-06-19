import 'package:dev_play_tictactuple/src/data/models/models.dart';

import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  LinePainter({
    required this.startIndex,
    required this.endIndex,
    required this.positions,
    this.lineColor = Colors.lightBlueAccent,
    this.strokeWidth = 6.0,
  });

  final int startIndex;
  final int endIndex;
  final TilePositionModel positions;
  final Color lineColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final start = positions.getPosition(startIndex);
    final end = positions.getPosition(endIndex);

    if (start != null && end != null) {
      final paint = Paint()
        ..color = lineColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..colorFilter = const ColorFilter.mode(Colors.white54, BlendMode.overlay)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2)
        ..shader = RadialGradient(
          tileMode: TileMode.mirror,
          radius: 0.01,
          colors: [lineColor, Colors.transparent],
          stops: const [0.3, 1.0],
        ).createShader(
          Rect.fromCircle(center: start, radius: 12),
        );

      canvas.drawLine(start, end, paint);

      // Can't do stroke dashes or dots because hoirzontal lines are different
      //   from vertical lines which are both different from diagonals.
      // Would likely be better to use a package,
      //   but not really worth it for this particular project.
      // For now, will use a shader gradient to emulate dashes.
      //
      // const dashPx = 10;
      // const gapPx = 15;
      // var posX = start.dx;
      // final posY = start.dy;
      //
      // while (posX < size.width - 24) {
      // while (posX < end.dx) {
      //   canvas.drawLine(Offset(posX, posY), Offset(posX + dashPx, posY), paint);
      //   posX += dashPx + gapPx;
      // }

      // debugPrint('[check] Drawing line from $start to $end');
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
  /// Couldn't use this approach because all tiles performed the 'play' animation simultaneously.
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
