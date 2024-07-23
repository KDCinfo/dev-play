# game_board_panel
```dart
                                child: GridTile(
                                  // key: Key('grid-tile-$index'), // Assign a unique key
                                  // key: GlobalObjectKey('grid-tile-$index'), // Assign a unique key
                                  key: ValueKey('grid-tile-$index'), // Assign a unique key
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      // WidgetsBinding.instance.addPostFrameCallback((_) {
                                      //   final box = context.findRenderObject() as RenderBox?;
                                      //   final position = box?.localToGlobal(Offset.zero) ?? Offset.zero;
                                      //   context.read<TilePositionModel>().updatePosition(index, position);
                                      // });

                                      // WidgetsBinding.instance.addPostFrameCallback((_) {
                                      //   final box = context.findRenderObject() as RenderBox?;
                                      //   final position = box?.localToGlobal(Offset.zero) ?? Offset.zero;
                                      //   final size = box?.size ?? Size.zero;
                                      //   final centerPosition = position + Offset(size.width / 2, size.height / 2);
                                      //   context.read<TilePositionModel>().updatePosition(index, centerPosition);
                                      // });

                                      // WidgetsBinding.instance.addPostFrameCallback((_) {
                                      //   final box = context.findRenderObject() as RenderBox?;
                                      //   final position = box?.localToGlobal(Offset.zero) ?? Offset.zero;
                                      //   final size = box?.size ?? Size.zero;
                                      //   final gridPosition = context.findAncestorRenderObjectOfType<RenderBox>();
                                      //   final gridOffset = gridPosition?.localToGlobal(Offset.zero) ?? Offset.zero;
                                      //   final centerPosition = (position + Offset(size.width / 2, size.height / 2)) - gridOffset;
                                      //   context.read<TilePositionModel>().updatePosition(index, centerPosition);
                                      //   print('Tile $index: Position: $position, CenterPosition: $centerPosition, GridOffset: $gridOffset');
                                      // });

                                      // WidgetsBinding.instance.addPostFrameCallback((_) {
                                      //   final box = context.findRenderObject() as RenderBox?;
                                      //   final position = box?.localToGlobal(Offset.zero) ?? Offset.zero;
                                      //   final size = box?.size ?? Size.zero;
                                      //   final centerPosition = position + Offset(size.width / 2, size.height / 2);
                                      //   context.read<TilePositionModel>().updatePosition(index, centerPosition);
                                      //   debugPrint('Tile $index - Position: $position, Center: $centerPosition');
                                      // });

                                      // # All the same offsets
                                      // WidgetsBinding.instance.addPostFrameCallback((_) {
                                      //   final box = context.findRenderObject() as RenderBox?;
                                      //   final parentBox = context.findAncestorRenderObjectOfType<RenderBox>();
                                      //   if (box != null && parentBox != null) {
                                      //     final position = box.localToGlobal(Offset.zero);
                                      //     final parentPosition = parentBox.localToGlobal(Offset.zero);
                                      //     final relativePosition = position - parentPosition;
                                      //     final size = box.size;
                                      //     final centerPosition = relativePosition + Offset(size.width, size.height);
                                      //     context.read<TilePositionModel>().updatePosition(index, centerPosition);
                                      //     debugPrint(
                                      //       'Tile $index - Relative Position: $relativePosition, Center: $centerPosition',
                                      //     );
                                      //   }
                                      // });

                                      // WidgetsBinding.instance.addPostFrameCallback((_) {
                                      //   final box = context.findRenderObject() as RenderBox?;
                                      //   final parentBox = context.findAncestorRenderObjectOfType<RenderBox>();
                                      //   if (box != null && parentBox != null) {
                                      //     final position = box.localToGlobal(Offset.zero);
                                      //     final parentPosition = parentBox.localToGlobal(Offset.zero);
                                      //     final relativePosition = position - parentPosition;
                                      //     final size = box.size;
                                      //     final centerPosition = relativePosition + Offset(size.width / 2, size.height / 2);
                                      //     context.read<TilePositionModel>().updatePosition(index, centerPosition);
                                      //     // Log the positions for debugging
                                      //     debugPrint('[check] Parent Position: $parentPosition');
                                      //     debugPrint('[check] Tile $index - Position: $position, Relative Position: $relativePosition, Center: $centerPosition',
                                      //     );
                                      //   } else {
                                      //     if (box == null) {
                                      //       debugPrint('[check] box is null for tile $index');
                                      //     }
                                      //     if (parentBox == null) {
                                      //       debugPrint('[check] parentBox is null for tile $index');
                                      //     }
                                      //   }
                                      // });

                                      // WidgetsBinding.instance.addPostFrameCallback((_) {
                                      //   final box = context.findRenderObject() as RenderBox?;
                                      //   final gridBox = context.findAncestorRenderObjectOfType<RenderBox>();
                                      //   if (box != null && gridBox != null) {
                                      //     final position = box.localToGlobal(Offset.zero);
                                      //     final gridPosition = gridBox.localToGlobal(Offset.zero);
                                      //     final relativePosition = position - gridPosition;
                                      //     final size = box.size;
                                      //     final centerPosition = relativePosition + Offset(size.width / 2, size.height / 2);
                                      //     context.read<TilePositionModel>().updatePosition(index, centerPosition);
                                      //     // Log the positions for debugging
                                      //     debugPrint('[check] Grid Position: $gridPosition');
                                      //     debugPrint('[check] Tile $index - Global Position: $position, Relative Position: $relativePosition, Center: $centerPosition');
                                      //   }
                                      // });

                                      // WidgetsBinding.instance.addPostFrameCallback((_) {
                                      //   final box = context.findRenderObject() as RenderBox?;
                                      //   final gridBox = context.findAncestorRenderObjectOfType<RenderBox>();
                                      //   if (box != null && gridBox != null) {
                                      //     final position = box.localToGlobal(Offset.zero);
                                      //     final gridPosition = gridBox.localToGlobal(Offset.zero);
                                      //     final relativePosition = position - gridPosition;
                                      //     final size = box.size;
                                      //     final centerPosition = relativePosition + Offset(size.width / 2, size.height / 2);
                                      //     context.read<TilePositionModel>().updatePosition(index, centerPosition);
                                      //     // Log the positions for debugging
                                      //     debugPrint('[check] Grid Position: $gridPosition');
                                      //     debugPrint('[check] Tile $index - Global Position: $position, Relative Position: $relativePosition, Center: $centerPosition');
                                      //   }
                                      // });

                                      // Got cut off
                                      // WidgetsBinding.instance.addPostFrameCallback((_) {
                                      //   final box = context.findRenderObject() as RenderBox?;
                                      //   final gridPosition = context.read<TilePositionModel>().gridPosition;
                                      //   if (box != null && gridPosition != null) {
                                      //     final position = box.localToGlobal(Offset.zero);
                                      //     final relativePosition = position - gridPosition;
                                      //     final size = box.size;
                                      //     final centerPosition = relativePosition + Offset(size.width / 2, size.height / 2);
                                      //     context.read<TilePositionModel>().updatePosition(index, centerPosition);
                                      //     // Log the positions for debugging
                                      //     debugPrint('[check] Grid Position: $gridPosition');
                                      //     debugPrint('[check] Tile $index - Global Position: $position, Relative Position: $relativePosition, Center: $centerPosition');
                                      //   }
                                      // });

                                      // WidgetsBinding.instance.addPostFrameCallback((_) {
                                      //   final box = context.findRenderObject() as RenderBox?;
                                      //   final gridBox = context.findAncestorRenderObjectOfType<RenderBox>();

                                      //   if (box != null && gridBox != null) {
                                      //     final globalPosition = box.localToGlobal(Offset.zero);
                                      //     final relativePosition = gridBox.globalToLocal(globalPosition);
                                      //     final size = box.size;
                                      //     final centerPosition = relativePosition +
                                      //         Offset(size.width / 2, size.height / 2);

                                      //     context.read<TilePositionModel>().updatePosition(index, centerPosition);

                                      //     // Log the positions for debugging
                                      //     debugPrint('[check] Grid Position: ${gridBox.localToGlobal(Offset.zero)}');
                                      //     debugPrint('[check] Tile $index - Global Position: $globalPosition, Relative Position: $relativePosition, Center: $centerPosition');
                                      //   }
                                      // });

                                      // WidgetsBinding.instance.addPostFrameCallback((_) {
                                      //   final box = context.findRenderObject() as RenderBox?;
                                      //   final gridBox = context.findAncestorRenderObjectOfType<RenderBox>();
                                      //   debugPrint('[check] Tile $index');
                                      //   if (box != null && gridBox != null) {
                                      //     final globalPosition = box.localToGlobal(Offset.zero);
                                      //     debugPrint('[check] Global Position: $globalPosition');
                                      //     // Draw a circle at this position
                                      //     DrawCircleOverlay(
                                      //       context: context,
                                      //       globalPosition: globalPosition,
                                      //       radius: 10,
                                      //       index: index,
                                      //     );
                                      //     final size = box.size;
                                      //     debugPrint('[check] Size $size');
                                      //     // final centerPosition = relativePosition + Offset(size.width / 2, size.height / 2);
                                      //     final centerPosition = Offset(
                                      //       globalPosition.dx,
                                      //       globalPosition.dy,
                                      //       // globalPosition.dx + (size.width / 2),
                                      //       // globalPosition.dy + (size.height / 2),
                                      //       // globalPosition.dx - (size.width / 2),
                                      //       // globalPosition.dy - (size.height / 2),
                                      //     );
                                      //     debugPrint('[check] globalPosition.dx | ${globalPosition.dx}');
                                      //     debugPrint('[check] size.width | ${size.width / 2}');
                                      //     debugPrint('[check] globalPosition.dy | ${globalPosition.dy}');
                                      //     debugPrint('[check] size.height | ${size.height / 2}');
                                      //     debugPrint('[check] Center: $centerPosition');
                                      //     context.read<TilePositionModel>().updatePosition(index, centerPosition);
                                      //     // Log the positions for debugging
                                      //     debugPrint('[check] Grid Position: ${gridBox.localToGlobal(Offset.zero)}');
                                      //   }
                                      // });

                                      // WidgetsBinding.instance.addPostFrameCallback((_) {
                                      //   final box = context.findRenderObject() as RenderBox?;
                                      //   final gridBox = context.findAncestorRenderObjectOfType<RenderBox>();
                                      //   if (box != null && gridBox != null) {
                                      //     final globalPosition = box.localToGlobal(Offset.zero);
                                      //     // final relativePosition = gridBox.globalToLocal(globalPosition);
                                      //     // final size = box.size;
                                      //     // final centerPosition = relativePosition + Offset(size.width / 2, size.height / 2);
                                      //     context.read<TilePositionModel>().updatePosition(index, globalPosition);
                                      //     // .updatePosition(index, centerPosition);
                                      //     debugPrint('[check] Tile $index - Global Position: $globalPosition');
                                      //     // debugPrint('[check] Tile $index - '
                                      //     //     'Global Position: $globalPosition, '
                                      //     //     'Relative Position: $relativePosition, '
                                      //     //     'Center: $centerPosition');
                                      //   }
                                      // });

                                            // final box = context.findRenderObject() as RenderBox?;
                                            // final gridBox = context.findRenderObject() as RenderBox?;
                                            // if (box != null && gridBox != null) {
                                            //   final globalPosition = box.localToGlobal(Offset.zero);
                                            //   final relativePosition = gridBox.globalToLocal(globalPosition);
                                            //   final size = box.size;
                                            //   final centerPosition = relativePosition + Offset(size.width / 2, size.height / 2);
                                            //   final offsetGlobal = Offset(
                                            //     globalPosition.dx + (size.width / 2),
                                            //     globalPosition.dy + (size.height / 2),
                                            //   );

                                            // final box = context.findRenderObject() as RenderBox?;
                                            // final gridBox = context.findAncestorRenderObjectOfType<RenderBox>();
                                            // if (box != null && gridBox != null) {
                                            //   final globalPosition = box.localToGlobal(Offset.zero);
                                            //   final relativePosition = gridBox.globalToLocal(globalPosition);
                                            //   final size = box.size;
                                            //   final centerPosition = globalPosition + Offset(size.width / 2, size.height / 2);

                                            // final box = tileKey.currentContext?.findRenderObject() as RenderBox?;
                                            // if (box != null) {
                                            //   final globalPosition = box.localToGlobal(Offset.zero);
                                            //   final size = box.size;
                                            //   final centerPosition = globalPosition + Offset(size.width / 2, size.height / 2);

                                      return Stack(
                                        children: [
                                          GameBoardPanelTile(index),
```
