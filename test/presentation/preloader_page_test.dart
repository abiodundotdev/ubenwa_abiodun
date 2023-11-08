import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ubenwa/core/core.dart';
import 'package:ubenwa/presentation/presentation.dart';
import '../helper.dart';

void main() {
  late Widget preloaderPage;

  setUp(() {
    TestHelper.setUpServiceContainer();
    preloaderPage = buildTestableMaterialApp(const PreloaderPage(
      isTest: true,
    ));
  });

  group("Preloader page test", () {
    testWidgets(
      'Verify has the baby bottle, please wait and water wave widgets',
      (WidgetTester widgetTester) async {
        await widgetTester.pumpWidget(preloaderPage);
        await widgetTester.pump(const Duration(seconds: 2));
        final babyBottleWidget = find.byKey(AppWidgetKeys.babyBottle);
        final pleaseWaitText = find.textContaining(AppStrings.pleaseWait);
        final waterWave = find.byType(WaterWave);
        expect(babyBottleWidget, findsOneWidget);
        expect(pleaseWaitText, findsOneWidget);
        expect(waterWave, findsOneWidget);
      },
    );
  });
}
