import 'package:dev_play_tictactoe/src/data/models/user_symbol.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
      test('UserSymbol [props] should return the correct list of properties', () {
        const userSymbol = UserSymbolEmpty();
        expect(userSymbol.props, equals(['?']));
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
      test('UserSymbolX [props] should return the correct list of properties', () {
        const userSymbol = UserSymbolX();
        expect(userSymbol.props, equals(['x']));
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
      test('UserSymbolO [props] should return the correct list of properties', () {
        const userSymbol = UserSymbolO();
        expect(userSymbol.props, equals(['o']));
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
      test('UserSymbolPlus [props] should return the correct list of properties', () {
        const userSymbol = UserSymbolPlus();
        expect(userSymbol.props, equals(['+']));
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
      test('UserSymbolStar [props] should return the correct list of properties', () {
        const userSymbol = UserSymbolStar();
        expect(userSymbol.props, equals(['*']));
      });
    });
  });
}
