import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/game/utils/double_to_precision.dart';

void main() async {
  group('doubleToPrecision() Tests:', () {
    int precision;
    double number = 1.23456789;
    test('Should return x.0 when precision is 0', () {
      double expected = 1.0;
      precision = 0;

      expect(doubleToPrecision(number, precision), expected);
    });

    test('Should return x.xx when precision is 2', () {
      double expected = 1.23;
      precision = 2;

      expect(doubleToPrecision(number, precision), expected);
    });
    test('Should round number when getting precision', () {
      double expected = 1.2346;
      precision = 4;

      expect(doubleToPrecision(number, precision), expected);
    });

    test(
        'Should return whole number when precision is greater than input number',
        () {
      double expected = 1.23456789;
      precision = 12;

      expect(doubleToPrecision(number, precision), expected);
    });
  });
}
