import 'package:equatable/equatable.dart';

abstract class PlayerType extends Equatable {
  const PlayerType(this.playerType);

  final PlayerTypeEnum playerType;
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

enum PlayerTypeEnum {
  human,
  bot,
}
