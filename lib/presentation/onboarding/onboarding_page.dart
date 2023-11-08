import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ubenwa/core/core.dart';
import 'package:ubenwa/presentation/widget/app_scaffold.dart';

import 'package:ubenwa/service_container.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final introDataList = [
    _IntroData(
      color: AppColors.accent,
      contentImage: AppImages.sadBabyWithMother,
      content:
          "Now you can understand a lot about your new born, bukkle up for an experince you will always long for.",
      title: "Welcome to a New Mothering Experince",
      titleImage: AppImages.sadBaby,
      postion: Alignment.topCenter,
    ),
    _IntroData(
      color: AppColors.primary,
      contentImage: AppImages.cryingBabyWithMother,
      content:
          "Now with great feedbacks, you can understand a lot about your new born cry patter and prepare for common cry peak period.",
      title: "A Cry with Meaning",
      titleImage: AppImages.cryingBaby,
      postion: Alignment.centerRight,
    ),
    _IntroData(
      color: AppColors.accent,
      contentImage: AppImages.happyBabyWithMother,
      content:
          "Be your baby’s doctor by viewing great insight and analysis; you get to see how your baby cry activity varies in terms of duration and frequency to help you make good dcisions",
      title: "Analytical Insight",
      titleImage: AppImages.happyBaby,
      postion: Alignment.bottomCenter,
    ),
    _IntroData(
      color: AppColors.primary,
      contentImage: AppImages.feedingBabyWithMother,
      content:
          "Reduce you baby crying time whilst gettting your schedule back together by planning for time of cry activity and time of quite.",
      title: "Happy Mom Happy Home",
      titleImage: AppImages.feedingBaby,
      postion: Alignment.centerLeft,
    )
  ];
  int currentIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    bool isCompleted = currentIndex == introDataList.length - 1;
    final textTheme = Theme.of(context).textTheme;
    const animationDuration = Duration(milliseconds: 500);
    return AppScaffold(
      padding: EdgeInsets.all(15.0.w),
      body: Column(
        children: [
          Gap(25.0.h),
          Expanded(
            flex: 5,
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return ConstrainedBox(
                constraints: constraints.tighten(),
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: AnimatedSwitcher(
                        duration: animationDuration,
                        child: Image(
                          key: ValueKey("$currentIndex"),
                          image: introDataList[currentIndex].contentImage,
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      duration: animationDuration,
                      turns: currentIndex.toDouble() / 4,
                      child: Stack(
                        children: [
                          ...List.generate(
                            introDataList.length,
                            (index) {
                              return Align(
                                alignment: introDataList[index].postion,
                                child: Container(
                                  decoration: ShapeDecoration(
                                    shape: const CircleBorder(),
                                    color: currentIndex == index
                                        ? introDataList[index].color
                                        : introDataList[index]
                                            .color
                                            .withOpacity(.2),
                                  ),
                                  padding: const EdgeInsets.all(15.0),
                                  child: Transform.rotate(
                                    angle:
                                        Angle(currentIndex * (-90)).toRadians,
                                    child: Image(
                                      image: introDataList[index].titleImage,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList()
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(30.0.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    introDataList.length,
                    (index) {
                      return _ScollIndicator(
                        isActive: currentIndex == index,
                        color: introDataList[index].color,
                        key: AppWidgetKeys.scrollIndicator,
                      );
                    },
                  ).spacedRow(space: 4.0.w),
                ),
                Gap(20.0.h),
                Expanded(
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    itemBuilder: (c, index) {
                      return Column(
                        children: [
                          Expanded(
                            child: Text(
                              introDataList[index].title,
                              textAlign: TextAlign.center,
                              style: textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              introDataList[index].content,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (currentIndex != introDataList.length - 1)
                      TextButton(
                        onPressed: () {
                          if (currentIndex > 0) {
                            setState(() {
                              currentIndex--;
                            });
                            pageController.animateToPage(
                              currentIndex,
                              duration: animationDuration,
                              curve: Curves.easeIn,
                            );
                            return;
                          }
                        },
                        child: Text(
                          "Previous",
                          style: TextStyle(color: AppColors.grey),
                        ),
                      ),
                    if (isCompleted) const Spacer(),
                    TextButton(
                      onPressed: () {
                        if (!isCompleted) {
                          setState(() {
                            currentIndex++;
                          });
                          pageController.animateToPage(
                            currentIndex,
                            duration: animationDuration,
                            curve: Curves.easeIn,
                          );
                          return;
                        }
                        SC.get.navigator.dash.toCryRecord();
                      },
                      child: Text(!isCompleted ? "Next" : "Show me how"),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScollIndicator extends StatelessWidget {
  final bool isActive;
  final Color color;
  const _ScollIndicator({required this.isActive, required this.color, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: (isActive ? 15 : 8).w,
      height: (isActive ? 15 : 8).h,
      decoration: ShapeDecoration(
        shape: const CircleBorder(),
        color: isActive ? color : AppColors.grey,
      ),
    );
  }
}

class _IntroData {
  final String content;
  final String title;
  final ImageProvider titleImage;
  final ImageProvider contentImage;
  final Alignment postion;
  final Color color;
  _IntroData({
    required this.color,
    required this.contentImage,
    required this.content,
    required this.title,
    required this.titleImage,
    required this.postion,
  });
}

// final double childrenDiameter =
//     2 * pi * radius / 10 - 0;
// final position = getChildPoint(
//     index,
//     introDataList.length,
//     radius,
//     childrenDiameter);
// radius + position.dx
// left:
//     radius * cos(Angle(90.0 * index).toRadians),
// top:
//     radius * sin(Angle(90.0 * index).toRadians),

//                   final width =
//     constraints.maxWidth - AppConstants.contentPadding.left * 2;
// final radius = width / 2;
// final height = constraints.maxHeight;
// final center = Offset(width / 2, height / 2);


 // AnimatedSwitcher(
                //   duration: animationDuration,
                //   child: Text(
                //     key: ValueKey("$currentIndex"),
                //     introDataList[currentIndex].title,
                //     textAlign: TextAlign.center,
                //     style: textTheme.titleLarge!.copyWith(
                //       fontWeight: FontWeight.w700,
                //     ),
                //   ),
                // ),
                // const Gap(20.0),
                // AnimatedSwitcher(
                //   duration: animationDuration,
                //   child: Text(
                //     key: ValueKey("$currentIndex"),
                //     introDataList[currentIndex].content,
                //     textAlign: TextAlign.center,
                //     style: textTheme.bodyMedium!.copyWith(
                //       fontWeight: FontWeight.w300,
                //     ),
                //   ),
                // ),
