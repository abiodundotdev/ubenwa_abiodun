import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ubenwa/core/constants/app_images.dart';
import 'package:ubenwa/core/core.dart';
import 'package:ubenwa/core/extensions/flexible_extension.dart';
import 'package:ubenwa/presentation/widget/app_scaffold.dart';
import 'dart:math';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final introDataList = [
    _IntroData(
      color: AppColors.primary,
      contentImage: AppImages.sadBabyWithMother,
      content:
          "Now you can understand a lot about your new born, bukkle up for an experince you will always long for.",
      title: "Welcome to a New Mothering Experince",
      titleImage: AppImages.sadBaby,
    ),
    _IntroData(
      color: AppColors.primary,
      contentImage: AppImages.cryingBabyWithMother,
      content:
          "Now with great feedbacks, you can understand a lot about your new born cry patter and prepare for common cry peak period.",
      title: "A Cry with Meaning",
      titleImage: AppImages.cryingBaby,
    ),
    _IntroData(
      color: AppColors.primary,
      contentImage: AppImages.happyBabyWithMother,
      content:
          "Be your baby’s doctor by viewing great insight and analysis; you get to see how your baby cry activity varies in terms of duration and frequency to help you make good dcisions",
      title: "Analytical Insight",
      titleImage: AppImages.happyBaby,
    ),
    _IntroData(
      color: AppColors.primary,
      contentImage: AppImages.feedingBabyWithMother,
      content:
          "Reduce you baby crying time whilst gettting your schedule back together by planning for time of cry activity and time of quite.",
      title: "Happy Mom Happy Home",
      titleImage: AppImages.feedingBaby,
    )
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppScaffold(
      body: Column(
        children: [
          const Spacer(),
          Expanded(
            flex: 4,
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              final width =
                  constraints.maxWidth - AppConstants.contentPadding.left * 2;
              final radius = width / 2;
              final height = constraints.maxHeight;
              final center = Offset(width / 2, height / 2);
              return ConstrainedBox(
                constraints: constraints.tighten(),
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: AnimatedSwitcher(
                        duration: const Duration(seconds: 1),
                        child: Image(
                          key: ValueKey("$currentIndex"),
                          image: introDataList[currentIndex].contentImage,
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      duration: const Duration(seconds: 1),
                      turns: currentIndex.toDouble() / 4,
                      child: Stack(
                        children: [
                          ...List.generate(
                            introDataList.length,
                            (index) {
                              // final double childrenDiameter =
                              //     2 * pi * radius / 10 - 0;
                              // final position = getChildPoint(
                              //     index,
                              //     introDataList.length,
                              //     radius,
                              //     childrenDiameter);
                              // radius + position.dx
                              return Positioned(
                                left: radius * cos((pi / 2) * index),
                                top: radius * sin((pi / 2) * index),
                                child: Container(
                                  decoration: ShapeDecoration(
                                    shape: const CircleBorder(),
                                    color: introDataList[index].color,
                                  ),
                                  padding: const EdgeInsets.all(15.0),
                                  child: Transform.rotate(
                                    angle: currentIndex * pi / 2,
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
          // Expanded(
          //   flex: 8,
          //   child: Align(
          //     alignment: Alignment.topLeft,
          //     child: CircledIntroduction(
          //         onDragEnd: () {},
          //         centerWidget: AnimatedSwitcher(
          //           duration: const Duration(seconds: 1),
          //           child: Image(
          //             key: ValueKey("$currentIndex"),
          //             image: introDataList[currentIndex].contentImage,
          //           ),
          //         ),
          //         initialAngle: currentIndex * pi / 2,
          //         children: introDataList
          //             .map(
          //               (e) => Image(
          //                 image: e.titleImage,
          //               ),
          //             )
          //             .toList()),
          //   ),
          // ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    introDataList.length,
                    (index) {
                      return _ScollIndicator(
                        isActive: currentIndex == index,
                        color: introDataList[index].color,
                      );
                    },
                  ).spacedRow(space: 3.0),
                ),
                const Gap(10.0),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    key: ValueKey("$currentIndex"),
                    introDataList[currentIndex].title,
                    textAlign: TextAlign.center,
                    style: textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Gap(10.0),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    key: ValueKey("$currentIndex"),
                    introDataList[currentIndex].content,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Previous",
                        style: TextStyle(color: AppColors.grey),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (currentIndex < introDataList.length - 1) {
                          setState(() {
                            currentIndex++;
                          });
                        } else {
                          setState(() {
                            currentIndex = 0;
                          });
                        }
                      },
                      child: const Text("Next"),
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

  Offset getChildPoint(
      int index, int length, double betweenRadius, double childrenDiameter) {
    double angel = 2 * pi * (index / length);
    double x = cos(angel) * betweenRadius - childrenDiameter / 2;
    double y = sin(angel) * betweenRadius - childrenDiameter / 2;
    return Offset(x, y);
  }
}

class _ScollIndicator extends StatelessWidget {
  final bool isActive;
  final Color color;
  const _ScollIndicator({required this.isActive, required this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      width: isActive ? 30 : 8,
      height: 8,
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
  final Color color;
  _IntroData({
    required this.color,
    required this.contentImage,
    required this.content,
    required this.title,
    required this.titleImage,
  });
}
