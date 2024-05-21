import 'package:base_services/base_services.dart';

import 'package:bloc_test/bloc_test.dart';

import 'package:dev_play_tictactoe/src/data/data.dart';

import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

class MockStorageAPI extends Mock implements StorageServiceApi {}

class MockScorebookRepository extends Mock implements ScorebookRepository {}

class MockGameEntryBloc extends MockBloc<GameEntryEvent, GameEntryState> implements GameEntryBloc {}

class MockGameEntryState extends Mock implements GameEntryState {}

/// Navigation Mocks

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockRoute extends Mock implements Route<void> {}

class FakeRoute extends Fake implements Route<void> {}

final playerListSingle = [
  const PlayerData(
    playerId: 0,
    playerNum: 1,
    playerName: 'Player 1',
    userSymbol: UserSymbolX(),
  ),
];

final playerList = List.of(playerListSingle)
  ..add(
    const PlayerData(
      playerId: 1,
      playerNum: 2,
      playerName: 'Player 2',
      userSymbol: UserSymbolO(),
    ),
  );

final playerListAddOne = List.of(playerList)
  ..add(
    const PlayerData(
      playerId: 2,
      playerNum: 3,
      playerName: 'Player 3',
      userSymbol: UserSymbolPlus(),
    ),
  );

final playerListAddFourth = List.of(playerListAddOne)
  ..add(
    const PlayerData(
      playerId: 3,
      playerNum: 4,
      playerName: 'Player 4',
      userSymbol: UserSymbolStar(),
    ),
  );
