import 'package:dev_play_tictactoe/src/app_constants.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// UserSymbol => A user's symbol can change per game.
///
sealed class UserSymbol extends Equatable {
  const UserSymbol({required this.markerKey});

  /// Marker Keys for marker symbols:
  /// ['?', 'x', 'o', '+', '*']
  final String markerKey;

  Icon get markerIcon;

  /// Convert to JSON.
  Map<String, dynamic> toJson() {
    return {
      'markerKey': markerKey,
      // The `markerKey` is unique, so the `markerIcon` is not needed.
      // 'markerIcon': markerIcon.icon,
    };
  }

  /// Instantiate from JSON.
  static UserSymbol fromJson(Map<String, dynamic> json) {
    final markerKey = json['markerKey'] as String;

    switch (markerKey) {
      case '?':
        return const UserSymbolEmpty();
      case 'x':
        return const UserSymbolX();
      case 'o':
        return const UserSymbolO();
      case '+':
        return const UserSymbolPlus();
      case '*':
        return const UserSymbolStar();
      default:
        throw Exception('Unknown UserSymbol: $markerKey');
    }
  }
}

class UserSymbolEmpty extends UserSymbol {
  const UserSymbolEmpty() : super(markerKey: '?');

  @override
  Icon get markerIcon => AppConstants.markerList[markerKey] ?? const Icon(Icons.list);
  @override
  List<Object?> get props => [markerKey];
}

class UserSymbolX extends UserSymbol {
  const UserSymbolX() : super(markerKey: 'x');
  @override
  Icon get markerIcon => AppConstants.markerList[markerKey] ?? const Icon(Icons.close);
  @override
  List<Object?> get props => [markerKey];
}

class UserSymbolO extends UserSymbol {
  const UserSymbolO() : super(markerKey: 'o');
  @override
  Icon get markerIcon => AppConstants.markerList[markerKey] ?? const Icon(Icons.mood);
  @override
  List<Object?> get props => [markerKey];
}

class UserSymbolPlus extends UserSymbol {
  const UserSymbolPlus() : super(markerKey: '+');
  @override
  Icon get markerIcon => AppConstants.markerList[markerKey] ?? const Icon(Icons.favorite);
  @override
  List<Object?> get props => [markerKey];
}

class UserSymbolStar extends UserSymbol {
  const UserSymbolStar() : super(markerKey: '*');
  @override
  Icon get markerIcon => AppConstants.markerList[markerKey] ?? const Icon(Icons.star_border);
  @override
  List<Object?> get props => [markerKey];
}
