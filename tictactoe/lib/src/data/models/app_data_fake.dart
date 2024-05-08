import 'package:dev_play_tictactoe/src/data/models/models.dart';

abstract class AppDataFake {
  /// Only fully populated players can be in the list,
  ///   because they've played before.
  ///
  /// Reminder: `playerNum` and `userSymbol` are transient and do
  ///   not need to be unique for storing, only when playing.
  static final fakePlayerList3 = <PlayerData>[
    const PlayerData(
      playerId: 100, //                 Unique
      playerName: 'John', //            Unique
      playerNum: 1, //                  Not unique
      userSymbol: UserSymbolX(), //     Not unique
      playerType: PlayerTypeHuman(), // Not unique
    ),
    const PlayerData(
      playerId: 101,
      playerName: 'Jane',
      playerNum: 2,
      userSymbol: UserSymbolO(),
      playerType: PlayerTypeHuman(),
    ),
    const PlayerData(
      playerId: 102,
      playerName: 'Jim',
      playerNum: 1,
      userSymbol: UserSymbolX(),
      playerType: PlayerTypeHuman(),
    ),
  ];
}
