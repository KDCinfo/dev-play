import 'package:dev_play_tictactuple/src/data/models/models.dart';
import 'package:dev_play_tictactuple/src/screens/game_widgets/game_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LinePainter', () {
    testWidgets('should paint a line when start and end positions are not null',
        (WidgetTester tester) async {
      const startIndex = 0;
      const endIndex = 1;

      final positions = TilePositionModel();

      final linePainter = LinePainter(
        startIndex: startIndex,
        endIndex: endIndex,
        positions: positions,
      );

      await tester.pumpWidget(
        CustomPaint(
          painter: linePainter,
        ),
      );

      expect(find.byType(CustomPaint), findsOneWidget);
    });

    test('should repaint when start or end index or positions change', () {
      const startIndex = 0;
      const endIndex = 1;

      // Replace with your actual TilePositionModel instance
      final positions = TilePositionModel();

      final linePainter = LinePainter(
        startIndex: startIndex,
        endIndex: endIndex,
        positions: positions,
        lineColor: Colors.red,
        strokeWidth: 20,
      );
      final oldDelegate = LinePainter(
        startIndex: startIndex,
        endIndex: endIndex,
        positions: positions,
        lineColor: Colors.red,
        strokeWidth: 20,
      );

      final shouldRepaint = linePainter.shouldRepaint(oldDelegate);

      expect(shouldRepaint, false);
      expect(linePainter.startIndex, equals(oldDelegate.startIndex));
      expect(linePainter.endIndex, equals(oldDelegate.endIndex));
      expect(linePainter.positions, equals(oldDelegate.positions));
      expect(linePainter.positions, same(oldDelegate.positions));
      expect(
        linePainter.positions.getPosition(startIndex),
        equals(oldDelegate.positions.getPosition(startIndex)),
      );
      expect(
        linePainter.positions.getPosition(endIndex),
        equals(oldDelegate.positions.getPosition(endIndex)),
      );
      expect(linePainter.lineColor, equals(oldDelegate.lineColor));
      expect(linePainter.strokeWidth, equals(oldDelegate.strokeWidth));
    });
  });
}
