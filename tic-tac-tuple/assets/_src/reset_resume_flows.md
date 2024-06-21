# Game over -> Start new game

> lib.src.screens.game_entry.game_entry_screen.GameEntryScreen.build

  ```dart
  BlocListener<GamePlayBloc, GamePlayState>(
    listenWhen: (previous, current) =>
        previous.currentGame.gameStatus != current.currentGame.gameStatus &&
        current.currentGame.gameStatus == const GameStatusComplete(),
    listener: (context, state) async {
      await gameEndProcess(context);
  ```

> lib.src.screens.game_entry.game_entry_screen.GameEntryScreen.gameEndProcess

  ```dart
    Future<void> gameEndProcess(BuildContext context) async {
      await showDialog<void>(
          return AlertDialog(
      ).then<void>((_) {
        context.read<GamePlayBloc>().add(const GamePlayResetGameEvent());
  ```

> lib.src.data.blocs.game_play.game_play_event

  ```dart
  class GamePlayResetGameEvent extends GamePlayEvent {
    const GamePlayResetGameEvent();
  ```

> lib.src.data.blocs.game_play.game_play_bloc.GamePlayBloc

  ```dart
  on<GamePlayResetGameEvent>(_resetGameData);
  ```

> lib.src.data.blocs.game_play.game_play_bloc.GamePlayBloc._resetGameData

  ```dart
  void _resetGameData(GamePlayResetGameEvent event, Emitter<GamePlayState> emit) {
    final newScorebookData = _scorebookRepository
      .currentScorebookData
      .resetGame(state.currentGame);
    _scorebookRepository.processScorebookData(newScorebookData); // Store scorebookData in stream and local storage.
  ```

> lib.src.data.models.scorebook_data.ScorebookData.resetGame

  ```dart
  ScorebookData resetGame(GameData gameData) {
    return copyWith(
      currentGame: GameData(
        players: gameData.players,
  ```

# Return Home (Pause Game)

> lib.src.screens.game_board.game_board_button_panel.GameBoardButtonPanel.build

  ```dart
  onPressed: () {
    returnHome(context);
  ```

> lib.src.screens.game_board.game_board_button_panel.GameBoardButtonPanel.returnHome

  ```dart
  void returnHome(BuildContext context) {
    // The `currentGame` will be stored in `pausedGame` to allow for pausing the game.
    // This is primarily to preserve its `gameId` before being reset to `-1`.
    final currentGameData = context.read<GamePlayBloc>().state.currentGame;

    // All this reset call does is reset the `gameId` to `-1`.
    final resetGameData = GameData.resetGame(currentGameData);

    context.read<GamePlayBloc>().add(
          GamePlayReturnHomeEvent(
            gameDataPaused: currentGameData,
            gameDataReset: resetGameData,
  ```

> lib.src.data.blocs.game_play.game_play_event.GamePlayReturnHomeEvent

  ```dart
  class GamePlayReturnHomeEvent extends GamePlayEvent {
    const GamePlayReturnHomeEvent({
      required this.gameDataReset,
      required this.gameDataPaused,
  ```

> lib.src.screens.game_entry.game_entry_screen.GameEntryScreen.build

  ```dart
  BlocListener<GamePlayBloc, GamePlayState>(
    listenWhen: (previous, current) =>
        previous.currentGame.gameId != current.currentGame.gameId,
    listener: (context, state) async {
      if (state.currentGame.gameId > -1) {
        await Navigator.pushNamed(context, '/play');
      } else {
        // Pop to root.
        Navigator.popUntil(context, (route) => route.isFirst);
      }
  ```

# Resume Game

> lib.src.screens.game_entry.game_entry_buttons_row.GameEntryButtonsRow.build

  ```dart
  TextButton(
    onPressed: () => resumeGame(context),
    child: const Text(
      buttonResume,
  ```

> lib.src.screens.game_entry.game_entry_buttons_row.GameEntryButtonsRow.resumeGame

  ```dart
  void resumeGame(BuildContext context) {
    context.read<GameEntryBloc>().add(const GameEntryResumeGameEvent());
  }
  ```

> lib.src.data.blocs.game_entry.game_entry_event.GameEntryResumeGameEvent

  ```dart
  class GameEntryResumeGameEvent extends GameEntryEvent {
    const GameEntryResumeGameEvent();
    @override
    List<Object> get props => [];
  }
  ```

> lib.src.data.blocs.game_entry.game_entry_bloc.GameEntryBloc

  ```dart
  on<GameEntryResumeGameEvent>(_resumeGameData);
  ```

> lib.src.data.blocs.game_entry.game_entry_bloc.GameEntryBloc._resumeGameData

  ```dart
  void _resumeGameData(
    GameEntryResumeGameEvent event,
    Emitter<GameEntryState> emit,
  ) {
    _scorebookRepository.resumeGame();
  ```

> lib.src.data.service_repositories.scorebook_repository.ScorebookRepository.resumeGame

  ```dart
  void resumeGame() {
    if (currentScorebookData.pausedGame == null) {
      return;
    }
    final newScorebookData = currentScorebookData.resumeGame(
      pausedGame: currentScorebookData.pausedGame!,
    );
    processScorebookData(newScorebookData);
  ```
