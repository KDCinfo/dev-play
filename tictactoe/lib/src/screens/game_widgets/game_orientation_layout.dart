import 'package:dev_play_tictactoe/src/screens/game_widgets/game_widgets.dart';
import 'package:flutter/material.dart';

/// This widget is used to determine the layout of the
/// game screen based on the orientation of the device.
///
/// It will render the appropriate layout for any
/// `OrientationScreenWidget` passed in as a parameter,
/// such as `OrientationScreenGameEntry()` or `OrientationScreenGameBoard()`.
///
class GameOrientationLayout extends StatelessWidget {
  const GameOrientationLayout({
    super.key,
    required this.orientationScreen,
  });

  final OrientationScreenWidget orientationScreen; // = OrientationScreenGameEntry();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (
      BuildContext context,
      BoxConstraints maxConstraints,
    ) {
      /// Are these constrained to the device's width and height?
      final maxWidth = maxConstraints.maxWidth;
      final maxHeight = maxConstraints.maxHeight;

      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
          maxHeight: maxHeight,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 30),
          child: LayoutBuilder(builder: (context, checkConstraints) {
            /// Determine available height minus static elements.
            final availableHeight = checkConstraints.maxHeight - 60 - 40 - 10;

            return availableHeight < 300 // + 110 == 410
                /// For landscape or smaller screens, the GameEntry screen will have its
                /// board size and buttons to the right of the player list.
                ? orientationScreen.landscape
                : orientationScreen.portrait;
          }),
        ),
      );
    });
  }
}
