import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ubenwa/core/constants/constants.dart';
import 'package:ubenwa/presentation/presentation.dart';

import '../../helper.dart';

void main() {
  late Widget onboardingPage;

  setUp(() {
    //Set up the service container
    TestHelper.setUpServiceContainer();
    onboardingPage = buildTestableMaterialApp(const OnboardingPage());
  });

  group("Onboarding page test", () {
    testWidgets(
      'Verify has horizontal calender view',
      (WidgetTester widgetTester) async {
        await widgetTester.pumpWidget(cryRecordPage);
        await widgetTester.pumpAndSettle();
        final horizontalCalenderView =
            find.byKey(AppWidgetKeys.horizontalCalender);
        expect(horizontalCalenderView, findsOneWidget);
      },
    );

    testWidgets(
      'Verify has daily overview view',
      (WidgetTester widgetTester) async {
        await widgetTester.pumpWidget(cryRecordPage);
        await widgetTester.pumpAndSettle();
        final overviewView = find.byKey(AppWidgetKeys.horizontalCalender);
        expect(overviewView, findsOneWidget);
      },
    );

    testWidgets(
      'Verify has hourly breakdown view',
      (WidgetTester widgetTester) async {
        await widgetTester.pumpWidget(cryRecordPage);
        await widgetTester.pumpAndSettle();
        final hourybreakdownView = find.byKey(AppWidgetKeys.hourlybreakdown);
        expect(hourybreakdownView, findsOneWidget);
      },
    );

    testWidgets(
      'Verify has daily challenge view',
      (WidgetTester widgetTester) async {
        await widgetTester.pumpWidget(cryRecordPage);
        await widgetTester.pumpAndSettle();
        final dailyChallengeView = find.byKey(AppWidgetKeys.challenge);
        expect(dailyChallengeView, findsOneWidget);
      },
    );

    // Test for user interactions on the cry record page
    // NB: This can be done on a seperate file, doing it here since their is no much interaction

    testWidgets(
      'Verify  if screen navigates to preloader screen after set alarm is tappped',
      (WidgetTester widgetTester) async {
        await widgetTester.pumpWidget(cryRecordPage);
        await widgetTester.pumpAndSettle();
        final setAlarmButton = find.text("Set alarm");
        //Finds the parent scrollable
        final scrollableFinder = find.descendant(
          of: find.byKey(AppWidgetKeys.parentScrollable),
          matching: find.byType(Scrollable).at(0),
        );
        // Scroll until the item to be found appears.
        // Using 500 as scroll extent most devices height are within 300 -  500
        await widgetTester.scrollUntilVisible(
          setAlarmButton,
          500.0,
          scrollable: scrollableFinder,
        );
        expect(setAlarmButton, findsOneWidget);
        //Tap the button since it is found
        await widgetTester.tap(setAlarmButton);
        //Wait for some seconds incase of delayed response
        await widgetTester.pumpAndSettle(const Duration(seconds: 2));
        expect(find.byType(PreloaderPage), findsNothing);
        //Hooray!, this is test is successfull
      },
    );
  });
}
