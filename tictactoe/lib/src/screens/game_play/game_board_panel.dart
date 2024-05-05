import 'dart:developer';

import 'package:flutter/material.dart';

class GameBoardPanel extends StatelessWidget {
  const GameBoardPanel({super.key, this.edgeSize = 3});

  // @TODO: This will be derived from the `BlocBuilder` below.
  // In the meantime, we'll allow the value to be injected for testing.
  final int edgeSize; // = 3;

  @override
  Widget build(BuildContext context) {
    //
    // @TODO: Add a `BlocBuilder` here for `edgeSize`.
    //
    return LayoutBuilder(builder: (context, constraints) {
      /// Height and width should only be as big as the smallest size available.
      final smallestSize = constraints.maxWidth < constraints.maxHeight
          ? constraints.maxWidth
          : constraints.maxHeight;
      final tileCount = edgeSize * edgeSize;

      log('GameBoardPanel: edgeSize: $edgeSize, tileCount: $tileCount');

      return SizedBox(
        width: smallestSize,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: smallestSize,
            maxWidth: smallestSize,
          ),
          child: GridView.builder(
            itemCount: tileCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: edgeSize, // Number of columns.
              childAspectRatio: 1, // Aspect ratio of each tile.
            ),
            itemBuilder: (context, index) {
              return GridTile(
                child: PanelTile(index),
              );
            },
          ),
        ),
      );
    });
  }
}

class PanelTile extends StatelessWidget {
  const PanelTile(
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
            offset: Offset(2.0, 2.0),
            color: Color(0xFF800000),
            spreadRadius: -1.0,
            blurRadius: 4.0,
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
