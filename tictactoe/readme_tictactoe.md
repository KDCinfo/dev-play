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
  Games => [userDataGame1, userDataGame2, ...]

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
[UserData]    UserId
[GameData]    UserId
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

[UserData]
  UserId
  User name
  IsHuman => true
  Games => [userDataGame1, userDataGame2, ...]
  wins => Games.where(userDataGame. && userDataGame.gameStatus == GameStatusComplete)

[GameData]
  GameId
  // UserId // More than one user can be in this GameData
  boardSize => 3 // Square: X or Y | 3 => 3x x 3y (= 9 tiles)
  Players => [user1, user2]
  dateCreated => DateTime,
  dateLastPlayed => DateTime,
  gameResults => {
    userScores => {
      userId1: score,
      userId2: score,
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
    userId,
    tileId,
    duration,
  }]
  usedTiles => Plays.where(tileId) // <Tiles>[]
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
> [User] => UserData
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
  --> players => List.of(playerList.forEach(UserData(name, symbol)))
  --> gameBoard => GameBoard(int edgeSize)
  --> gameData => [GameData](int gameId, <UserData>[] players, gameBoard)
  --> [GamePlay](gameData)
  --> [ScoreBook].initGame(gameData)

/// # Transient Data
/// Putting a quarter in the slot kicks off `GamePlay`
/// The bloc for the properties in this class should be hydrated.
[GamePlay](GameData gameData)
  + turn => Map<int, UserData> {[1], 2: userData} // 3, 1, 2, ...
  + gameData.plays.add(TurnPlayTile(userId, duration))
  + ScoreBook.update(gameData)
  // Callbacks to make ScoreBook calls; such as when a game is done

/// # Persisted Data
[ScoreBook]
  // Reminder to convert `int` keys to `string` when JSONifying.
  + allPlayers: Map<UserData>(userId: UserData).putIfAbsent(currentPlayers)
    // The symbol in here is irrelevant; this could just be a list of used names.
    // Unless we wanted to store a history of symbols used.
  + allGamesByUserId: Map<int, int>{ userId: gameId1 }
  + allGames: <int, GameData>{ gameId1: GameData, gameId2: GameData }.add(GameData)
  + updateGame(gameData) => allGames.updateWhere(gameData)
  + initGame(gameData.players) =>
      allGames.add(),
      allGamesByUserId.addAll(),
      allPlayers.putIfAbsent(),

/// # Persisted Data
[GameData](int gameId, <UserData>[] players, gameBoard)
  + gameId
  + dateCreated => DateTime,
  + dateLastPlayed => DateTime,
  + gameStatus => [GameStatus => GameStatusIP, GameStatusComplete]
  + plays => <TurnPlayTile>[].add(TurnPlayTile)
  + players => <Map<int, UserData>>[
    { userId1, userData1 }, { userId2, userData2 },
  ]
  + gameBoard
  + endGameScore => {
    userId1: score, // +1 for each game won; +0 for lost games.
    userId2: score,
    // userId3: score,
  }

[GameBoard](int edgeSize, List<TurnPlayTile>[] plays)
  // boardId // [Q] If there is only one `GameBoard` instance, and it is persisted
  //                within `GameData`, is there a need for an ID? [A] I don't believe so.
  - _boardSize => edgeSize * edgeSize
  get rowFilled => checkRows(_boardSize)
  get colFilled => checkCols(_boardSize)
  get diagFilled => checkDiags(_boardSize)
  get usedTiles => plays.where(play.tileId) // <Tiles>[]
  get availableTiles => _boardSize - usedTiles // <Tiles>[]

[TurnPlayTile]
  tileId
  userId,
  duration,
  occupiedBy => UserData(userId)

[UserData]
  userId // Users are created based on a given, non-existing name.
  //        Existing UserData symbols may be overridden when another user has the same symbol.
  //        User names and symbols used for players are stored within every `gameData.players`.
  //        The `id` used as a key in `allGamesByUserId` for game lookups is based on user names,
  //        not symbols. The symbols used for each name's game can be derived from
  //        looping through all `gameData.players`.
  userName
  UserSymbol => UserSymbolX, UserSymbolO, UserSymbolP // A user's symbol can change per game.
  PlayerType => PlayerTypeHuman, PlayerTypeBot // Non-OO: IsHuman => true

  // Players have no local profiles (enhancement feature?).
  // 2+ players can take turns playing, or 1 player with a bot.
  // User data is transient; games are not stored by user.
  // Individual game-based [UserData] instances are persisted within [GameData] in the [ScoreBook].
  // Games => [gameData1, gameData2, ...] // Subset of [ScoreBook]
  // wins => Games.where(userDataGame. && userDataGame.gameStatus == GameStatusComplete)

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


- Begin a New Game



- View Past Games

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------
