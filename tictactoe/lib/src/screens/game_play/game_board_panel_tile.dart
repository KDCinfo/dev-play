import 'package:flutter/material.dart';

class GameBoardPanelTile extends StatelessWidget {
  const GameBoardPanelTile(
    this.index, {
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
            offset: Offset(2, 2),
            color: Color(0xFF800000),
            spreadRadius: -1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Center(
        child: Text(
          '$index',
          style: const TextStyle(
            color: Color(0xFFFFDDDD),
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
