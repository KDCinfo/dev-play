import 'package:equatable/equatable.dart';

abstract interface class PlayerType extends Equatable {
  const PlayerType(this.playerType);
  final PlayerTypeEnum playerType;
  @override
  List<Object?> get props => [playerType];
}

class PlayerTypeHuman extends PlayerType {
  const PlayerTypeHuman() : super(PlayerTypeEnum.human);
}

class PlayerTypeBot extends PlayerType {
  const PlayerTypeBot() : super(PlayerTypeEnum.bot);
}

enum PlayerTypeEnum {
  human,
  bot,
}
