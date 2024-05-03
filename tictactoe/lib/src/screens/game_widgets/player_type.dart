abstract interface class PlayerType {
  const PlayerType(this.playerType);
  final PlayerTypeEnum playerType;
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
