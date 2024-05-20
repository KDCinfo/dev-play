// ignore_for_file: require_trailing_commas
import 'package:dev_play_tictactoe/src/data/data.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  late GameBoardData gameBoardData;
  late GameData gameData;
  late DateTime dateTime1;

  // Initialize players.
  late PlayerData player1;
  late PlayerData player2;

  // Initialize function variables at the same scope as players.
  late PlayerTurn Function({required int tileIndex, required int playerTurnId}) playPlayer1;
  late PlayerTurn Function({required int tileIndex, required int playerTurnId}) playPlayer2;

  group('[GameData]', () {
    setUp(() {
      player1 = const PlayerData(
        playerNum: 1,
        playerId: 0,
        playerName: 'Player 1',
        userSymbol: UserSymbolX(),
      );
      player2 = const PlayerData(
        playerNum: 2,
        playerId: 1,
        playerName: 'Player 2',
        userSymbol: UserSymbolO(),
      );

      playPlayer1 = ({required int tileIndex, required int playerTurnId}) => PlayerTurn(
            tileIndex: tileIndex,
            playerTurnId: playerTurnId,
            occupiedBy: player1,
          );
      playPlayer2 = ({required int tileIndex, required int playerTurnId}) => PlayerTurn(
            tileIndex: tileIndex,
            playerTurnId: playerTurnId,
            occupiedBy: player2,
          );
    });

    group('can be instantiated', () {
      test('when empty and should be a [GameData].', () {
        gameBoardData = const GameBoardData();
        gameData = const GameData();

        expect(gameData, isNotNull);
        expect(gameData, isA<GameData>());
        expect(gameData.gameId, -1);
        expect(gameData.players, isEmpty);
        expect(gameData.gameBoardData, gameBoardData);
        expect(gameData.endGameScore, isEmpty);
        expect(gameData.gameStatus, isA<GameStatusInProgress>());
      });

      test('when populated and should be a [GameData].', () {
        final testDate = DateTime(2024, 5, 15);
        gameBoardData = const GameBoardData();
        gameData = GameData(
          /// Initial properties.
          gameId: 0,
          dateCreated: testDate,
          // players: const [],

          /// Properties updated during the game.
          dateLastPlayed: testDate,
          gameBoardData: gameBoardData,

          /// Properties stored at the end of the game.
          endGameScore: const {0: 1},
          gameStatus: const GameStatusComplete(),
        );

        expect(gameData, isNotNull);
        expect(gameData, isA<GameData>());
        expect(gameData.gameId, 0);
        expect(gameData.dateCreated, testDate);
        expect(gameData.players, isEmpty);
        expect(gameData.dateLastPlayed, testDate);
        expect(gameData.gameBoardData, gameBoardData);
        expect(gameData.endGameScore, {0: 1}); // playerId: score
        expect(gameData.gameStatus, isA<GameStatusComplete>());
      });

      test('with correct [props] when empty.', () {
        //
        gameBoardData = const GameBoardData();

        gameData = const GameData();

        expect(
          gameData.props,
          equals([
            -1,
            null,
            <PlayerTurn>[],
            null,
            gameBoardData,
            <int, int>{},
            const GameStatusInProgress(),
          ]),
        );
      });

      test('with correct [props] when populated.', () {
        //
        final dateTime = DateTime(2024, 5, 8);
        gameBoardData = const GameBoardData();

        gameData = GameData(
          gameId: 0,
          dateCreated: dateTime,
          // players: const [],
          dateLastPlayed: dateTime,
          gameBoardData: gameBoardData,
          endGameScore: const {0: 1},
          gameStatus: const GameStatusComplete(),
        );

        expect(
          gameData.props,
          equals([
            0,
            dateTime,
            <PlayerTurn>[],
            dateTime,
            gameBoardData,
            <int, int>{0: 1},
            const GameStatusComplete(),
          ]),
        );
      });
    });

    group('[copyWith]:', () {
      setUp(() {
        dateTime1 = DateTime(2024, 5, 8);
        gameBoardData = const GameBoardData();
      });

      test('should copy available properties correctly.', () {
        const gameDataEmpty = GameData();

        final gameDataWithData = gameDataEmpty.copyWith(
          dateLastPlayed: dateTime1,
          gameBoardData: gameBoardData,
          endGameScore: const {1: 0},
          gameStatus: const GameStatusComplete(),
        );

        expect(gameDataWithData, isA<GameData>());

        // Initial properties that can't be copied using `copyWith`.
        expect(gameDataWithData.gameId, -1);
        expect(gameDataWithData.dateCreated, null);
        expect(gameDataWithData.players, isEmpty);

        // Properties that can be copied using `copyWith`.
        expect(gameDataWithData.dateLastPlayed, dateTime1);
        expect(gameDataWithData.gameBoardData, gameBoardData);
        expect(gameDataWithData.endGameScore, {1: 0});
        expect(gameDataWithData.gameStatus, isA<GameStatusComplete>());
      });
    });

    group('flows through', () {
      setUp(() {
        // The dateTime is set in the `startGame` method.
        dateTime1 = DateTime.now();
        gameBoardData = const GameBoardData();
      });

      test('[startGame], [playTurn], and [endGAme].', () {
        // This is just to initialize the game data when the app is started.
        // const gameData = GameData();

        ///
        /// Start the Game (when `GameEntry` is submitted)
        ///
        final updatedGameData0 = GameData.startGame(
          gameId: 1,
          players: [
            player1,
            player2,
          ],
          gameBoardData: gameBoardData,
        );

        ///
        /// Play #1
        ///
        final plays1 = List.of(updatedGameData0.gameBoardData.plays)
          ..add(playPlayer1(
            playerTurnId: 0,
            tileIndex: 0,
          ));
        final updatedGameData1 = updatedGameData0.playTurn(
          gameBoardData: gameBoardData.copyWith(plays: plays1),
        );

        ///
        /// Play #2
        ///
        final plays2 = List.of(updatedGameData1.gameBoardData.plays)
          ..add(playPlayer2(
            playerTurnId: 1,
            tileIndex: 2,
          ));
        final updatedGameData2 = updatedGameData1.playTurn(
          gameBoardData: gameBoardData.copyWith(plays: plays2),
        );

        ///
        /// End Game
        ///
        final updatedGameData3 = updatedGameData2.endGame(
          // Player 2 wins.
          endGameScore: {1: 1}, // playerId: score, // +1 for each game won
        );

        /// Game ID should never change.
        expect(updatedGameData1.gameId, 1);
        expect(updatedGameData2.gameId, 1);
        expect(updatedGameData3.gameId, 1);

        // The `dateCreated` should never change.
        expect(updatedGameData1.dateCreated, isA<DateTime>());
        expect(updatedGameData2.dateCreated, isA<DateTime>());
        expect(updatedGameData3.dateCreated, isA<DateTime>());
        expect(DateTime.now().difference(updatedGameData1.dateCreated!).inSeconds <= 2, isTrue);
        expect(DateTime.now().difference(updatedGameData2.dateCreated!).inSeconds <= 2, isTrue);
        expect(DateTime.now().difference(updatedGameData3.dateCreated!).inSeconds <= 2, isTrue);

        // Playing a turn updates `dateLastPlayed` to `DateTime.now()`.
        // We should expect a DateTime.now() within 2 seconds.
        expect(updatedGameData1.dateLastPlayed, isA<DateTime>());
        expect(updatedGameData2.dateLastPlayed, isA<DateTime>());
        expect(updatedGameData3.dateLastPlayed, isA<DateTime>());
        expect(DateTime.now().difference(updatedGameData1.dateLastPlayed!).inSeconds <= 2, isTrue);
        expect(DateTime.now().difference(updatedGameData2.dateLastPlayed!).inSeconds <= 2, isTrue);
        expect(DateTime.now().difference(updatedGameData3.dateLastPlayed!).inSeconds <= 2, isTrue);

        // Players never change.
        expect(updatedGameData1.players, [
          player1,
          player2,
        ]);
        expect(updatedGameData2.players, [
          player1,
          player2,
        ]);
        expect(updatedGameData3.players, [
          player1,
          player2,
        ]);

        // Game board data should be updated with each play.
        expect(updatedGameData1.gameBoardData.plays, [playPlayer1(playerTurnId: 0, tileIndex: 0)]);
        expect(updatedGameData1.gameBoardData, gameBoardData.copyWith(plays: plays1));
        expect(updatedGameData1.endGameScore, <int, int>{});
        expect(updatedGameData1.gameStatus, isA<GameStatusInProgress>());

        expect(updatedGameData2.gameBoardData.plays, [
          playPlayer1(playerTurnId: 0, tileIndex: 0),
          playPlayer2(playerTurnId: 1, tileIndex: 2)
        ]);
        expect(updatedGameData2.gameBoardData, gameBoardData.copyWith(plays: plays2));
        expect(updatedGameData2.endGameScore, <int, int>{});
        expect(updatedGameData2.gameStatus, isA<GameStatusInProgress>());

        /// `endGameScore` should be updated when the game is over.
        expect(updatedGameData3.gameBoardData.plays, [
          playPlayer1(playerTurnId: 0, tileIndex: 0),
          playPlayer2(playerTurnId: 1, tileIndex: 2)
        ]);
        expect(updatedGameData3.gameBoardData, gameBoardData.copyWith(plays: plays2));
        expect(updatedGameData3.endGameScore, {1: 1});
        expect(updatedGameData3.gameStatus, isA<GameStatusComplete>());
      });
    });
  });
}