import 'dart:convert';
import 'dart:developer';

import 'package:base_services/base_services.dart';

import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/data/data.dart';

import 'package:rxdart/subjects.dart';

/// The `ScorebookRepository` provides a streamed state
/// to blocs containing the current and all saved games.
///
class ScorebookRepository extends AppBaseRepository {
  ScorebookRepository({
    required StorageServiceApi storageService,
  }) : _storageService = storageService {
    initRepository();
  }

  final StorageServiceApi _storageService;

  /// ScorebookData Stream Controller
  ///
  final _scorebookDataStreamController = BehaviorSubject<ScorebookData>.seeded(
    const ScorebookData(),
  );

  Stream<ScorebookData> get scorebookDataStream => _scorebookDataStreamController;

  ScorebookData get currentScorebookData => _scorebookDataStreamController.value;

  void processScorebookData(ScorebookData finalScorebookData) {
    scorebookDataVarsToStorage(finalScorebookData);
    updateScorebookDataStream(finalScorebookData);
  }

  void updateGame(ScorebookData newScorebookData) {
    late final ScorebookData newScorebookDataTmp;

    /// If there are no more plays, nobody wins.
    var noMorePlays = false;

    // Check for full rows, columns, diagonals, or no more plays.
    // The (int, int) represents which row, column, or diagonal was filled, and the player ID.
    // > return (groupIndex, firstPlayerId);
    // @TODO: Update the board to relect the row, column, or diagonal that was filled.
    (int, int)? checkCols;
    (int, int)? checkDiags;

    final checkRows = newScorebookData.currentGame.gameBoardData.checkAllRows;
    if (checkRows != null) {
      // There's no need to check columns if a win was made in a row.
      checkCols = newScorebookData.currentGame.gameBoardData.checkAllCols;
      if (checkCols != null) {
        // There's no need to check diagonals if a win was made in a column.
        checkDiags = newScorebookData.currentGame.gameBoardData.checkAllDiags;
        if (checkDiags != null) {
          // There's no need to check for no more plays if a win was made from a diagonal.
          noMorePlays = newScorebookData.currentGame.gameBoardData.availableTileIndexes.isEmpty;
        }
      }
    }

    // Check for a win.
    if (checkRows != null || checkCols != null || checkDiags != null || noMorePlays) {
      //
      // Note: The last player to play is represented as
      //       the length of the `gameBoardData.plays` list minus 1.
      //
      //       The list length starts at 0.
      //       When the first play is made, the new length becomes 1,
      //         which represents the 2nd player in the `players` list (via a modulus calc).
      //       Ergo, the last player to play is the length of the list minus 1.
      //
      //   int get currentPlayerIndex => players.isEmpty ? -1 : gameBoardData.plays.length % players.length;
      //   int get currentPlayerId => players[currentPlayerIndex].playerId!;
      //
      final newGameData = newScorebookData.currentGame.endGame(
        winnerId: noMorePlays
            ? -1
            : newScorebookData
                    .currentGame
                    .players[newScorebookData.currentGame.gameBoardData.plays.length - 1]
                    .playerId ??
                -1,
      );

      /// The `gameId` switch to `-1` in the `currentGame.endGame` call
      /// triggers the `BlocListener` in the `GameEntryScreen`.
      newScorebookDataTmp = newScorebookData.endGame(newGameData);
    } else {
      newScorebookDataTmp = newScorebookData;
    }

    scorebookDataVarsToStorage(newScorebookDataTmp);
    updateScorebookDataStream(newScorebookDataTmp);
  }

  void updateScorebookDataStream(ScorebookData newScorebookData) {
    _scorebookDataStreamController.add(newScorebookData);
  }

  void dispose() {
    _scorebookDataStreamController.close();
  }

  @override
  void initRepository() {
    ///
    /// Get stored data.
    ///
    scorebookDataStorageToVars();
  }

  void printLocalStorage() {
    final keyListK = <String, Object?>{};

    for (final key in _storageService.storedKeys()) {
      keyListK[key] = _storageService.prefsGetString(key);
    }
    log('LocalStorage Start: ___________');
    log('$keyListK');
    log('LocalStorage End: ___________');
  }

  /// Update current vars from local storage.
  void scorebookDataStorageToVars() {
    try {
      final scorebookDataFromStorage = _storageService.prefsGetString(
        AppConstants.storageKeyScorebook,
      );
      if (scorebookDataFromStorage != null) {
        final scorebookDataTmp = ScorebookData.fromJson(
          json.decode(scorebookDataFromStorage) as Map<String, dynamic>,
        );

        /// Update the repository's stream with stored `ScorebookData`.
        updateScorebookDataStream(scorebookDataTmp);
      }
    } catch (err) {
      _catchErrors('scorebookDataStorageToVars', err.toString());
    }
  }

  /// Update local storage with current `scorebookData`.
  Future<void> scorebookDataVarsToStorage(ScorebookData scorebookData) async {
    final newScorebookData = json.encode(scorebookData.toJson());
    try {
      await _storageService.prefsSetString(
        key: AppConstants.storageKeyScorebook,
        value: newScorebookData,
      );
    } catch (err) {
      _catchErrors('scorebookDataVarsToStorage', err.toString());
    }
  }

  void _catchErrors(String eKey, String eMsg) {
    log('[scorebook_repository] [$eKey] $eMsg');
  }
}
