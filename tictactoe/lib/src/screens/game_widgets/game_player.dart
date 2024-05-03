import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/screens/game_widgets/game_widgets.dart';

import 'package:equatable/equatable.dart';

class GamePlayer extends Equatable {
  const GamePlayer({
    required this.playerNum,
    this.playerId,
    this.playerName = '',
    this.playerType = const PlayerTypeBot(),
    UserSymbol? userSymbol,
  }) : userSymbol = userSymbol ?? const UserSymbolEmpty();

  // Persistent: once set, should never change once played.
  final int? playerId;
  final String playerName;
  final PlayerType playerType;

  // Transient: can change per game.
  final int playerNum; // = 1; // 1, 2, 3, 4
  final UserSymbol userSymbol; // = UserSymbolEmpty();

  /// The label is used on the `TextFormField` as the `label`: 'Player $playerNum Name:'
  String get label => AppConstants.playerLabel(playerNum);

  GamePlayer copyWith({
    int? playerId,
    String? playerName,
    PlayerType? playerType,
    UserSymbol? userSymbol,
  }) {
    return GamePlayer(
      playerNum: playerNum,
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
