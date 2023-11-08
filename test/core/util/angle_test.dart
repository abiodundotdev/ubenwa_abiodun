import 'package:flutter_test/flutter_test.dart';
import 'package:ubenwa/core/core.dart';

void main() {
  group("Angle test", () {
    test("Verify conversion to radian is correct", () {
      final angle = Angle(90).toRadians;
      expect(angle, isA<double>());
      expect(angle, greaterThanOrEqualTo(1.57));
    });

    test("Verify conversion to  degree is correct", () {
      final angle = Angle(1.57).toDegrees;
      expect(angle, isA<double>());
      expect(angle.round(), equals(90));
    });
  });
}
