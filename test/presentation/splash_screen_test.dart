import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ubenwa/presentation/presentation.dart';

import '../helper.dart';

void main() {
  late Widget splashScreen;

  setUp(() {
    TestHelper.setUpServiceContainer();
    splashScreen = buildTestableMaterialApp(const SplashScreen(isTest: true));
  });

  group("Spash screen test", () {
    testWidgets(
      'Verify has mum health text and animating wifi widgets',
      (WidgetTester widgetTester) async {
        await widgetTester.pumpWidget(splashScreen);
        await widgetTester.pump(const Duration(seconds: 2));
        final mumHealth = find.text("Mums health");
        final wifiWidget = find.byType(WifiSign);
        expect(mumHealth, findsOneWidget);
        expect(wifiWidget, findsOneWidget);
      },
    );
  });
}
