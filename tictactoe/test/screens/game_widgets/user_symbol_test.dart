import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:dev_play_tictactoe/src/screens/game_widgets/user_symbol.dart';

void main() {
  group('UserSymbol tests:', () {
    group('UserSymbolEmpty', () {
      test('markerKey should be "?"', () {
        const userSymbol = UserSymbolEmpty();
        expect(userSymbol.markerKey, '?');
      });

      test('markerIcon should be the default question mark icon', () {
        const userSymbol = UserSymbolEmpty();
        expect(userSymbol.markerIcon.icon, Icons.list);
      });
    });

    group('UserSymbolX', () {
      test('markerKey should be "x"', () {
        const userSymbol = UserSymbolX();
        expect(userSymbol.markerKey, 'x');
      });

      test('markerIcon should be the default close icon', () {
        const userSymbol = UserSymbolX();
        expect(userSymbol.markerIcon.icon, Icons.close);
      });
    });

    group('UserSymbolO', () {
      test('markerKey should be "o"', () {
        const userSymbol = UserSymbolO();
        expect(userSymbol.markerKey, 'o');
      });

      test('markerIcon should be the default mood icon', () {
        const userSymbol = UserSymbolO();
        expect(userSymbol.markerIcon.icon, Icons.mood);
      });
    });

    group('UserSymbolPlus', () {
      test('markerKey should be "+"', () {
        const userSymbol = UserSymbolPlus();
        expect(userSymbol.markerKey, '+');
      });

      test('markerIcon should be the default favorite icon', () {
        const userSymbol = UserSymbolPlus();
        expect(userSymbol.markerIcon.icon, Icons.favorite);
      });
    });

    group('UserSymbolStar', () {
      test('markerKey should be "*"', () {
        const userSymbol = UserSymbolStar();
        expect(userSymbol.markerKey, '*');
      });

      test('markerIcon should be the default star border icon', () {
        const userSymbol = UserSymbolStar();
        expect(userSymbol.markerIcon.icon, Icons.star_border);
      });
    });
  });
}
