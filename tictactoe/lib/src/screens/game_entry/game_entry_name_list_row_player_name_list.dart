import 'package:flutter/material.dart';

class GameEntryNameListRowPlayerNameList extends StatelessWidget {
  const GameEntryNameListRowPlayerNameList({super.key});

  @override
  Widget build(BuildContext context) {
    return const DropdownMenu<int>(
      // Hintext should be a label less than 10 characters
      hintText: 'Select',
      width: 125,
      dropdownMenuEntries: [
        /// 'Select from previous names:'
        DropdownMenuEntry(
          value: 0,
          label: 'Previously Played Names',
          enabled: false,
        ),
        DropdownMenuEntry(
          value: 1,
          label: 'JohnDoe',
        ),
        DropdownMenuEntry(
          value: 2,
          label: 'JaneSmith',
        ),
      ],
    );
  }
}
