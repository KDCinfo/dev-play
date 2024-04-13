@4/12/2024 1:00:23 AM
- Trying to come up with a name for a public-facing (open source) dev folder
  for creating simple games and utility apps for my practicing app design, TDD, OOP, and SOLID.
  I may show these apps during interviews to show app development.

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

- Past reference for thought
  typing_tutor
```

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@
- Initial project thoughts:

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

- Project: Tic-Tac-Toe
  - Step 1: CRC
  - Step 2: TDD
  - Step 3: OOP
1 Use abstraction
2 Use inheritance
3 Use composition
4 Use design patterns
5 Use SOLID principles

Class types
  - abstract
  - abstract interface
  - mixin
  - extension
    Dart Classes Explained II - Inheritance(extends) vs. Abstraction(implements) vs. Mixins(with)
    https://youtu.be/OThpFGSzV1g?t=1743 | 12K views | 2 years ago | Dart - from Novice to Expert

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@4/12/2024 4:53:33 PM
- Project: TicTacToe
    Still pondering (on and off; more off than on)

@4/12/2024 7:33:16 PM
- Project: TicTacToe
    Finally just now thought of a couple class names I was having a hard time figuring out.

  There was an initial thought for an 'AllGames',
    but there is really no such thing as an 'all games',
    and in that train of thought, how are games recorded?
    ... ScoreBooks (or whatever they might be called).
  This then made senese because it can store GameData,
    and the GameData can represent both in-play games
    as well as archived games.

[Board]       Board(n) => n x n Tiles
[Tile]        occupiedBy => User? (nullables should be avoided; create an empty user instance)
[CurrentPlay] User 1 symbol (e.g. X)
[UserData]    UserId
[GameData]    UserId
[ScoreBook]   GameId => Map<int, GameData> // Reminder to convert `int` key to `string` when JSONifying.

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

# Schematic

- Need CRCs; then create.

Will be using draw.io for CRC cards.

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

## Explain it to CG4

- Never ended up posting or asking; just rubber ducked through it.

I am trying to break out (design) objects for a simple game.
  - The game can have 1 or more players; an 'auto' player can also be selected.
  - It is a turn-based game.
  - Games should be saved long term, and could be used to:
    - Show stats based on all games.
    - Restore any game, no matter if it is in progress or coompleted.

Where should game history be stored?
  - Individual user games? Should the players store their own games?
  - A more global, all-inclusive Map or List?

How do sports games results get recorded:
  - During the game, on the score board.
  - After the game, for persistence: in a score book? What gets logged?
    - Teams
    - Scores
    - Date played

  // Users => [] // Storing all users and all games will
  // Games => [] // slow down `.where` type calls as the lists grow (On).

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@4/13/2024 3:07:56 AM
- Dev Play

```
  > `flutter create tictactoe
    --description "Dev Play: Tic Tac Toe"
    --org "com.kdcinfo.tictactoe"
    --project-name "dev_play_tictactoe"
    -t skeleton`
```

- Created PSD and 1024 image

  > `dart run flutter_launcher_icons`

@4/13/2024 4:32:13 AM
@4/13/2024 4:54:54 AM
- Dev Play: 1 repo created; 3 commits

  [dev-play]

  > This `DevPlay` repository is intended for creating simple open source
  > Flutter app games and utilities for practicing app design, TDD, OOP, and SOLID.

  - Initial commit for: [dev-play] tic tac toe
  - Updated readme.

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------
