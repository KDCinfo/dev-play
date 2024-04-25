import 'package:flutter/material.dart';

class GameEntry extends StatelessWidget {
  const GameEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Builder(builder: (context) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Hello'),
          );
        }),
      ),
    );
  }
}
