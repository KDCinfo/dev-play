```dart
      child: Text(
        screenTitle,
        key: titleKey,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: headlineLargeBold?.copyWith(
              // fontFamily: 'Ahem', // Black squares
              // fontFamily: 'FiraCode', // Old typewriter
              // fontFamily: 'Hack', // Monospaced
              // fontFamily: 'Lato',
              fontFamily: 'Quicksand', // Rounded
              // fontFamily: 'Raleway', // Squared
              // fontFamily: 'Roboto', // Default
              // fontFamily: 'RobotoCondensed', // Condensed
              // fontFamily: 'RobotoMono', // Wide monospaced
              // Outline
              color: Colors.yellow,
              // Shadow
              shadows: [
                const Shadow(
                  color: AppConstants.primaryTileColor,
                  offset: Offset(1, 1),
                  blurRadius: 3,
                ),
              ],
            ) ??
            const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato',
            ),
      ),
```

```yaml
    // abc def ghi
    - family: Ahem
      fonts:
        - asset: assets/fonts/Ahem.ttf
    - family: codicon
      fonts:
        - asset: assets/fonts/codicon.ttf
    - family: CupertinoIcons
      fonts:
        - asset: assets/fonts/CupertinoIcons.ttf
    - family: FiraCode
      fonts:
        - asset: assets/fonts/FiraCode-Bold.ttf
        - asset: assets/fonts/FiraCode-Light.ttf
        - asset: assets/fonts/FiraCode-Medium.ttf
        - asset: assets/fonts/FiraCode-Regular.ttf
        - asset: assets/fonts/FiraCode-Retina.ttf
        - asset: assets/fonts/FiraCode-SemiBold.ttf
        - asset: assets/fonts/FiraCode-VF.ttf
    - family: Hack
      fonts:
        - asset: assets/fonts/Hack-Bold.ttf
        - asset: assets/fonts/Hack-BoldItalic.ttf
        - asset: assets/fonts/Hack-Italic.ttf
        - asset: assets/fonts/Hack-Regular.ttf
    - family: JetBrainsMono
      fonts:
        - asset: assets/fonts/JetBrainsMono-Bold.ttf
        - asset: assets/fonts/JetBrainsMono-BoldItalic.ttf
        - asset: assets/fonts/JetBrainsMono-ExtraBold.ttf
        - asset: assets/fonts/JetBrainsMono-ExtraBoldItalic.ttf
        - asset: assets/fonts/JetBrainsMono-ExtraLight.ttf
        - asset: assets/fonts/JetBrainsMono-ExtraLightItalic.ttf
        - asset: assets/fonts/JetBrainsMono-Italic.ttf
        - asset: assets/fonts/JetBrainsMono-Light.ttf
        - asset: assets/fonts/JetBrainsMono-LightItalic.ttf
        - asset: assets/fonts/JetBrainsMono-Medium.ttf
        - asset: assets/fonts/JetBrainsMono-MediumItalic.ttf
        - asset: assets/fonts/JetBrainsMono-Regular.ttf
        - asset: assets/fonts/JetBrainsMono-SemiBold.ttf
        - asset: assets/fonts/JetBrainsMono-SemiBoldItalic.ttf
        - asset: assets/fonts/JetBrainsMono-Thin.ttf
        - asset: assets/fonts/JetBrainsMono-ThinItalic.ttf
    - family: JetBrainsMonoNL
      fonts:
        - asset: assets/fonts/JetBrainsMonoNL-Bold.ttf
        - asset: assets/fonts/JetBrainsMonoNL-BoldItalic.ttf
        - asset: assets/fonts/JetBrainsMonoNL-ExtraBold.ttf
        - asset: assets/fonts/JetBrainsMonoNL-ExtraBoldItalic.ttf
        - asset: assets/fonts/JetBrainsMonoNL-ExtraLight.ttf
        - asset: assets/fonts/JetBrainsMonoNL-ExtraLightItalic.ttf
        - asset: assets/fonts/JetBrainsMonoNL-Italic.ttf
        - asset: assets/fonts/JetBrainsMonoNL-Light.ttf
        - asset: assets/fonts/JetBrainsMonoNL-LightItalic.ttf
        - asset: assets/fonts/JetBrainsMonoNL-Medium.ttf
        - asset: assets/fonts/JetBrainsMonoNL-MediumItalic.ttf
        - asset: assets/fonts/JetBrainsMonoNL-Regular.ttf
        - asset: assets/fonts/JetBrainsMonoNL-SemiBold.ttf
        - asset: assets/fonts/JetBrainsMonoNL-SemiBoldItalic.ttf
        - asset: assets/fonts/JetBrainsMonoNL-Thin.ttf
        - asset: assets/fonts/JetBrainsMonoNL-ThinItalic.ttf
    - family: Lato
      fonts:
        - asset: assets/fonts/Lato-Bold.ttf
        - asset: assets/fonts/Lato-Regular.ttf
    - family: Quicksand
      fonts:
        - asset: assets/fonts/Quicksand-Bold.ttf
        - asset: assets/fonts/Quicksand-Light.ttf
        - asset: assets/fonts/Quicksand-Medium.ttf
        - asset: assets/fonts/Quicksand-Regular.ttf
    - family: Raleway
      fonts:
        - asset: assets/fonts/Raleway-Black.ttf
        - asset: assets/fonts/Raleway-Bold.ttf
        - asset: assets/fonts/Raleway-Regular.ttf
    - family: Roboto
      fonts:
        - asset: assets/fonts/Roboto-Black.ttf
        - asset: assets/fonts/Roboto-BlackItalic.ttf
        - asset: assets/fonts/Roboto-Bold.ttf
        - asset: assets/fonts/Roboto-BoldItalic.ttf
        - asset: assets/fonts/Roboto-Italic.ttf
        - asset: assets/fonts/Roboto-Light.ttf
        - asset: assets/fonts/Roboto-LightItalic.ttf
        - asset: assets/fonts/Roboto-Medium.ttf
        - asset: assets/fonts/Roboto-MediumItalic.ttf
        - asset: assets/fonts/Roboto-Regular.ttf
        - asset: assets/fonts/Roboto-Thin.ttf
        - asset: assets/fonts/Roboto-ThinItalic.ttf
    - family: RobotoCondensed
      fonts:
        - asset: assets/fonts/RobotoCondensed-Bold.ttf
        - asset: assets/fonts/RobotoCondensed-BoldItalic.ttf
        - asset: assets/fonts/RobotoCondensed-Italic.ttf
        - asset: assets/fonts/RobotoCondensed-LightItalic.ttf
        - asset: assets/fonts/RobotoCondensed-Regular.ttf
    - family: RobotoMono
      fonts:
        - asset: assets/fonts/RobotoMono-Bold.ttf
        - asset: assets/fonts/RobotoMono-Light.ttf
        - asset: assets/fonts/RobotoMono-Medium.ttf
        - asset: assets/fonts/RobotoMono-Regular.ttf
        - asset: assets/fonts/RobotoMono-Thin.ttf
```
