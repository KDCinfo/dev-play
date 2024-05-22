# Dev-Play: TicTacToe

This file contains initial thoughts and notes for designing Tic Tac Toe with OOP.

My framework of choice for building mobile apps is Flutter (and Dart).

Although I use a PHP and MySQL back end for my [KD-reCall](https://kdrecall.com) apps, this app will be localized to a device.

Hindsight (2024-04-17):

~~Most~~ A lot of confusion with designing the classes stemmed from cross-designing for a game where players log in and have profiles.

This game is streamlined in which multiple users can play by sharing a device, and there are no profiles (users are semi-transient; generic 'named' users are created along the way instead).

Perhaps I should have started with persistent vs. transient data, and their sources.

-----

## Logs

@4/12/2024 1:00:23 AM
- Trying to come up with a name for a public-facing (open source) dev folder for creating simple games and utility apps for my practicing app design, TDD, OOP, and SOLID.
- I may show these apps during interviews to show app development.

```
  practice
  prototyping
  potfolio_
  programming_training

  app_training
* app_dev

  app_dev_training

* app_dev_playground
* app_playground
  dev_playground

  app_sandbox
  app_dev_sandbox

  app_fun
* app_craft
  app_dev_craft
* dev_craft
* app_play

** dev_play **

- Random past reference for thought (fun utilities)
  typing_tutor
```

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@
## Initial project thoughts:

- Project: Tic-Tac-Toe
  - Step 1: CRC

```
  .---.---.---.
  | X |   |   |
  |---+---+---|
  |   | X |   |
  |---+---+---|
  |   |   | X |
  '---.---.---'

  Board(n) => n x n Tiles

  Tile
  User 1 symbol (e.g. X)
  User 2 symbol (e.g. O)
  occupiedBy => User? (nullables should be avoided; create an empty user instance)

  // Users => [] // Storing all users and all games will
  // Games => [] // slow down `.where` type calls as the lists grow (On).

  User Data Object
  User ID
  User name
  IsHuman => true
  Games => [playerDataGame1, playerDataGame2, ...]

  User Data Games
  User ID
  Game ID
  User turn (e.g. 1, 2)
  Game status => [GameStatus => GameStatusIP, GameStatusWin, GameStatusLoss]

  App Scoring
  Game ID
  Players => [user1, user2]
  Game status => [IP, Win, Loss]
```

Research: starting a project using "CRC" "TDD" "OOP" "SOLID" flutter

```
- Project: Tic-Tac-Toe
  - Step 1: CRC
  - Step 2: TDD
  - Step 3: OOP
1 Use abstraction
2 Use inheritance
3 Use composition
4 Use design patterns
5 Use SOLID principles

Random thoughts on class types (re-studying; food for thought)
  - abstract
  - abstract interface
  - mixin
  - extension
    Dart Classes Explained II - Inheritance(extends) vs. Abstraction(implements) vs. Mixins(with)
    https://youtu.be/OThpFGSzV1g?t=1743 | 12K views | 2 years ago | Dart - from Novice to Expert
```

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@4/12/2024 4:53:33 PM
- Project: TicTacToe

Still pondering (on and off; more off than on)

@4/12/2024 7:33:16 PM
- Project: TicTacToe

Finally just now thought of a couple class names I was having a hard time figuring out.

There was an initial thought for an 'AllGames' class, but there is really no such thing as an 'all games' object, per se, and in that train of thought, how are games recorded?

... ScoreBooks (or whatever they might be called).

This then made senese because it can store GameData, and the GameData can represent both in-play games as well as archived games.

```
[Board]       Board(n) => n x n Tiles
[Tile]        occupiedBy => User? (nullables should be avoided; create an empty user instance)
[CurrentPlay] User 1 symbol (e.g. X)
[PlayerData]    PlayerId
[GameData]    PlayerId
[ScoreBook]   GameId => Map<int, GameData> // Reminder to convert `int` key to `string` when JSONifying.
```

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

## Initial Schematic

Need CRC cards, then tests, then code.

- Will be using draw.io for CRC cards.

```
[Board]
  _boardSize = n x n Tiles // Set when GameData created
  rowFilled => checkRows(_boardSize)
  colFilled => checkCols(_boardSize)
  diagFilled => checkDiags(_boardSize)

[Tile]
  occupiedBy => User? (nullables should be avoided; create an empty user instance)

[PlayerData]
  PlayerId
  User name
  IsHuman => true
  Games => [playerDataGame1, playerDataGame2, ...]
  wins => Games.where(playerDataGame. && playerDataGame.gameStatus == GameStatusComplete)

[GameData]
  GameId
  // PlayerId // More than one user can be in this GameData
  boardSize => 3 // Square: X or Y | 3 => 3x x 3y (= 9 tiles)
  Players => [user1, user2]
  dateCreated => DateTime,
  dateLastPlayed => DateTime,
  gameResults => {
    userScores => {
      playerId1: score,
      playerId2: score,
    }
  }
  User turn (e.g. 1, 2)
  gameStatus => [GameStatus => GameStatusIP, GameStatusComplete]
  UserSymbols => {
    user1 => 'X'
    user2 => 'O'
    // user3 => '+'
  }
  Plays => [{
    playerId,
    playerTurnId,
    duration,
  }]
  usedTiles => Plays.where(playerTurnId) // <Tiles>[]
  availableTiles => _boardSize - usedTiles // <Tiles>[]

[ScoreBook] => Map<int, GameData> // Reminder to convert `int` key to `string` when JSONifying.
  {
    gameId1: GameData,
    gameId2: GameData,
  }
```

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

**CG4 as a rubber duck**

I never ended up posting or asking any of this; just rubber ducked through it.

I am trying to break out (design) objects for a simple game.
- The game can have 1 or more players; an 'auto' player can also be selected.
- It is a turn-based game.
- Games should be saved long term, and could be used to:
  - Show stats based on all games.
  - Restore any game, no matter if it is in progress or completed.

Where should game history be stored?
- Individual user games? Should the players store their own games?
- A more global, all-inclusive Map or List?

How do sports games results get recorded:
- During the game, on the score board.
- After the game, for persistence: in a score book? What gets logged?
  - Teams
  - Scores
  - Date played

```
// Users => [] // Storing all users and all games in Lists will
// Games => [] // slow down `.where` type calls as the lists grow (On).
```

```
/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------
/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------
```

### Hybrid => Classes -> Walkthrough

Thinking through the flows, and what should update what.

(obsolete)

> [GamePlay](int boardSize) (thought: putting a quarter in the slot kicks off `GamePlay`)
  - -> Update: GameData
  - -> Update: GameBoard (adds a Tile to the GameBoard)
  - -> Update: User
  - -> Update: ScoreBook
> [GameData](<User>[] players)
> [GameBoard](int edgeSize)
  - -> [Tile]
> [User] => PlayerData
> [ScoreBook]

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

### Step-by-step Walkthrough

```
// [2024-04-17] I hesitate getting more granular here;
//              while the pseudo classes below are also getting more and more detailed.
```

- When a game is started:
  - Questions are asked:
    - Player names and symbols [1-4]
    - Board size [3-5]
  - GamePlay initializes the Game
    - GameData is initialized
      - Users are added
      - GameBoard is initialized
    - ScoreBook is initialized
- When a play is made:
  - GamePlay updates its instance properties
    - GameBoard is updated
      - A `Tile` is placed in the `GameBoard`.
    Is game won?
      - No
        - GameData is updated
        - User is updated
        - ScoreBook is updated
      - Yes
        - GameData is updated
        - All Users are updated
        - ScoreBook is updated
        - Close game

```
/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------
/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------
```

### Pseudo Classes (~~Latest~~ Final Draft)

@ is-a | has-a |

```dart
// [2024-04-17 @3:15 PM] At what point should the schematic below be moved to the next phase?
//                       It is not fully complete as it is getting more challenging to walk through the parts.

// Latest update: 2024-04-14 - ~hour+
// Latest update: 2024-04-15 - ~hour+
// Latest update: 2024-04-16 - ~1-2 hours
// Latest update: 2024-04-17 - ~1-2 hours
// Latest update: 2024-04-18 - 2 hours
// Latest update: 2024-04-19 - 2 hours | Consolidating and synchronizing:
//                -- Done with design? | [GameInit], [GamePlay], [ScoreBook], [GameData]

/// # Temporary Initialization Data
[GameInit]
  + Ask for - playerList [1-4]:
    - name(s) | or select from `ScoreBook.allPlayers`
    - symbol(s) | select from prefilled symbols list
  + Ask for board size (edgeSize) | Assert: 5 >= edgeSize[3] > players.length >= 1
  // edgeSize => 3 // Square: X or Y | 3 => 3x x 3y (= 9 tiles) | set when GameBoard created
  //
  // Note: With being able to play Tic Tac Toe with more than 3 edge tiles and more than 2 players,
  //       perhaps this app should be named
  //        - tic-tac-mo
  //        - tic-tac-toesies
  //        - tic-tac-titan
  //        - tic-tac-tuple

  /// Object Instantiation - Performed after initialization form (above) is submitted.
  --> gameId => ScoreBook.allGames.keys.last+1 // Get last `gameId` from `ScoreBook.allGames`
  --> players => List.of(playerList.forEach(PlayerData(name, symbol)))
  --> gameBoard => GameBoard(int edgeSize)
  --> gameData => [GameData](int gameId, <PlayerData>[] players, gameBoard)
  --> [GamePlay](gameData)
  --> [ScoreBook].initGame(gameData)

/// # Transient Data
/// Putting a quarter in the slot kicks off `GamePlay`
/// The bloc for the properties in this class should be hydrated.
[GamePlay](GameData gameData)
  + turn => Map<int, PlayerData> {[1], 2: playerData} // 3, 1, 2, ...
  + gameData.plays.add(PlayerTurn(playerId, duration))
  + ScoreBook.update(gameData)
  // Callbacks to make ScoreBook calls; such as when a game is done

/// # Persisted Data
[ScoreBook]
  // Reminder to convert `int` keys to `string` when JSONifying.
  + allPlayers: Map<PlayerData>(playerId: PlayerData).putIfAbsent(currentPlayers)
    // The symbol in here is irrelevant; this could just be a list of used names.
    // Unless we wanted to store a history of symbols used.
  + allGamesByPlayerId: Map<int, int>{ playerId: gameId1 }
  + allGames: <int, GameData>{ gameId1: GameData, gameId2: GameData }.add(GameData)
  + updateGame(gameData) => allGames.updateWhere(gameData)
  + initGame(gameData.players) =>
      allGames.add(),
      allGamesByPlayerId.addAll(),
      allPlayers.putIfAbsent(),

/// # Persisted Data
[GameData](int gameId, <PlayerData>[] players, gameBoard)
  + gameId
  + dateCreated => DateTime,
  + dateLastPlayed => DateTime,
  + gameStatus => [GameStatus => GameStatusIP, GameStatusComplete]
  + plays => <PlayerTurn>[].add(PlayerTurn)
  + players => <Map<int, PlayerData>>[
    { playerId1, playerData1 }, { playerId2, playerData2 },
  ]
  + gameBoard
  + endGameScore => {
    playerId1: score, // +1 for each game won; +0 for lost games.
    playerId2: score,
    // playerId3: score,
  }

[GameBoard](int edgeSize, List<PlayerTurn>[] plays)
  // boardId // [Q] If there is only one `GameBoard` instance, and it is persisted
  //                within `GameData`, is there a need for an ID? [A] I don't believe so.
  - _boardSize => edgeSize * edgeSize
  get rowFilled => checkRows(_boardSize)
  get colFilled => checkCols(_boardSize)
  get diagFilled => checkDiags(_boardSize)
  get usedTiles => plays.where(play.playerTurnId) // <Tiles>[]
  get availableTiles => _boardSize - usedTiles // <Tiles>[]

[PlayerTurn]
  playerTurnId
  playerId,
  duration,
  occupiedBy => PlayerData(playerId)

[PlayerData]
  playerId // Users are created based on a given, non-existing name.
  //        Existing PlayerData symbols may be overridden when another user has the same symbol.
  //        User names and symbols used for players are stored within every `gameData.players`.
  //        The `id` used as a key in `allGamesByPlayerId` for game lookups is based on user names,
  //        not symbols. The symbols used for each name's game can be derived from
  //        looping through all `gameData.players`.
  playerName
  UserSymbol => UserSymbolX, UserSymbolO, UserSymbolP // A user's symbol can change per game.
  PlayerType => PlayerTypeHuman, PlayerTypeBot // Non-OO: IsHuman => true

  // Players have no local profiles (enhancement feature?).
  // 2+ players can take turns playing, or 1 player with a bot.
  // User data is transient; games are not stored by user.
  // Individual game-based [PlayerData] instances are persisted within [GameData] in the [ScoreBook].
  // Games => [gameData1, gameData2, ...] // Subset of [ScoreBook]
  // wins => Games.where(playerDataGame. && playerDataGame.gameStatus == GameStatusComplete)

// + Ask for player symbol ['X', 'O', '+', '/', '^', '@', '$']
// + Ask for player symbol [
//  'X': close (clear_rounded)
//  'O':
//  '+':
//  '#':
//  '?':
//  '@':
//  '$': attach_money
// ]
[UserSymbol] abstract interface => // Dart 3 :+1:
  UserSymbolX implements UserSymbol => shape = 'X'
  UserSymbolO implements UserSymbol => shape = 'O'
  // UserSymbolP implements UserSymbol => shape = '+'
```

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

## Extracurricular Research

```
- Implementing complex UI with Flutter - Marcin Szałek | Flutter Europe
    Flutter was created to make beautiful apps but do we really know how to use it?
    When coming across complex designs we might think that they are impossible to implement
    or too difficult to handle without weeks of development. In this talk, I will show you
    how you can approach complex designs and translate them into widgets. We will look
    closely at some mobile designs, break them down and figure out how to code them.

  Flutter Europe | 16.9K subscribers | 9.6K
    297K views | 4 years ago | Flutter Europe talks
    https://www.youtube.com/watch?v=FCyoHclCqc8&t=1s&ab_channel=FlutterEurope
    Speaker: Marcin Szałek | fidev.io/complex-ui

                  AnimationController
                          /\      \
                         /  \     SingleTickerProviderStateMixin
                        /    \
                       /      \
                    [ Complex UI ]
                     /          \
                    /____________\
              Transform         Stack
                  /                \
      offset, scale, angle          Positioned
       transform
         ..translate
         ..rotateZ

  - Identify static elements
    'What matters' and 'what is a placeholder' and can be replaced
```

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

```
  .---.---.---.
  | X |   |   |
  |---+---+---|
  |   | X |   |
  |---+---+---|
  |   |   | X |
  '---.---.---'

  .---.---.---.---.
  | X |   |   | O |
  |---+---+---+---|
  |   | X | O |   |
  |---+---+---+---|
  |   | O | X |   |
  |---+---+---+---|
  | O |   |   | X |
  '---.---.---.---'

  .---.---.---.---.---.
  | X |   |   |   | O |
  |---+---+---+---+---|
  |   | X |   | O |   |
  |---+---+---+---+---|
  |   |   | X |   |   |
  |---+---+---+---+---|
  |   | O |   | X |   |
  |---+---+---+---+---|
  | O |   |   |   | X |
  '---.---.---.---.---'
```

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

## Naming Consistency

\lib\src\screens\game_entry\

  [0] game_entry_screen.dart                             | GameEntryScreen()
  [1] game_entry_title_row.dart                          | GameEntryTitleRow()
  [2] game_entry_name_list.dart                          | GameEntryNameList()
        game_entry_name_list_row.dart                    | GameEntryNameListRow()
          game_entry_name_list_row_input_name.dart       | GameEntryNameListRowInputName()
          game_entry_name_list_row_player_name_list.dart | GameEntryNameListRowPlayerNameList()
        game_entry_name_list_row.dart
          game_entry_name_list_row_input_name.dart
          game_entry_name_list_row_player_name_list.dart
  [3] game_entry_board_size_row.dart                     | GameEntryBoardSizeRow()
  [4] game_entry_buttons_row.dart                        | GameEntryButtonsRow()

--- Tests

\test\
  app_test.dart

\test\screens\game_entry\
  [0] game_entry_screen_test.dart                        | GameEntryScreen
  [1] game_entry_title_test.dart
  [2] game_entry_player_list_test.dart <-- Renamed to `game_entry_name_list` (changed 'player')
  [3] game_entry_board_size_test.dart
  [4] game_entry_buttons_test.dart

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

## Fix: GridView does not respect `SizedBox` or `ConstrainedBox`

> Use `Align` and `AspectRatio` instead.

- Thanks to ChatGPT4 for this solution.

    /// From: [ GameBoardPanel ]
    ///
    Widget build(BuildContext context) {
      //
      // @TODO: Add a `BlocBuilder` here for `edgeSize`.
      //
      return LayoutBuilder(builder: (context, constraints) {
        /// Height and width should only be as big as the smallest size available.
        final smallestSize = constraints.maxWidth < constraints.maxHeight
            ? constraints.maxWidth
            : constraints.maxHeight;
        final tileCount = edgeSize * edgeSize;

        log('GameBoardPanel: smallestSize: $smallestSize');
        log('GameBoardPanel: max W: [${constraints.maxWidth}] | H: [${constraints.maxHeight}]');
        log('GameBoardPanel: edgeSize: $edgeSize, tileCount: $tileCount');
        // [log] GameBoardLayoutLandscape: constraints: BoxConstraints(0.0<=w<=488.0, 0.0<=h<=303.4)
        // [log] GameBoardPanel: smallestSize: 224.0
        // [log] GameBoardPanel: max W: [224.0] | H: [303.42857142857144]
        // [log] GameBoardPanel: edgeSize: 5, tileCount: 25

        // return SizedBox(
        return Align(
          // width: smallestSize,
          // height: smallestSize,
          alignment: Alignment.center,
          // child: ConstrainedBox(
          child: AspectRatio(
            // constraints: BoxConstraints(
            //   maxHeight: smallestSize,
            //   maxWidth: smallestSize,
            // ),
            aspectRatio: 1,
            child: GridView.builder(

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------


- Begin a New Game

- View Past Games

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

[GameInit]

[GamePlay]

[ScoreBook]

[GameData]

[GameBoard]

[PlayerTurn]

[PlayerData]

[UserSymbol]

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

- [game_data]

      class GameData extends Equatable {

- [game_player] (a.k.a. `PlayerData`)

      class GamePlayer extends Equatable {

- [player_type]

      abstract class PlayerType extends Equatable {
      class PlayerTypeHuman extends PlayerType {
      class PlayerTypeBot extends PlayerType {
      enum PlayerTypeEnum {human, bot}

- [user_symbol]

      abstract class UserSymbol extends Equatable {
      class UserSymbolEmpty extends UserSymbol {
      class UserSymbolX extends UserSymbol {
      class UserSymbolO extends UserSymbol {
      class UserSymbolPlus extends UserSymbol {
      class UserSymbolStar extends UserSymbol {

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

/// # CRC Data and Flows

/// ## Temporary Initialization Data
[GameInit]
+ Ask for - playerList [1-4]:
  - name(s) | or select from `ScoreBook.allPlayers`
  - symbol(s) | select from prefilled symbols list
+ Ask for board size (edgeSize) | Assert: 5 >= edgeSize[3] > players.length >= 1

--> gameId => ScoreBook.allGames.keys.last+1 // Get last `gameId` from `ScoreBook.allGames`
--> players => List.of(playerList.forEach(PlayerData(name, symbol)))
--> gameBoard => GameBoard(int edgeSize)
--> gameData => [GameData](int gameId, <PlayerData>[] players, gameBoard)
--> [GamePlay](gameData)
--> [ScoreBook].initGame(gameData)

/// ## Transient Data
/// The bloc for the properties in this class should be hydrated.
[GamePlay](GameData gameData)
+ turn => Map<int, PlayerData> {[1], 2: playerData} // 3, 1, 2, ...
+ gameData.plays.add(PlayerTurn(playerId, duration))
+ ScoreBook.update(gameData)
// Callbacks to make ScoreBook calls; such as when a game is done

/// ## Persisted Data
[ScoreBook]
  // Reminder to convert `int` keys to `string` when JSONifying.
+ allPlayers: Map<PlayerData>(playerId: PlayerData).putIfAbsent(currentPlayers)
+ allGamesByPlayerId: Map<int, int>{ playerId: gameId1 }
+ allGames: <int, GameData>{ gameId1: GameData, gameId2: GameData }.add(GameData)
+ updateGame(gameData) => allGames.updateWhere(gameData)
+ initGame(gameData.players) =>
    allGames.add(),
    allGamesByPlayerId.addAll(),
    allPlayers.putIfAbsent(),

/// ## Persisted Data
[GameData](int gameId, <PlayerData>[] players, gameBoard)
  + gameId
  + dateCreated => DateTime,
  + dateLastPlayed => DateTime,
  + gameStatus => [GameStatus => GameStatusIP, GameStatusComplete]
  + plays => <PlayerTurn>[].add(PlayerTurn)
  + players => <Map<int, PlayerData>>[
    { playerId1, playerData1 }, { playerId2, playerData2 },
  ]
  + gameBoard
  + endGameScore => {
    playerId1: score, // +1 for each game won; +0 for lost games.
    playerId2: score,
  }

[GameBoard](int edgeSize, List<PlayerTurn>[] plays)
  - _boardSize => edgeSize * edgeSize
  get rowFilled => checkRows(_boardSize)
  get colFilled => checkCols(_boardSize)
  get diagFilled => checkDiags(_boardSize)
  get usedTiles => plays.where(play.playerTurnId) // <Tiles>[]
  get availableTiles => _boardSize - usedTiles // <Tiles>[]

[PlayerTurn]
  playerTurnId
  playerId,
  duration,
  occupiedBy => PlayerData(playerId)

[PlayerData]
  playerId
  playerNum
  playerName
  UserSymbol => UserSymbolX, UserSymbolO, UserSymbolP // A user's symbol can change per game.
  PlayerType => PlayerTypeHuman, PlayerTypeBot // Non-OO: IsHuman => true

// + Ask for player symbol ['X', 'O', '+', '/', '^', '@', '$']
[UserSymbol] abstract interface => // Dart 3 :+1:
  UserSymbolX implements UserSymbol => shape = 'X'
  UserSymbolO implements UserSymbol => shape = 'O'
  // UserSymbolP implements UserSymbol => shape = '+'

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

### Translating CRC and Data Flow to UI and State Management

1. **Identify UI Components**:
    Start by identifying which parts of your CRC and class design relate directly to user interaction.
    These will form the basis of your Flutter widgets.
    For instance, any class that involves user input or displays information can be considered for a corresponding widget.

2. **Map State Management**: Decide how you will manage state based on your CRC flow. In Flutter, state management could be done through various methods such as Provider, BLoC, Riverpod, etc. Consider which state management pattern fits best with your design:
   - **BLoC (Business Logic Component)**: Useful for separating business logic from UI. It can integrate neatly if your CRC includes clear responsibilities and interactions.
   - **Provider/Riverpod**: These are more straightforward for simpler state management and might be easier to implement initially.

3. **Detailing Data Flow**:
   - **Between UI and State Management**: Determine how data flows from your UI (widgets) to the state management solution and back. This includes triggering actions from the user interface, processing those actions in your business logic (which could be encapsulated in blocs or similar structures), and then updating the UI based on state changes.
   - **Between State Management and Repositories**: If your application involves more complex data handling (like network requests or local database interactions), you might need repositories. These will handle data fetching and sending, decoupling it from the business logic layers.

4. **Create Component Diagrams**: Similar to CRC cards but more focused on interaction and data flow, component diagrams can help visualize the relationship between UI components, state management, and backend services (if any). This helps in understanding how data moves through your system.

5. **Prototyping UI**: Start building the UI components in Flutter. Create simple versions of the widgets that represent the main interface elements. Use dummy data initially to ensure that the widgets are rendered as expected.

6. **Implement TDD for Each Layer**:
   - **UI Testing**: Write widget tests to ensure that the UI behaves as expected. This includes testing state changes, user interactions, and rendering.
   - **Logic Testing**: For your business logic (like blocs), write unit tests that test every function and scenario that can occur based on user actions and data handling.
   - **Integration Testing**: Once individual parts are tested, write integration tests that cover the flow from UI interaction through state management down to data handling.

7. **Iterative Development and Testing**: As you develop these components, continuously test and refine. TDD will guide the development process and ensure each part meets its requirements before moving on.

8. **Documentation and Refinement**: Keep documenting your progress and any changes from the original design. This documentation will be invaluable for future maintenance or further development.

By methodically building and testing each part of your application, you ensure that the final product is robust and meets the design specifications you have laid out in your CRC and class diagrams. This approach also allows you to catch and fix issues early in the development process, making it more manageable and less error-prone.

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@5/9/2024 12:03:38 AM
- Note: `genhtml` is NOT available for Windows (I have only ever run it on my Mac).

  - You can try running it through Cygwin.
  - The Coverage Gutters VS Code extension is nice, just wish it had an outline-like view for it
    (but then maybe it does, or will).
  - May check some other VS Code extensions.

@5/9/2024 12:40:21 AM
- Dev Play: Test Coverage Research - VS Code Extensions

## [Installed]

1) Coverage Gutters | ryanluker

 -  https://marketplace.visualstudio.com/items?itemName=ryanluker.vscode-coverage-gutters

2) Koverage | tenninebt

  - https://marketplace.visualstudio.com/items?itemName=tenninebt.vscode-koverage
  - Shows overall coverage by folder and file
  - Updated 7 months ago
    > https://github.com/tenninebt/vscode-koverage?tab=readme-ov-file#readme
    > https://raw.githubusercontent.com/tenninebt/vscode-koverage/master/Capture.gif

## [Not Installed]

  - https://marketplace.visualstudio.com/items?itemName=markis.code-coverage
  - Blends itself in with the Problems tab, which I would prefer not.

- VSCode LCOV | alexdima

  - https://marketplace.visualstudio.com/items?itemName=alexdima.vscode-lcov
  - Thought this looked line-by-line, but looks like it does have an overall view.
  - GitHub not updated in 7-8 years. :o | https://github.com/alexdima/vscode-lcov/tree/master

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

# Rows

Set   Tile Index
0     0           0 / 3 = 0
      1           1 / 3 = 0.3
      2           2 / 3 = 0.6
1     3           3 / 3 = 1
      4           4 / 3 = 1.3
      5           5 / 3 = 1.6
2     6           6 / 3 = 2
      7           7 / 3 = 2.3
      8           8 / 3 = 2.6

# Columns

Set   Tile Index
0     0           0 / 3 = 0
1     1           1 / 3 = 0.3
2     2           2 / 3 = 0.6

0     3           3 / 3 = 1
1     4           4 / 3 = 1.3
2     5           5 / 3 = 1.6

0     6           6 / 3 = 2
1     7           7 / 3 = 2.3
2     8           8 / 3 = 2.6

Set   Tile Index
0     0           0 / 3 = 0
0     3           3 / 3 = 1
0     6           6 / 3 = 2

1     1           1 / 3 = 0.3
1     4           4 / 3 = 1.3
1     7           7 / 3 = 2.3

2     2           2 / 3 = 0.6
2     5           5 / 3 = 1.6
2     8           8 / 3 = 2.6

0 1 2
3 4 5
6 7 8

for (var i = 0; i < boardSize; i += edgeSize + 1) {

[0] | 0 < 9 | 0 += 3 + 1 == [4]
[4] | 4 < 9 | 4 += 3 + 1 == [8]
[8] | 8 < 9 | 4 += 3 + 1 == [12] ! < 9

[ 0] |  0 < 25 | 0 += 5 + 1 == [ 6]
[ 6] |  6 < 25 | 6 += 5 + 1 == [12]
[12] | 12 < 25 | 12 += 5 + 1 == [18]
[18] | 18 < 25 | 18 += 5 + 1 == [24]
[24] | 24 < 25 | 24 += 5 + 1 == [30] ! < 25

for (var i = edgeSize - 1; i < boardSize - 1; i += edgeSize - 1) {

3 - 1 = [2] | 2 < (9 - 1) == 8 | 2 += 3 - 1 == [4]
        [4] | 4 <            8 | 4 += 3 - 1 == [6]
        [6] | 6 <            8 | 6 += 3 - 1 == [8] ! < 8

5 - 1 = [ 4] |  4 < (25 - 1) == 24 |  4 += 5 - 1 == [ 8]
        [ 8] |  8 <             24 |  8 += 5 - 1 == [12]
        [12] | 12 <             24 | 12 += 5 - 1 == [16]
        [16] | 16 <             24 | 16 += 5 - 1 == [20]
        [20] | 20 <             24 | 20 += 5 - 1 == [24] ! < 24

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

## Player List

Been analyzing and massaging the `GameEntryNameList` and tests.

Made outline of business logic in `GameEntryBloc`.

3 UI States:
  - players[2]; bot = 2 rows | default
  - players[3] = 3 rows | once 2nd field is typed in, 3rd row appears
  - players[4] = 4 rows | once 3rd field is typed in, 4th row appears

- Thoughts:
  -> 2nd row should have an option to change back to Bot.
  -> Or rather maybe just a 'reset' ... but which is already at the bottom.
  -> Maybe move the 'reset' up to be between the `PlayerList` and `BoardSize`.
        // [1-4] => 1 player in the list = 2 rows (with 3 elements each).
  -> [X] Add 'TicTacBot' to list of names, but ONLY for 2nd row.
  -> [X] Reset to 'TicTacBot' when game is started if names 2-4 are left empty.
  -> [X] Reset button at bottom will also reset the player list back to the default.

- Label
- TextFormField
  - Symbol
- Saved player list

- Bloc State
  - edgeSize: 3
  - players: [PlayerData(Human), PlayerData(Bot)] // Default
  - allSavedPlayerNames: <String>[] // 'TicTacBot' added to 2nd row

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------
