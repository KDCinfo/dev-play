import 'dart:convert';
import 'dart:developer';

import 'package:base_services/base_services.dart';

import 'package:dev_play_tictactoe/src/app_constants.dart';
import 'package:dev_play_tictactoe/src/data/data.dart';

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
