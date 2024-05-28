import 'dart:developer';

import 'package:dev_play_tictactuple/src/data/models/models.dart';

import 'package:flutter/material.dart';

class MarkerMenu extends StatelessWidget {
  MarkerMenu({
    required this.availableSymbols,
    required this.onPressed,
    this.markerIcon = const Icon(Icons.list),
    super.key,
  });

  final Icon? markerIcon;
  final _menuController = MenuController();
  final MarkerListDef availableSymbols;
  final void Function(String) onPressed;

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
          ...availableSymbols.entries
              .where((entry) => entry.key != '?')
              .map((MapEntry<String, Icon> entry) {
            return ConstrainedBox(
              constraints: const BoxConstraints.tightFor(height: UserSymbol.markerSize * 1.5),
              child: MenuItemButton(
                onPressed: () {
                  log('MarkerMenu key: ${entry.key}');
                  _menuController.close();
                  onPressed(entry.key);
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
                        fontSize: UserSymbol.markerFontSize,
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
