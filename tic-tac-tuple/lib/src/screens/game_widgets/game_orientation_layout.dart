import 'package:dev_play_tictactuple/src/data/models/models.dart';

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
    required this.orientationScreen,
    super.key,
  });

  final OrientationScreenWidget orientationScreen; // = OrientationScreenGameEntry();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (
        BuildContext context,
        BoxConstraints maxConstraints,
      ) {
        // [Q] Are these constrained to the device's width and height?
        // [A] Yes.
        // Testing sizes:
        // - Size(299, 599)
        // - Size(599, 299)
        final maxWidth = maxConstraints.maxWidth;
        final maxHeight = maxConstraints.maxHeight;
        // const maxWidth = 599.0; // maxConstraints.maxWidth;
        // const maxHeight = 297.0; // maxConstraints.maxHeight;

        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 30),
            child: OrientationBuilder(
              builder: (context, orientation) {
                // The 'orientation checker' commented out below has the same
                // issue as the constraint logic in the solution below, which
                // is that when the keyboard appears, it changes the layout dimensions,
                // confusing smaller screen constraints into thinking the screen
                // is in landscape mode and swapping out the layouts.
                //
                // return orientation == Orientation.landscape
                //     ? orientationScreen.landscape
                //     : orientationScreen.portrait;
                //
                return LayoutBuilder(
                  builder: (context, checkConstraints) {
                    //
                    // Hack Solution: Do not calculate screen layout if the keyboard is up.
                    //                Note that this cripples landscape mode (noted below).
                    //
                    if (MediaQuery.of(context).viewInsets.bottom > 0) {
                      // Determine available height minus static elements.
                      final availableHeight = checkConstraints.maxHeight - 60 - 40 - 10;

                      return availableHeight < 300 // + 110 == 410
                          // For landscape or vertically-challenged devices, the
                          // `GameEntry` screen will have its board size and
                          // buttons placed to the right of the player list.
                          ? orientationScreen.landscape
                          : orientationScreen.portrait;
                    } else {
                      //
                      // @TODO: Find a way to detect the actual orientation of the device
                      //        (i.e. not based on the layout constraints).
                      //
                      // If in landscape mode, when the keyboard comes up,
                      //   the return below will cause the same issue as above.
                      //
                      // So in effect, landscape can only be used when playing
                      //   with the default names (i.e. cannot use `TextFormField`s).
                      //
                      return orientationScreen.portrait;
                      //
                      // Maybe we can store the portrait/landscape mode on initial load,
                      //   then only perform the logic above when the screen actually rotates.
                      //
                      // The fallacy of that is the orientation detection also
                      //   detects based on the view constraints (i.e. when the keyboard
                      //   comes up, it will still think the device flipped orientation).
                    }
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
