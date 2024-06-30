import 'dart:developer';

import 'package:flutter/material.dart';

class PrePopScope extends StatelessWidget {
  const PrePopScope({
    required this.currentRoutePath,
    required this.child,
    super.key,
  });

  final String currentRoutePath;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    log('[pre_pop_scope] [build] [$currentRoutePath]');

    return PopScope(
      // canPop: !AppPaths.pathsToNotPop.contains(currentRoutePath),
      canPop: false,
      child: child,
      onPopInvoked: (bool didPop) async {
        log('[pre_pop_scope] [onPopInvoked] [$currentRoutePath] [$didPop]');

        if (didPop) {
          return;
        }

        final pathsToNotPop = ['/'];

        if (!pathsToNotPop.contains(currentRoutePath)) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
