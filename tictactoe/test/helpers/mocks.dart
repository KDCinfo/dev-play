import 'package:base_services/base_services.dart';

import 'package:bloc_test/bloc_test.dart';

import 'package:dev_play_tictactoe/src/data/data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockStorageAPI extends Mock implements StorageServiceApi {}

class MockScorebookRepository extends Mock implements ScorebookRepository {}

class MockGameEntryBloc extends MockBloc<GameEntryEvent, GameEntryState> implements GameEntryBloc {}

class MockGameEntryState extends Mock implements GameEntryState {}

/// Navigation Mocks

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockRoute extends Mock implements Route<void> {}

class FakeRoute extends Fake implements Route<void> {}

/// Bloc Mocks

class FakeBloc extends Fake implements Bloc<Object, Object> {}

class FakeEvent extends Fake implements Object {}

class FakeStackTrace extends Fake implements StackTrace {}

class FakeChange extends Fake implements Change<Object> {}

class FakeTransition extends Fake implements Transition<Object, Object> {}

/// Fake Data

final playerListSingle = [
  const PlayerData(
    playerId: 0,
    playerNum: 1,
    playerName: 'Player 1',
    userSymbol: UserSymbolX(),
    playerType: PlayerTypeHuman(),
  ),
];

// In `AppConstants.playerListDefault`,
// which is what the `GameEntryBloc` state
// is defaulted to, the 2nd player is a bot.
final playerList = List.of(playerListSingle)
  ..add(
    const PlayerData(
      playerId: 1,
      playerNum: 2,
      playerName: 'Player 2',
      userSymbol: UserSymbolO(),
      playerType: PlayerTypeHuman(),
    ),
  );

final playerListAddOne = List.of(playerList)
  ..add(
    const PlayerData(
      playerId: 2,
      playerNum: 3,
      playerName: 'Player 3',
      userSymbol: UserSymbolPlus(),
      playerType: PlayerTypeHuman(),
    ),
  );

final playerListAddFourth = List.of(playerListAddOne)
  ..add(
    const PlayerData(
      playerId: 3,
      playerNum: 4,
      playerName: 'Player 4',
      userSymbol: UserSymbolStar(),
      playerType: PlayerTypeHuman(),
    ),
  );
