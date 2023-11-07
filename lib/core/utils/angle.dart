import 'dart:math' as math;

class Angle {
  final double angle;
  Angle(this.angle);
  double get toRadians => (math.pi / 180) * angle;
  double get toDegrees => (180 / math.pi) * angle;
}
