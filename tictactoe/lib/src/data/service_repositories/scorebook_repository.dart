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

  void processNewGame(ScorebookData newScorebookData) {
    scorebookDataVarsToStorage(newScorebookData);
    updateScorebookDataStream(newScorebookData);
  }

  void processEndGame(ScorebookData finalScorebookData) {
    scorebookDataVarsToStorage(finalScorebookData);
    updateScorebookDataStream(finalScorebookData);
  }

  void updateGame(ScorebookData newScorebookData) {
    // Check for wins => (int, int)? => (row/col/diag, playerNum)
    final checkRows = newScorebookData.currentGame.gameBoardData.checkAllRows;
    final checkCols = newScorebookData.currentGame.gameBoardData.checkAllCols;
    final checkDiags = newScorebookData.currentGame.gameBoardData.checkAllDiags;
    final noMorePlays = newScorebookData.currentGame.gameBoardData.availableTileIndexes.isEmpty;
    late final ScorebookData newScorebookDataTmp;

    // Check for win or no more plays.
    if (checkRows != null || checkCols != null || checkDiags != null || noMorePlays) {
      final newGameData = newScorebookData.currentGame.copyWith(
        endGameScore: {},
        gameStatus: const GameStatusComplete(),
      );
      newScorebookDataTmp = newScorebookData.endGame(newGameData);
      // processNewGame(newScorebookDataTmp);
      // endGame(newScorebookDataTmp);
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
