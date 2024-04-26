import 'package:flutter/material.dart';

class GameEntryNameListRowInputName extends StatelessWidget {
  const GameEntryNameListRowInputName({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: 'John',
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }
}
