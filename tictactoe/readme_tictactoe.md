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

@4/13/2024 4:32:13 AM<br>
@4/13/2024 5:20:49 AM
- Dev Play: 1 repo created; 3 commits

  [dev-play]

> This `DevPlay` repository is intended for creating simple open source

> Flutter app games and utilities for practicing app design, TDD, OOP, and SOLID.

- Initial commit for: [dev-play] tic tac toe
- Updated readme.

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

- Now, how do we store the data?

- AllGames => Map<int, GameData> // key: gameId

Need a:
  - > dart map with two lookup keys
  - > `=> Use a join table/map

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@4/13/2024 11:08:22 PM

- Structuring and persisting an app's multi-user game data over time (couple hours)

> See `Schematic` section above

Thinking through a question for CG4 (never asked):

> Using Dart 3, what might be the best way to structure class data based on the following pseudocode?

> Note: The data will be stored in local devices via Flutter's `SharedPreferences`.

A game = 2, 3, n `User`s => 1 `GameData`

Use cases:
  - -> allGames<gameId, GameData>
  - -> allGames<userId, GameData>
  - -> User.myGames<gameId, GameData>
  - -> User.myGames => <GameData>[]

## Solution

After pondering on this, I realized
  the issue with my premise for storing data was my conflating
  a 'multi-user' game with a 'multi-player' game.

The former could be a local game that allows for multiple users on one device.

The latter would apply to games played from multiple sources,
  where storage would reside in a central location, such as a remote database
  (consideration should be made for synchronization between local and remote server).

I am used to coding for users within my custom authenticated realm of KD-reCall.

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@4/14/2024 2:47:02 AM
- Dev Play: TicTacToe (hour or two)

    A bit more progress on class design.
      - Moved `GameBoard` inside `GameData`.
      - Feeling like `GameData` is getting kinda big.

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@4/15/2024 9:46:15 PM
- Dev Play: TicTacToe (hour or two)

  - Began a step-through process.

  - Created [GamePlay] because [GameData] was getting to big.

  - Began setting up a visual draw.io of users, a gameboard, and other elements,
      but switched back to the outlined walkthrough,
      then ended up going with a hybrid of the 'pseudo classes' and the 'step-by-step walkthrough'.

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@4/16/2024 1:34:42 AM
- Dev Play: TicTacToe

    Still moving things around

@4/16/2024 2:34:42 AM
- Dev Play: TicTacToe (couple hours)

    /// Transient Data
    [GamePlay](int boardSize) (thought: putting a quarter in the slot kicks off `GamePlay`)

    /// Persisted Data
    [GameData](<User>[] players)

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@4/17/2024 4:16:32 AM
- Dev Play: TicTacToe (couple hours)

    More class structuring.
    - Been getting more into the class details.
    - Need to walk through every step.

    New class: [TurnPlay]
    - Added to [ScoreBook] => allPlayers

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

##

@4/20/2024 3:45:30 AM
- Dev Play: TicTacToe

    Lots more class design refactoring
    Refining CRC cards

      `+ updateGame(gameData) => allGames.updateWhere(gameData)`

@4/20/2024 5:01:49 AM
- Dev Play: TicTacToe

    Think I''m done with the class design (above)
      and CRC cards.

```
  > tictactoe\assets\_src\dev_play_tictactoe.drawio
  > tictactoe\assets\_src\dev_play_tictactoe.png
```

@4/20/2024 5:13:48 AM
- Dev Play: TicTacToe - 3 commits

    More class design updates (added `TurnPlayTile`)
    Added TicTacToe logo PNG (used for icons).
    Added TicTacToe CRC & class design flow (draw.io)

@4/20/2024 5:43:03 AM
- Dev Play: TicTacToe

    Cleared out all existing new project errors.
      Had to add a few dependencies.
```
      dev_dependencies:
        build_runner: ^2.4.9
        flutter_lints: ^3.0.2
        flutter_localization: ^0.2.0
```

@4/20/2024 6:31:36 AM
- Dev Play: TicTacToe - 7 commits today

    Started up emulator and fired up the TicTacToe app.
      Icons look good.
      Flutter skeleton runs good.

@4/20/2024 6:46:05 AM
- Dev Play: TicTacToe (~4 hours)

    Prepped app for first go at TDD.
      Backed up, then stripped out all the code in the app.
      Hoping the class design is ironed out enough.

@4/20/2024 7:27:58 AM
- Dev Play: TicTacToe

    Cleaned and caught up readme_tictactoe.md

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@4/22/2024 3:49:49 AM
- Dev Play: Tic Tac Toe

    Created a theme:

      /// Material Theme Builder
      /// https://m3.material.io/theme-builder#/custom

@4/22/2024 5:56:01 AM
- Dev Play: Tic Tac Toe

  Created 'up' and 'down' buttons.
    - Getting inner shadows was tricky.

  Looked at a couple packages,
    but they have not been updated in awhile.

  But just looked for: flutter neumorphic
    and found below. Will look at it when I get up.

```
    > flutter_neumorphic_plus: ^3.3.0
      https://pub.dev/packages/flutter_neumorphic_plus
      https://github.com/gsmlg-dev/Flutter-Neumorphic
```

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@4/22/2024 4:46:35 PM
- Dev Play: Tic Tac Toe

  Tried integrating the Neumorphic package, but it had some issues.
  Cloned the app, spent a lot of time cleaning it up, tried building, and it failed.

      flutter_neumorphic_example

@4/22/2024 7:38:05 PM
- Dev Play: Tic Tac Toe

  Been working with `flutter_neumorphic_plus`
    (which is a fork someone created from `flutter_neumorphic`).
  Got it working locally using a cloned copy that I fixed.

```
      > flutter_neumorphic_plus: ^3.3.0
        https://github.com/gsmlg-dev/Flutter-Neumorphic
        https://pub.dev/packages/flutter_neumorphic_plus
        https://pub.dev/documentation/flutter_neumorphic_plus/latest/flutter_neumorphic/flutter_neumorphic-library.html

      > Old readme with descriptions
        https://github.com/Idean/Flutter-Neumorphic?tab=readme-ov-file
```

  Had to also fix `ColorPicker` (thanks to a github issue commenter).

```
        // https://github.com/mchome/flutter_colorpicker/issues/105#issuecomment-2041025904
        flutter_colorpicker:
          git:
            url: https://github.com/mchome/flutter_colorpicker
            ref: master
```

@4/22/2024 10:59:50 PM
@4/22/2024 11:17:31 PM
@4/23/2024 12:01:27 AM
- Dev Play: Tic Tac Toe

  Can't really get what I'm looking for on a button style,
    but then I only have a vague idea of what I'm aiming for.

  I just know I wanted a semi-sharp bevel and embossing effect.

  But I'm wondering if what I created from yesterday isn't closer,
    or maybe just more easily understandable or customizable,
    and doesn't require an entire package.

  But I think I'm going a bit too far with this design stuff (right now),
    and I'm thinking I should just fork the `neumorphic_plus` repo
    and commit my changes to save it for later use,
    then get back to just making the game, or, er, TDD.

  But in doing that I had to come up with the design,
    which then took a turn to designing the buttons.
  I did get a theme going,
    but it didn't seem to cover any of the widgets
    that I am using for testing
    without having to add to the customization.

  Will need to just get back to working with that theming
    and moving back to focusing on converting my CRC cards to TDD.

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@4/23/2024 12:09:54 AM
- Dev Play: Neumorphism Fork

  - Created a GitHub Fork

    `Flutter-Neumorphic-Plus-Fork`

  A forked and updated (but unpublished) copy of the Neumorphic Plus package,
    which is a fork of the Neumorphic package, both of which are available on pub.dev.

@4/23/2024 1:18:35 AM
- Dev Play: Neumorphic Plus Fork

      gh add .
      gh commit -m "Updated and fixed package with `flutter_lints`."
      gh push

@4/23/2024 3:48:29 AM
- Dev Play: Tic Tac Toe (~2 hours)

  Got the 'button up' looking decent.

  - Moved all the button code over to a new file [app_buttons.dart].
  - Stripped [app.dart] and think I'm ready for TDD once again.

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@4/23/2024 1:55:56 PM
- Recorded new component diagram in new RightNote Page for PlantUML.

@4/23/2024 11:48:17 PM
- Dev Play: Tic Tac Toe (now also, Tic Tac Tuple)

  - Finished a flow diagram in draw.io.
  - Finiahed 2 screen mocks in draw.io.

    - Took about ~5-6 hours.
    - Will post both when I post a blog.
      - Also, the PlantUML component diagram created earlier.

      dev-play\tictactoe\assets\_src\
        - devplay_tictactoe_flow.png
        - devplay_tictactoe_screens.drawio
        - devplay_tictactoe_screens.png
        - devplay_tictactoe_screens_and_flow_02.png

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------
