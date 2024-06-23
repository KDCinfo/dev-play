@4/12/2024 1:00:23 AM
- Trying to come up with a name for a public-facing (open source) dev folder for creating simple games and utility apps for my practicing app design, TDD, OOP, and SOLID.
- I may show these apps during interviews to show app development.

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

@4/13/2024 3:07:56 AM
- Dev Play

```
  > `flutter create tictactoe
    --description "Dev Play: Tic Tac Toe"
    --org "com.example.tictactoe"
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

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

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

@4/24/2024 4:03:45 PM
- Dev Play: Tic Tac Toe

  Let's start with widget tests.

  Wait, what routing are we using?
  The `onGenerateRoute` routing doesn't seem to like hot refreshes,
    or at least it didn't when playing with the neumorphic package.
  And I haven't gotten to testing on GoRouter yet.

  On second thought, testing individual widgets should not require routing.
  That'll be for navigation testing when the first screen's form is submitted.

@
- Never got to the tests...

/// ---------- ---------- ----------

@4/25/2024 1:46:23 AM
- Dev Play: Tic Tac Toe

  Let's try those widget tests again.

- Created first failing test.

@4/25/2024 2:02:29 AM
- Dev Play: Tic Tac Toe

  - Created first failing and passing tests.
    - Actually created a passing test first,
      which was a check that the `MaterialApp` exists,
      but guess I could have deleted `app.dart`,
      but let's not go overboard with this.
  - Created the first widget: `GameEntry`

@4/25/2024 2:21:26 AM
- Dev Play: Tic Tac Toe | 4 commits

  > - Added first screen widget: `GameEntry`.
  > - First 2 widget tests: `MaterialApp` & `GameEntry`

@4/25/2024 4:35:11 AM

@4/25/2024 5:11:04 AM
- Dev Play: Tic Tac Toe | 4 commits (+ readme update = 5 == 9 today)

  After getting the title tests working,
    I refactored the tests to use a helpers file for
    pumping widgets into a `MaterialApp` wrapper.

  > - Added abstract static class: `AppConstants`
  > - Added title (first widget) to the GameEntry screen
  > - Wrote tests for `GameEntry` screen title.
  > - Added a `helpers` folder with abstract `PumpApp`.

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@4/25/2024 4:27:04 PM
- Dev Play: Tic Tac Toe | 1 commit

  > Refactored out `GameEntryTitleRow` & updated tests

@4/25/2024 5:02:49 PM
- Dev Play: Tic Tac Toe | 1 commit

  > Added tests & widgets: `GameEntryNameList` & `Row`

@4/25/2024 5:11:05 PM
- Break

@4/25/2024 7:23:01 PM
- Dev Play: Tic Tac Toe | 1 commit

  > Added and refactored `GameEntry` tests.

@4/26/2024 2:46:33 AM
- Dev Play: Tic Tac Toe | 2 commits

  > Various minor fixes and refactors.
  > Added widgets & tests for `GameEntryBoardSizeRow`.

@4/26/2024 7:14:33 AM
- Dev Play: Tic Tac Toe | 4 commits

  > Added mock `DropdownMenu` to `PlayerNameList`.
  > Added `PopupMenu` for Marker select; fixed tests.
  > Added widgets & tests for `GameEntryButtonsRow`.
  > Added adaptive layout for landscape, small screens


/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------


@4/26/2024 11:24:47 PM
- Dev Play: Tic Tac Toe (1.5 hrs) | 4 commits

  > Renamed test filename for consistency with class.
  > Moved `game_entry_title` to shared `game_title`.
  > Added in test for `GameEntryButtonsRow`.
  > Added tests and widgets for `GameBoardScreen`

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@4/27/2024 1:15:36 AM
- Dev Play: Tic Tac Toe | 1 commit --- Or not!!

  Fixed an overflow on the `game_board_screen_test` test,
    but then checked `game_entry_screen_test` which fails when setting the canvas bigger.

@4/27/2024 3:00:30 AM
- Dev Play: Tic Tac Toe

  Having a lot of testing issues with unbound Rows and Columns.

@4/27/2024 6:07:47 AM
- Dev Play: Tic Tac Toe

  Gotta integrate layout.

      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 30),

@4/27/2024 6:47:11 PM
- Dev Play: Tic Tac Toe

  Tried a couple things with the layout.
  Nothing works.

    builder: (_, constraints) {

@4/28/2024 1:16:58 AM
- Dev Play:

  Still fumbling through these render overflows.
  I actually faked it enough to get the test to pass,
    but the failures make absolutely no sense.

  The final culprit for the BoardSizeRow:

    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 30), // Overflow of 3.3 pixels
    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),

@4/28/2024 3:16:01 AM
- Dev Play:

  https://docs.flutter.dev/ui/layout/constraints

@4/28/2024 5:05:58 AM
- CG4 got past the `Column` error with a combination of `ConstrainedBox` and `IntrinsicHeight`.

@4/28/2024 5:15:28 AM
- CG4 helped out with another error on the following `Row`,
  then I got lucky adding 2 `Expanded` widgets to the 2 buttons,
  which then finally allowed the test to pass.

@4/28/2024 5:16:28 PM
- Dev Play:

  Reading more on Flutter layout composition.
  Need to try building from the inside out,
    not like HTML and CSS where it is from the top down.

@4/28/2024 6:53:36 PM
- Reading a little more on Flutter composition

@4/29/2024 12:49:52 AM
- Dev Play:

  Integrated the new Player List into the `GameEntry` screen.

@4/29/2024 3:00:12 AM
- Dev Play:

  Discussion with CG4 on best widgets to use for specifying full device height and width.
  Going with `ConstrainedBox`, with a `LayoutBuilder` inside to determine portrait and landscape.

@4/29/2024 3:05:49 AM
- Dev Play: Device Size Constraints

  On second thought,
    continuing my readings from a Medium article:

  https://dev.to/dariodigregorio/mastering-responsive-uis-in-flutter-the-full-guide-3g6i

  > Why do we use LayoutBuilder instead of MediaQuery?
  > Since we are showing the NavigationRail on larger screens,
  >   the MediaQuery would ignore the constrain from the NavigationRail and the SafeArea.
  > So we use LayoutBuilder to get the actual constraints of the screen.
  > Read more in this section: Builder vs MediaQuery
  >   https://dev.to/dariodigregorio/mastering-responsive-uis-in-flutter-the-full-guide-3g6i#builder-vs-mediaquery

  The new setup failed when I turned the emulator to landscape.
  Then Flutter hung up when hot refreshing.

@4/30/2024 4:04:46 AM
- Dev Play:

  My android emulators all shows a DPR of 1.
  Trying to figure out how to view a Flutter app with a DPR of 3.

  > `MediaQueryData().devicePixelRatio`

  In the VDC when creating a new phone, the emulators have Size, Resolution, and Density columns.
  There are 4 densities; 400dpi, 420dpi, 440dpi, and 560dpi which seem to directly map to each resolution.
  How might these translate to DPR? Or is that somewhere else?
  I'm running Pixel 7 API 33 which is listed with 420dpi. So maybe if I choose

  I installed Pixel 8 Pro emulator with 6.7" 1344x2992 xxhdpi but Flutter showed the DPR as 3

@4/30/2024 12:34:23 PM
- Dev Play:

  Got the `FakeDevicePixelRatio` widget in place.
    I don't think I should use it,
    but it actually makes the layout a lot better
    by using a Transform on the entire screen.

      Widget build(BuildContext context) {
        final pixelRatio = const MediaQueryData().devicePixelRatio;
        log('pixelRatio: $pixelRatio');
        final pixelRatioV = View.of(context).devicePixelRatio;
        log('pixelRatioV: $pixelRatioV');
            body: FakeDevicePixelRatio(
              fakeDevicePixelRatio: 1.0,

@4/30/2024 7:42:41 PM
- Dev Play:

  Still reading through widget composition.
  I think I know everything I need to know,
    and now just need to learn to better apply and test it all.
  Need to determine a strategy for developing and testing between the DPRs though.

@4/30/2024 8:53:23 PM

@4/30/2024 9:01:05 PM
- CG4

I think I get it all now. ...

@4/30/2024 11:55:23 PM

@5/1/2024 12:02:52 AM
- Dev Play:

Me:

  Update: When using `View.of(context).devicePixelRatio`,
    it actually shows the correct DPR (like 3.5), and not always `1` like `MediaQueryData().devicePixelRatio`.

  So now I just need to determine a strategy between development and testing.

CG4:

  Here’s how you can balance between development ease and thorough testing:

  ### Recommended Strategy

  - **Primary Development**: Choose an emulator with a **DPR of 3** for your primary development.
  This setting will force you to address high-resolution display issues from the beginning,
    ensuring your app looks sharp on newer devices.
  Given Flutter's ability to scale layouts dynamically,
    starting with a high DPR can make it easier to ensure quality across all devices.

  - **Periodic Checks**: Regularly test on an emulator with a **DPR of 1** to
    catch any issues that might arise from the opposite spectrum,
    such as overly large UI elements or inefficient use of space.

  https://dev.to/dariodigregorio/mastering-responsive-uis-in-flutter-the-full-guide-3g6i

- Flutter Docs:
  Adaptive Desgin - Layout Widgets | https://docs.flutter.dev/ui/layout/responsive/building-adaptive-apps#layout-widgets
  Widget Catalog - Layout widgets | https://docs.flutter.dev/ui/widgets/layout
  Youtube Flutter - Widget of the Week | https://www.youtube.com/playlist?list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2
    Most of them are also showcased in the Flutter Widget of the Week series.

@5/1/2024 12:40:52 AM
- Using enum as a class (Dart 3)

  https://dev.to/dariodigregorio/mastering-responsive-uis-in-flutter-the-full-guide-3g6i

      enum ScreenSize {
        small(300),
        normal(400),
        large(600),
        extraLarge(1200);
        final double size;
        const ScreenSize(this.size);
      }
      ScreenSize getScreenSize(BuildContext context) {
        double deviceWidth = MediaQuery.sizeOf(context).shortestSide;
        if (deviceWidth > ScreenSize.extraLarge.size) return ScreenSize.extraLarge;
        if (deviceWidth > ScreenSize.large.size) return ScreenSize.large;
        if (deviceWidth > ScreenSize.normal.size) return ScreenSize.normal;
        return ScreenSize.small;
      }

@5/1/2024 1:04:18 AM
- Dev Play:

  More reading on various browser tabs I still have open.
    And went back over Dart 3: Patterns
  Closed a bunch of others and combined some windows.

@5/1/2024 3:43:26 AM
- Dev Play:

  Knowledge progress on testing with canvas size and DPRs.
    Both in running various tests and advanced convos with CG4.

    - Boo: MediaQueryData().devicePixelRatio;
    - Yay: View.of(context).devicePixelRatio;

@5/1/2024 3:57:21 AM

@5/1/2024 4:27:42 AM
- Dev Play:

  Okay, I gotta move on with this project.

      group('GameEntry Screen', () {
        setUp(() async {
          widgetToTest = const GameEntryScreen();
          wrappedWidget = PumpApp.materialApp(widgetToTest);
        });

        testWidgets('[GameEntry Screen] renders.', (WidgetTester tester) async {
          //
          // Minimal passing sizes for DPR 3 vs. DPR 1.
          // tester.view.devicePixelRatio = 1.0; // Must be set with `physicalSize`.
          // tester.view.physicalSize = const Size(800, 600); // Without DPR: 266.66 200
          // tester.view.physicalSize = const Size(1294, 348); // 0 over // DPR 3
          // tester.view.physicalSize = const Size(432, 116); // 0 over  // DPR 1
          //
          await tester.pumpWidget(wrappedWidget);
          final widgetFinderScreen = find.byType(GameEntryScreen);
          expect(widgetFinderScreen, findsOneWidget);
        });

@5/1/2024 5:37:38 AM
- Dev Play:

  More overflow issues.

@5/1/2024 6:06:02 AM
- Dev Play:

  Okay, I was able to move on with this.

@5/1/2024 11:50:10 PM
- Dev Play: Tic Tac Toe | 5 commits

  > Fixed layout issues: GameEntryBoardSizeRow
  > Fixed layout issues: GameEntryButtonsRow
  > Fixed layout issues: GameTitleRow
  > Fixed layout and tests for `GameEntryScreen`.
  > Added `@TODO` notes for multi-screen size testing.

  After fixing the screen orientation tests,
    been working on upgrading the `PopupMenuButton`
    because it and one or more other widgets
    have been deprecated in favor of Material 3-based widgets.

  - Been working on the marker dropdown menu on the player's name text field.

  I can either go with the global controller.

    globalMenuController?.close();

  Or go back to using the `PopupButtons`.
    I think I prefer the latter.

  --> Or, get `MenuAnchor` working.

@5/2/2024 6:21:03 PM
- Dev Play: Tic Tac Toe

  Cannot get `MenuAnchor` children `MenuItemButton`s to wrap.

@5/2/2024 6:28:40 PM
- Dev Play: Tic Tac Toe

  What a difference a comma (or two) make!!

  > final markerList = const ['x' 'o' '+'];
  > final markerList = const ['x', 'o', '+']; // Duh!!

@5/2/2024 7:23:02 PM
- Dev Play: Tic Tac Toe

  More issues with getting a divider in.

  Got it.

  Just put the returned widget in a Column with a divider below each marker.

      const Divider()

@5/2/2024 11:35:08 PM
- Dev Play: Tic Tac Toe

  Meandered into creating `GamePlayer` and `Marker` data classes.

      String get markerKey
      Icon get markerIcon

@5/3/2024 1:00:34 AM
- Dev Play: Tic Tac Toe

  Created 3 new class files.

    class GamePlayer extends Equatable {
      GamePlayer({
        required this.playerNum,
        this.playerId,
        this.playerName = '',
        this.playerType = const PlayerTypeBot(),
        UserSymbol? userSymbol,
      }) : userSymbol = userSymbol ?? UserSymbolEmpty();

@5/3/2024 1:12:58 AM
- Dev Play: Tic Tac Toe

  - Got `MenuAnchor` working.

  Fixed the new marker/symbol selection menu.
    Looking good, although that's NOT THE POINT!!
    I've completely lost on TDD.

  Fixed layout issues: GameEntryNameList

    Row, RowInputName, RowPlayerNameList

  Fixed layout issues: GameEntryScreen

@5/3/2024 1:38:06 AM

@5/3/2024 1:57:12 AM
- Dev Play: Tic Tac Toe

  - To make up for my loss of TDD,
    I will not be committing any widgets until tests are met.

@5/3/2024 2:41:54 AM
- Dev Play: Tic Tac Toe

  Creating tests

@5/3/2024 4:39:45 AM
- Dev Play: Tic Tac Toe

  More tests.

    test('copyWith should return a new GamePlayer with updated values', () {
    test('label should return the correct player label', () {
    test('props should return the correct list of properties', () {
    test('== should return true if two GamePlayers are equal', () {
    test('== should return false if two GamePlayers are not equal', () {
    test('toString should return the correct string representation', () {
    test('hashCode should return the correct hash code', () {
    test('GamePlayer should be an Equatable', () {
    test('GamePlayer should be a GamePlayer', () {

@5/3/2024 6:00:58 AM
- Dev Play: Tic Tac Toe | 5 commits

  > Added `MarkerMenu` widget and tests.
  > Added `UserSymbol` abstract & 5 concretes w tests.
  > Added `PlayerType` abstract & 2 concretes w tests.
  > Added more tests for `PlayerType` classes.
  > Added model and tests for `GamePlayer`.

@5/4/2024 12:17:37 AM
- Dev Play: Tic Tac Toe

  Got a few test files written.

    // Use specific finders to check for the label and hintText as they are rendered in the UI
    final labelFinder = find.text(player.label);
    final hintTextFinder = find.text(AppConstants.hintText);

    expect(labelFinder, findsOneWidget); // Verifies that label text is in the UI
    expect(hintTextFinder, findsOneWidget); // Verifies that hintText is in the UI

@5/4/2024 4:49:46 AM
- Dev Play:

@5/4/2024 6:43:28 AM
- Dev Play: Tic Tac Toe | 5 commits

      widgetFinderDropdownMenuEntry

  I believe the Game Entry screen is structurally complete
    with all tests.

  > Widgets and tests: `GameEntryNameListRow`
  > Widgets and tests: `GameEntryNameListRowInputName`
  > Added fake `GamePlayer` data for testing.
  > Renamed `GameEnt...PlayerNameList` to `PlayerList`
  > Added tests for `PlayerList`.

@5/4/2024 7:24:47 AM

@5/4/2024 7:48:28 AM
- Dev Play: Tic Tac Toe

  Split `readme_tictactoe.md` to new `readme_history.md`.

  The `_tictactoe` readme is more about the project's inception and design.

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@5/4/2024 3:27:00 PM

@5/4/2024 3:32:29 PM
- Dev Play: Tic Tac Toe

  Starting back on the `GameBoardScreen` and `GameBoardPanel`.
  Brought up tests.

  @Thought:
  With the troubles I had with overflows on the `GameEntryScreen`,
    I'm wondering if TDD isn't as well suited for widget development?

      group('GamePlay GameBoard Screen Testing:', () {

  On second thought, considering it should be built from the inside out,
    you should be able to do the same for the tests
    by starting with the smallest widgets before having to deal with overflows.

  TDD can still apply.

  You can still start with the overall screen,
    and for each piece within the screen,
    start small from within those.

  So, where to start?
    - I've already got the outer shell.
      - It has tests: [x]
        - Screen renders
        - Has a title
        - Has a GameBoardPanel <-- where I left off
        - x Has a NameBoard
        - x Has a GameBoardButtonRow

@5/4/2024 3:48:20 PM
- Dev Play: Tic Tac Toe

  Before getting back into the `GameBoardPanel` testing,
    just noticed (and remembered) that the `GameEntry` screen
    is now adaptive to orientation.

  Will need to extract that orientation code
    to allow for individual screens to be passed in.
  It will also need tests.

@5/4/2024 4:39:58 PM
- Dev Play: Tic Tac Toe

  Neck deep into a variety of orientation-based widgets and tests.

      GameEntryLayoutPortrait

@5/4/2024 8:02:33 PM
- Dev Play: Tic Tac Toe

  Progress on new classes (with tests).

      body: GameOrientationLayout(
        orientationScreen: OrientationScreenGameEntry(),
      ),

@5/4/2024 9:23:54 PM
- Dev Play: Tic Tac Toe | 3 commits (9 today)

  > Added classes and tests: `OrientationScreenWidget`
  > Added new class and tests: `GameOrientationLayout`
    This only covers `GameEntry`, not `GameBoard` (IP).
  > Implemented new `GameOrientationLayout`.

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@5/5/2024 12:50:23 AM
- Dev Play: Tic Tac Toe

  Trying to get the tic tac toe grid to show properly.
    3x3 looks good, but 5x5 crops the grids from 5x5 to 3x3 when it's too small.
    Don't understand it... yet.

@5/5/2024 5:53:03 AM
- Dev Play: Tic Tac Toe

  Trying to get landscape working for GameBoard.

@5/5/2024 6:21:23 PM
- Dev Play: Tic Tac Toe

  Small progress on the layout.

  Fixed the `GameEntry` layout while using it as a guide for the `GameBoard` layout.
    I had unnecessary nested Rows and Columns.

@5/5/2024 6:39:02 PM
- Dev Play: Tic Tac Toe

  I got the grid going well, with one issue in landscape.
    The grid is inside of a `Row` where it shares with another widget where both widgets
    are wrapped with an `Expanded` widget so they share the same space and to avoid pixel
    overflows. The issue is because the `GridView` is inside of an `Expanded` widget, and
    for some reason it will not respect either a `SizedBox` or a `ConstrainedBox` max width
    within that `Expanded` widget, and so the Grid expands the full half width of the screen,
    which results in cropping the bottom layer and a half of tiles.

  ChatGPT4 helped to fix the issue.
    The solution was to remove the `SizedBox` and `ConstrainedBox` widgets,
    and instead add `Align` and `AspectRatio`. Together, they fixed the issue.

  I then had ChatGPT4 explain the reasoning behind the solution.

  > ### The Challenge with SizedBox and ConstrainedBox
  >
  > **Space Allocation**: Both `SizedBox` and `ConstrainedBox` are designed to impose
  >   constraints on their children, but when used with inherently expanding widgets
  >   like GridView, the results might not always align with expectations. This is due to
  >   how intrinsic dimensions are calculated by GridView and how it decides to lay out
  >   its children based on the given constraints. If the constraints are not strict or
  >   if the inherent behavior of the grid (like wanting to expand) conflicts with these
  >   constraints, the grid may end up taking more space.

  That became the last major hurdle for the UI in this project.

@5/6/2024 2:38:28 AM
- Dev Play: Tic Tac Toe | 5 commits

  > Added widget and tests: `GameBoardPanel`
  > Added horizontal padding to `BoardSize` slider row
  > Removed unnecessary wrapper widgets.

  > Split out `GameBoardPanelTile` into its own file.
  > Fixed `GameBoardPanel` sizing layout. | Thanks to ChatGPT4.

  > Synced & fixed `GameBoard` with `GameEntryScreen`.
    123456789 123456789 123456789 123456789 123456789|

@5/6/2024 4:07:11 AM
- Dev Play: Tic Tac Toe | 1 commit

  > Added widget and tests: `GameBoardPlayerPanel`
    Also covers `PanelTitle` and `PanelNames` widgets and tests.

@5/6/2024 5:27:54 AM
- Dev Play: Tic Tac Toe

  Got ButtonPanel laid out.
  Now for the tests.

@5/6/2024 6:06:51 AM
- Dev Play: Tic Tac Toe | 2 commits (8 today)

  > Formatting `PlayerPanel` and some cleanup.
  > Added widget and tests: `GameBoardButtonPanel`

  I believe both screens are done.
    What now?
    - Add lint analysis (borrow from KD-reCall: Hungry)
    - Routing (GoRouter: borrow from KD-reCall: Hungry)
    - Move data model files
    - Repositories and streams
    - Bloc: Providers
    - Bloc: Events
    - Bloc: Listeners and builders

@5/6/2024 6:45:37 AM
- Dev Play: Tic Tac Toe | 1 commit (9 today)

	> Updated `readme_history.md` with latest activities

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@5/8/2024 4:50:44 AM
- Dev Play: Tic Tac Toe | 1 commit

	> Added `BaseService` package w `SharedPreferences`.
	>   Borrowed from my `KD-reCall: Hungry` app.

@5/8/2024 5:53:55 AM
- Dev Play: Tic Tac Toe | 1 commit

	> Renamed `GamePlayer` to `PlayerData`.

@5/8/2024 6:43:04 AM
@5/8/2024 7:07:47 AM
- Dev Play: Tic Tac Toe | 3 commits

	> Added `GameData` model and tests.
	> Added `GameStatus` model and tests.
	> Added `PlayerTurn` model and tests.

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@5/9/2024 5:00:59 AM
- Dev Play: Tic Tac Toe | 4 commits

	> Added a testing helper file for navigation.
	> Added `_row` to `game_entry_buttons_test.dart`
	> Reordered and categorized properties based on usage.
	> Ran coverage; added more tests; now at 95.7%.

	Also working on:

  - Created model: `GameBoard`
  - Adding a `GameData.initial` factory

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@5/10/2024 12:04:43 AM
- Dev Play: Tic Tac Toe

	Finished `GameBoardData` and setup tests.

@5/10/2024 3:12:59 AM
- Dev Play: Tic Tac Toe | 3 commits

	- Lot of work between `GameData` and `GameBoardData`.
	- Also now adding in all the to/from JSON methods (got the `to`s done).

@5/10/2024 11:33:16 AM
- Dev Play: Tic Tac Toe

	> Implementing `fromJson`

	- UserSymbolX
	- UserSymbolO
	- UserSymbolPlus
	- UserSymbolStar

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@5/11/2024 12:15:45 AM
- Dev Play: Tic Tac Toe

	> The `markerKey` is unique, so the `markerIcon` is not needed.

@5/11/2024 12:45:59 AM
- Dev Play: Tic Tac Toe | 1 commit

	> Added `fromJson` & tests: PlayerType & UserSymbol

@5/11/2024 1:27:45 AM
- Dev Play: Tic Tac Toe | 1 commit

	> PlayerData and PlayerTurn: `to/fromJson` and tests

@5/11/2024 4:13:29 AM
- Dev Play: Tic Tac Toe | 1 commit (3 commits today)

	> GameStatus: `to/fromJson` and tests

	- `GameData` and `GameBoardData` are the biggest efforts right now.

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@5/12/2024 3:29:16 AM
- Dev Play: Tic Tac Toe

	- Still working on fixing the `checkRows` and `checkCols`.
	- Got the `checkRows` and trying to refactor to accommodate both.

@5/12/2024 4:04:54 AM
- Dev Play: Tic Tac Toe

  - Random clipboard contents

			previousValue
			dart sublist - Google Search.html
			mapOfRows[tileInSet]
			  print(map1);
			// { 0: [], 1: [], 2: [] }

@5/12/2024 10:09:46 PM
- Dev Play: Tic Tac Toe

	- I think `mod()` should work to get Column groups.

@5/13/2024 12:07:11 AM
- Dev Play: Tic Tac Toe

	- Got model setup for row and col checking.
	- Started on tests. First one failed.

@5/13/2024 1:50:44 AM
- Dev Play: Tic Tac Toe | 2 commits (only 1 was for today)

	> Removed `playerId` from `PlayerTurn`.
	> Initial commit for `GameBoardData` and tests (WIP)

@5/13/2024 6:09:32 AM
- Dev Play: Tic Tac Toe

	- Got diag checks working.
	- Ran through a handful of tests.
    So far, so good.

		`// ( Group index: 0, playerId: 1 (player 2) )`

	- @TODO:
		- Go over rest of tests
		- Check for anything not used in `GameBoardData`.

@5/13/2024 6:16:49 AM
- Dev Play: Tic Tac Toe | 1 commit (2 today)

	> Fixed `checkAllDiags` from `checkDiags` getter.
	> And ran through a handful of tests.

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@5/13/2024 7:26:17 PM
- Dev Play: Tic Tac Toe

	- Reordered and pseudo-grouped all the methods in `GameBoardData`.

@5/14/2024 2:44:08 AM
- Dev Play: Tic Tac Toe

			// ( Group index: 0, playerId: 1 (player 2) )
			expect(result, (0, 1));

@5/14/2024 3:24:24 AM
- Dev Play: Tic Tac Toe

	> Got `GameBoardData` & tests much better organized.
	> All tests passing thus far, but have more tests to add.

@5/14/2024 5:36:02 AM
- Dev Play: Tic Tac Toe

	- Finished with all the tests for an edgeSize of 3.
	- Now working on the [edgeSize: 4] for which I created a new file.

@5/14/2024 5:45:15 AM
- Dev Play: Tic Tac Toe

	So far, so good on the 'edgeSize: 4' tests.
		Means my functions are all working properly so far.

@5/14/2024 6:44:27 AM
- Dev Play: Tic Tac Toe

	- Finished with all the tests for an edgeSize of 4.

@5/14/2024 7:45:21 AM
- Dev Play: Tic Tac Toe | 1 commit

	- Finished with all the tests for an edgeSize of 5.

	> Finished `GameBoardData` tests for 4x4 & 5x5 grids

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@5/14/2024 7:51:30 PM
- Dev Play: Tic Tac Toe

	Trying to get my head into the repository.
		Got some stuff cleaned up a bit.
		Need to think it through.

@5/14/2024 9:48:31 PM
- Dev Play: Tic Tac Toe

	> Created data model and tests for `ScorebookData`.
		123456789 123456789 123456789 123456789 12345678 |

@5/15/2024 4:05:47 AM
- Dev Play: Tic Tac Toe

	- Was working on `ScorebookData`
		until I realized/remembered it needs to be a bloc.
	- Created a `Scorebook` bloc
		in a new `data\blocs` folder.
	- Gotta make sure `GameData` is good though.
		- `GameData` looks good.
		- Tests are half done.
	- `GameData` drives the `Stream` in the `GamePlayRepository`
		which drives the `Scorebook` bloc.

@5/15/2024 5:47:50 AM
- Dev Play: Tic Tac Toe | 1 commit

	> Finished model and tests for `GameData`.
	> 123456789 123456789 123456789 123456789 12345678 |

	> Created data model and tests for `ScorebookData`.

@5/15/2024 7:20:41 AM
- Dev Play: Tic Tac Toe | Oops!

	**__Just discovered I got the `GamePlay` and `Scorebook` reversed.__**

	- `Scorebook` should be the repository and `GamePlay` should be a bloc.
	- `Scorebook` has methods for `initGame` and `updateGame`.

@5/15/2024 7:35:32 AM
@5/15/2024 7:55:20 AM
- Dev Play: Tic Tac Toe

	> Updated drawio diagram: `Scorebook` is repository.
	> 123456789 123456789 123456789 123456789 12345678 |

@5/15/2024 8:47:54 AM
- Dev Play: Tic Tac Toe

	- Got the `GamePlay` and `Scorebook` files reversed.
	- Began integrating `ScorebookData`.

@5/15/2024 9:54:24 AM
- Dev Play: Tic Tac Toe

	- Working through `ScorebookData`.
	- Converting `allPlayers` from `Map` to `List`.

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

@5/16/2024 12:36:03 AM
- Dev Play: Tic Tac Toe

	- Global State -> Scorebook Repository -> ScorebookData

@5/16/2024 12:53:46 AM
- Dev Play:

	- Restarted VS Code; the problems tab was showing issues in previously deleted files.

@5/16/2024 1:40:02 AM
- Dev Play: Tic Tac Toe

	> Moved app-specific storage method into repository.
	> 123456789 123456789 123456789 123456789 12345678 |

@5/16/2024 2:00:41 AM
- Dev Play: Tic Tac Toe

	- Got both `ScorebookRepository` and `ScorebookData` cleaned up and ready for tests.

@5/16/2024 2:26:21 AM
- Copilot created tests for `ScorebookRepository`.
- Cleaned up all the tests and ran the first one (passed).

@5/16/2024 2:27:49 AM
- Holy moly they all passed.

@5/16/2024 2:29:38 AM

	> Added scorebook `RepositoryProvider` w StorageApi.
	> The `StorageAPI` includes methods for both `Shared Preferences` and `Flutter Secure Storage`.

	> Created repository & tests: `ScorebookRepository`
	> 123456789 123456789 123456789 123456789 12345678 |

@5/16/2024 2:53:53 AM
- Dev Play: Tic Tac Toe

	> Created model and tests: `ScorebookData`

@5/16/2024 3:02:16 AM
- Dev Play: Tic Tac Toe

	- I believe all the data models and the repository are complete.
	- The repository needs some more methods,
		but will be done as the blocs need them.
	- On to the blocs...
		Already started earlier with the `GamePlay` bloc.

	- Then ... BlocProviders, BlocBuilders, and BlocListeners (if needed).
	- Then ... that should be it??

@5/16/2024 3:55:58 AM
- Dev Play: Tic Tac Toe

	> Updated [readme_history.md]

/// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------
