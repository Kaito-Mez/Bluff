import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/game/models/ruleset.dart';

import '../../../../resources/game/models/ruleset_test_data.dart';

void main() async {
  group("getLargestRole() Tests:", () {
    Ruleset ruleset;
    test(
        'Should return highest non-wildcard number when highest number is a wildcard',
        () {
      ruleset = getTestRuleset();
      int expectedLargestRoll = 5;

      expect(ruleset.getLargestRole(), expectedLargestRoll);
    });
    test('Should return highest number when highest number isn\'t a wildcard',
        () {
      ruleset = getTestRuleset(wildcards: [3]);
      int expectedLargestRoll = 6;

      expect(ruleset.getLargestRole(), expectedLargestRoll);
    });
    test('Should return highest non-wildcard number on non-standard die', () {
      ruleset = getTestRuleset(numSides: 23, wildcards: [1, 5, 19, 22, 23]);
      int expectedLargestRoll = 21;

      expect(ruleset.getLargestRole(), expectedLargestRoll);
    });
  });
}
