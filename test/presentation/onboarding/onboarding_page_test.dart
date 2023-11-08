import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ubenwa/core/core.dart';
import 'package:ubenwa/presentation/presentation.dart';

import '../../helper.dart';

void main() {
  late Widget onboardingPage;

  setUp(() {
    TestHelper.setUpServiceContainer();
    onboardingPage = buildTestableMaterialApp(const OnboardingPage());
  });

  group("Onboarding page test", () {
    testWidgets(
      'Verify has the required images',
      (WidgetTester widgetTester) async {
        await widgetTester.pumpWidget(onboardingPage);
        await widgetTester.pumpAndSettle();
        final images = find.byType(Image);
        expect(
          images,
          findsNWidgets(5),
        );
      },
    );

    testWidgets(
      'Verify if the scrollable pageview wrapping the text is present',
      (WidgetTester widgetTester) async {
        await widgetTester.pumpWidget(onboardingPage);
        await widgetTester.pumpAndSettle();
        final pageView = find.byType(PageView);
        expect(pageView, findsOneWidget);
        //Verify if pageview has the title and content text
        expect(
          find.descendant(of: pageView, matching: find.byType(Text)),
          findsNWidgets(2),
        );
      },
    );

    testWidgets(
      'Verify has the 4 scroll indicators',
      (WidgetTester widgetTester) async {
        await widgetTester.pumpWidget(onboardingPage);
        await widgetTester.pumpAndSettle();
        final scrollIndicator = find.byKey(AppWidgetKeys.scrollIndicator);
        expect(
          scrollIndicator,
          findsNWidgets(4),
        );
      },
    );

    // Test for user interactions on the onboarding page
    // NB: This can be done on a seperate file, doing it here since their is no much interaction
    //NB: This can be moved to integration test to check each interaction
    testWidgets(
      'Verify when user tap the next button 3 times, next and previous button is invisble and show me is shown and also naviagates to cry record page on completion',
      (WidgetTester widgetTester) async {
        await widgetTester.pumpWidget(onboardingPage);
        await widgetTester.pumpAndSettle();
        final nextButton = find.text("Next");
        final previousButton = find.text("Previous");
        final showMeHowButton = find.text("Show me how");
        expect(nextButton, findsOneWidget);
        expect(previousButton, findsOneWidget);
        expect(showMeHowButton, findsNothing);
        for (var i = 0; i < 3; i++) {
          await widgetTester.tap(nextButton);
          await widgetTester.pumpAndSettle(const Duration(seconds: 1));
        }
        //Verify if previous button works as expected
        expect(nextButton, findsNothing);
        expect(previousButton, findsNothing);
        expect(showMeHowButton, findsOneWidget);
        //Tap the show me button
        await widgetTester.tap(showMeHowButton);
        await widgetTester.pumpAndSettle(const Duration(seconds: 2));
        //Verify it it navigates to cry record page
        expect(find.byType(CryRecordPage), findsOneWidget);
      },
    );

    testWidgets(
      'Verify previous button works as expected',
      (WidgetTester widgetTester) async {
        final nextButton = find.text("Next");
        final previousButton = find.text("Previous");
        await widgetTester.pumpWidget(onboardingPage);
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(nextButton);
        await widgetTester.pumpAndSettle(const Duration(seconds: 1));
        await widgetTester.tap(previousButton);
        await widgetTester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.textContaining("Welcome"), findsOneWidget);
      },
    );
  });
}
