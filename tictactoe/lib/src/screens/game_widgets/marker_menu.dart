import 'dart:developer';

import 'package:dev_play_tictactoe/src/app_constants.dart';

import 'package:flutter/material.dart';

class MarkerMenu extends StatelessWidget {
  MarkerMenu({
    super.key,
    this.markerIcon = const Icon(Icons.list),
  });

  final Icon? markerIcon;
  final _menuController = MenuController();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _menuController.isOpen ? _menuController.close() : _menuController.open();
      },
      icon: MenuAnchor(
        controller: _menuController,
        consumeOutsideTap: true,
        menuChildren: [
          // Skip the first entry because it is used for empty slots.
          ...AppConstants.markerList.entries.skip(1).map((MapEntry<String, Icon> entry) {
            return ConstrainedBox(
              constraints: const BoxConstraints.tightFor(height: AppConstants.markerSize * 1.5),
              child: MenuItemButton(
                // @TODO: Testing this will be done with a Bloc.
                onPressed: () {
                  log(entry.key);
                  _menuController.close();
                },
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    border: Border(
                      top: BorderSide(color: Colors.black38),
                      bottom: BorderSide(color: Colors.black38),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: Text(
                      entry.key, // Marker
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: AppConstants.markerFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
        child: markerIcon,
      ),
    );
  }
}
