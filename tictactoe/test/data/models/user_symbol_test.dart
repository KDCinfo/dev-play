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
      group('UserSymbolEmpty JSON:', () {
        test('toJson: UserSymbolEmpty', () {
          const userSymbol = UserSymbolEmpty();
          expect(
            userSymbol.toJson(),
            equals({'markerKey': '?'}),
            // The `markerKey` is unique, so the `markerIcon` is not needed.
            // equals({'markerKey': '?', 'markerIcon': Icons.list}),
          );
        });
        test('fromJson: UserSymbolEmpty', () {
          const userSymbol = UserSymbolEmpty();
          final userSymbolJson = userSymbol.toJson();
          final userSymbolFromJson = UserSymbol.fromJson(userSymbolJson);
          expect(userSymbol, equals(userSymbolFromJson));
        });
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
      group('UserSymbolX JSON:', () {
        test('toJson: UserSymbolX', () {
          const userSymbol = UserSymbolX();
          expect(
            userSymbol.toJson(),
            equals({'markerKey': 'x'}), // , 'markerIcon': Icons.close}),
          );
        });
        test('fromJson: UserSymbolX', () {
          const userSymbol = UserSymbolX();
          final userSymbolJson = userSymbol.toJson();
          final userSymbolFromJson = UserSymbol.fromJson(userSymbolJson);
          expect(userSymbol, equals(userSymbolFromJson));
        });
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
      group('UserSymbolO JSON:', () {
        test('toJson: UserSymbolO', () {
          const userSymbol = UserSymbolO();
          expect(
            userSymbol.toJson(),
            equals({'markerKey': 'o'}), // , 'markerIcon': Icons.mood}),
          );
        });
        test('fromJson: UserSymbolO', () {
          const userSymbol = UserSymbolO();
          final userSymbolJson = userSymbol.toJson();
          final userSymbolFromJson = UserSymbol.fromJson(userSymbolJson);
          expect(userSymbol, equals(userSymbolFromJson));
        });
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
      group('UserSymbolPlus JSON:', () {
        test('toJson: UserSymbolPlus', () {
          const userSymbol = UserSymbolPlus();
          expect(
            userSymbol.toJson(),
            equals({'markerKey': '+'}), // , 'markerIcon': Icons.favorite}),
          );
        });
        test('fromJson: UserSymbolPlus', () {
          const userSymbol = UserSymbolPlus();
          final userSymbolJson = userSymbol.toJson();
          final userSymbolFromJson = UserSymbol.fromJson(userSymbolJson);
          expect(userSymbol, equals(userSymbolFromJson));
        });
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
      group('UserSymbolStar JSON:', () {
        test('toJson: UserSymbolStar', () {
          const userSymbol = UserSymbolStar();
          expect(
            userSymbol.toJson(),
            equals({'markerKey': '*'}), // , 'markerIcon': Icons.star_border}),
          );
        });
        test('fromJson: UserSymbolStar', () {
          const userSymbol = UserSymbolStar();
          final userSymbolJson = userSymbol.toJson();
          final userSymbolFromJson = UserSymbol.fromJson(userSymbolJson);
          expect(userSymbol, equals(userSymbolFromJson));
        });
      });
    });
  });
}
