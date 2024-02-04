import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/game/models/dice.dart';

void main() async {
  test('Dice should have correct num sides', () {
    Dice sixSide = Dice(6);
    Dice twentySide = Dice(20);

    expect(sixSide.numSides, 6);
    expect(twentySide.numSides, 20);
  });

  test('Roll should be int', () {
    Dice sixSide = Dice(6);
    Dice twentySide = Dice(20);

    expect(sixSide.roll().runtimeType, int);
    expect(twentySide.roll().runtimeType, int);
  });
}
