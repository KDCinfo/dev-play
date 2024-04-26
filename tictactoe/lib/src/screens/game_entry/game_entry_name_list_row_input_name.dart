import 'dart:developer';

import 'package:flutter/material.dart';

class GameEntryNameListRowInputName extends StatelessWidget {
  const GameEntryNameListRowInputName({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // initialValue: 'John',
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Enter player name',
        suffixIcon: IconButton(
          icon: const Icon(Icons.list),
          iconSize: 20,
          alignment: Alignment.centerRight,
          onPressed: () async {
            /// Show popup menu for Markers ('x', 'o', '+').
            final marker = await showDialog<String>(
              context: context,
              builder: (context) {
                return PopupMenuButton<String>(
                  itemBuilder: (context) {
                    return const [
                      PopupMenuItem(
                        value: 'x',
                        child: Text('x'),
                      ),
                      PopupMenuItem(
                        value: 'o',
                        child: Text('o'),
                      ),
                      PopupMenuItem(
                        value: '+',
                        child: Text('+'),
                      ),
                    ];
                  },
                );
              },
            );
            if (marker != null) {
              log('Marker: $marker');
            }
          },
        ),
      ),
    );
  }
}
