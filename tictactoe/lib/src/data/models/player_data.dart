import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/data/models/models.dart';

import 'package:equatable/equatable.dart';

/// This class could also be referred to as `UserData`.
class PlayerData extends Equatable {
  const PlayerData({
    required this.playerNum,
    this.playerId,
    this.playerName = '',
    this.playerType = const PlayerTypeBot(),
    UserSymbol? userSymbol,
  }) : userSymbol = userSymbol ?? const UserSymbolEmpty();

  /// Instantiate from JSON.
  factory PlayerData.fromJson(Map<String, dynamic> json) {
    final playerNum = json['playerNum'] as int;
    final playerId = json['playerId'] as int?;
    final playerName = json['playerName'] as String;
    final playerType = PlayerType.fromJson(json['playerType'] as Map<String, dynamic>);
    final userSymbol = UserSymbol.fromJson(json['userSymbol'] as Map<String, dynamic>);

    return PlayerData(
      playerNum: playerNum,
      playerId: playerId,
      playerName: playerName,
      playerType: playerType,
      userSymbol: userSymbol,
    );
  }

  /// Convert to JSON.
  Map<String, dynamic> toJson() {
    return {
      'playerNum': playerNum,
      'playerId': playerId,
      'playerName': playerName,
      'playerType': playerType.toJson(),
      'userSymbol': userSymbol.toJson(),
    };
  }

  // Persistent: once set, should never change once played.
  final int? playerId;
  final String playerName;
  final PlayerType playerType;

  // Transient: can change per game.
  final int playerNum; // = 1; // 1, 2, 3, 4
  final UserSymbol userSymbol; // = UserSymbolEmpty();

  /// The label is used on the `TextFormField` as the `label`: 'Player $playerNum Name:'
  String get label => AppConstants.playerLabel(playerNum);

  PlayerData copyWith({
    int? playerNum,
    int? playerId,
    String? playerName,
    PlayerType? playerType,
    UserSymbol? userSymbol,
  }) {
    return PlayerData(
      playerNum: playerNum ?? this.playerNum,
      playerId: playerId ?? this.playerId,
      playerName: playerName ?? this.playerName,
      playerType: playerType ?? this.playerType,
      userSymbol: userSymbol ?? this.userSymbol,
    );
  }

  @override
  List<Object?> get props => [
        playerNum,
        playerId,
        playerName,
        playerType,
        userSymbol,
      ];
}
