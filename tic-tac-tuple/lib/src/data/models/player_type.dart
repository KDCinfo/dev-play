import 'package:dev_play_tictactuple/src/app_constants.dart';

import 'package:equatable/equatable.dart';

sealed class PlayerType extends Equatable {
  const PlayerType(this.playerType);

  final PlayerTypeEnum playerType;

  /// Convert to JSON.
  Map<String, dynamic> toJson() {
    return {
      'playerType': playerType.toString(),
    };
  }

  /// Instantiate from JSON.
  static PlayerType fromJson(Map<String, dynamic> json) {
    final playerType = json['playerType'] as String;

    switch (playerType) {
      case 'PlayerTypeEnum.human':
        return const PlayerTypeHuman();
      case 'PlayerTypeEnum.bot':
        return const PlayerTypeBot();
      default:
        throw Exception('Unknown PlayerType: $playerType');
    }
  }

  @override
  List<Object?> get props => [playerType];
}

class PlayerTypeHuman extends PlayerType {
  const PlayerTypeHuman() : super(PlayerTypeEnum.human);

  @override
  List<Object?> get props => [playerType];
}

class PlayerTypeBot extends PlayerType {
  const PlayerTypeBot() : super(PlayerTypeEnum.bot);

  @override
  List<Object?> get props => [playerType];
}
