import 'package:flutter/material.dart';

class TilePositionModel extends ChangeNotifier {
  final Map<int, Offset> _positions = {};

  void updatePosition(int index, Offset position) {
    _positions[index] = position;
    notifyListeners();
  }

  Offset? getPosition(int index) {
    return _positions[index];
  }
}
