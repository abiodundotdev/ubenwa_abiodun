import 'package:flutter/rendering.dart';

///List of all asset images
//TODO : Arrange alhabetically during refactotoring
class AppImages {
  AppImages._();
  static ImageProvider happyBaby =
      const AssetImage("assets/images/baby_happy.png");

  static ImageProvider feedingBaby2 =
      const AssetImage("assets/images/feeding_baby.png");

  static ImageProvider sadBaby = const AssetImage("assets/images/baby_sad.png");
  static ImageProvider cryingBaby =
      const AssetImage("assets/images/baby_cry.png");
  static ImageProvider feedingBaby =
      const AssetImage("assets/images/baby_feeding.png");

  static ImageProvider babyBottle =
      const AssetImage("assets/images/baby_bottle.png");
  static ImageProvider happyBabyWithMother =
      const AssetImage("assets/images/mother_with_baby_happy.png");
  static ImageProvider sadBabyWithMother =
      const AssetImage("assets/images/mother_with_baby_sad.png");
  static ImageProvider cryingBabyWithMother =
      const AssetImage("assets/images/mother_with_baby_crying.png");
  static ImageProvider feedingBabyWithMother =
      const AssetImage("assets/images/mother_with_baby_feeding.png");
}
