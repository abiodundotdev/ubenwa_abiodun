import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart' as intl;
import 'package:quiver/time.dart';

import 'package:ubenwa/core/core.dart';
import 'package:ubenwa/presentation/presentation.dart';
import 'package:ubenwa/service_container.dart';

class CryRecordPage extends StatefulWidget {
  const CryRecordPage({super.key});

  @override
  State<CryRecordPage> createState() => _CryRecordPageState();
}

num chartValue = 1;

class _CryRecordPageState extends State<CryRecordPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        padding: EdgeInsets.zero,
        appBar: CustomAppBar(
          title: "Cry Records",
          trailing: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              child: Stack(
                children: [
                  Icon(
                    AppIcons.notification,
                    color: Colors.black,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      backgroundColor: AppColors.accent,
                      radius: 6.0,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Gap(10.0.h),
              Padding(
                padding: AppConstants.contentPadding,
                child: _HorizontalCalender(
                  onDateChange: (DateTime date) {
                    //TODO: This is used to animate the bar chart to show the animation efffect based on data passed
                    setState(() {
                      chartValue = Random().nextInt(8 - 1 + 1) + 1;
                    });
                  },
                ),
              ),
              Gap(23.0.h),
              Padding(
                padding: AppConstants.contentPadding.w,
                child: _OverviewCard(),
              ),
              Gap(23.0.h),
              _HourlyBreakDownCard(percentage: chartValue),
              Gap(23.0.h),
              Padding(
                padding: AppConstants.contentPadding.w,
                child: _ChallengeCard(
                  pieChartpercentage: chartValue / 8,
                ),
              ),
              //Extra bottom pading for widget to be more visible
              Gap(20.0.h),
            ],
          ),
        ));
  }
}

class _HorizontalCalender extends StatefulWidget {
  final Function(DateTime) onDateChange;

  const _HorizontalCalender({required this.onDateChange});

  @override
  State<_HorizontalCalender> createState() => _HorizontalCalenderState();
}

class _HorizontalCalenderState extends State<_HorizontalCalender> {
  late ScrollController monthScrollController;
  late ScrollController daysScrollController;
  Duration scrollAnimationDuration = const Duration(milliseconds: 500);

  double dateWidth = 39.0.w;
  double dateHeight = 85.0.w;

  int _selectedMonth = DateTime.now().month;

  set selectedMonth(int month) {
    setState(() {
      _selectedMonth = month;
    });
  }

  int _selectedDay = DateTime.now().day;
  set selectedDay(int day) {
    setState(() {
      _selectedDay = day;
    });
  }

  @override
  void initState() {
    super.initState();
    monthScrollController = ScrollController();
    daysScrollController = ScrollController();

//To automatically scroll to the current date if date is not visible
//TODO: Optimize to make it better base on the date
//Added extra spacing (40) for spacing for great accecibility

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (monthScrollController.hasClients &&
            daysScrollController.hasClients) {
          //TODO: Add if condition to check if it still visible or not
          monthScrollController.animateTo(_selectedMonth * dateWidth + 40.w,
              duration: scrollAnimationDuration, curve: Curves.easeIn);
          daysScrollController.animateTo(_selectedDay * dateWidth + 40.w,
              duration: scrollAnimationDuration, curve: Curves.easeIn);
        }
      },
    );
  }

  final months = intl.DateFormat('MMMM', 'en_US').dateSymbols.MONTHS;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        SingleChildScrollView(
          controller: monthScrollController,
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(months.length, (_index) {
                final index = _index + 1;
                return InkResponse(
                  onTap: () {
                    selectedMonth = index;
                    selectedDay = 1;
                    daysScrollController.animateTo(
                      0,
                      duration: scrollAnimationDuration,
                      curve: Curves.easeIn,
                    );
                    widget.onDateChange(
                      DateTime(
                          DateTime.now().year, _selectedMonth, _selectedDay),
                    );
                  },
                  child: Text(
                    months[_index].substring(0, 3),
                    style: TextStyle(
                      fontSize: 16.0.sp,
                      fontWeight: _selectedMonth == index
                          ? FontWeight.w700
                          : FontWeight.w400,
                      color: _selectedMonth == index
                          ? AppColors.primary.shade300
                          : Colors.black54,
                    ),
                  ),
                );
              }).spacedRow(
                space: 10.0,
              ),
            ),
          ),
        ),
        const Gap(8.0),
        SingleChildScrollView(
          controller: daysScrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
                daysInMonth(DateTime.now().year, _selectedMonth), (_index) {
              final index = _index + 1;
              bool isActive = _selectedDay == index;
              return GestureDetector(
                onTap: () {
                  selectedDay = index;
                  widget.onDateChange(DateTime(
                      DateTime.now().year, _selectedMonth, _selectedDay));
                },
                child: SizedBox(
                  width: dateWidth,
                  height: dateHeight + 5,
                  child: Stack(fit: StackFit.loose, children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInExpo,
                        width: dateWidth,
                        height: dateHeight,
                        decoration: ShapeDecoration(
                          color: isActive
                              ? const Color(0XFF4476F6)
                              : const Color(0XFFEBEBEB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5.0,
                          vertical: 25.0,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Text(
                                deriveDaysInMonth[_index].substring(0, 3),
                                style: textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w300,
                                  color: isActive
                                      ? Colors.white
                                      : const Color.fromRGBO(0, 0, 0, 0.41),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "$index ",
                                style: TextStyle(
                                  fontWeight: isActive
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                  color: isActive
                                      ? Colors.white
                                      : const Color.fromRGBO(0, 0, 0, 0.41),
                                  fontSize: 17.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isActive)
                      Align(
                        alignment: Alignment.topCenter,
                        child: CircleAvatar(
                          backgroundColor: AppColors.accent,
                          radius: 6.0,
                        ),
                      ),
                  ]),
                ),
              );
            }).spacedRow(space: 20.0),
          ),
        ),
      ],
    );
  }

  List<String> get deriveDaysInMonth {
    int monthNumber = _selectedMonth;
    DateTime firstDayOfMonth = DateTime(DateTime.now().year, monthNumber, 1);
    DateTime lastDayOfMonth =
        DateTime(firstDayOfMonth.year, firstDayOfMonth.month + 1, 0);

    List<String> daysInMonth = [];

    for (var day = firstDayOfMonth;
        day.isBefore(lastDayOfMonth.add(const Duration(days: 1)));
        day = day.add(const Duration(days: 1))) {
      String weekday = intl.DateFormat('EEEE', 'en_US').format(day);
      daysInMonth.add(weekday);
    }
    return daysInMonth;
  }
}

class _HourlyBreakDownCard extends StatelessWidget {
  final num percentage;
  const _HourlyBreakDownCard({required this.percentage});

  @override
  Widget build(BuildContext context) {
    return TitledCard(
      title: "    Hourly breakdown",
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 14.0.h, horizontal: 18.0.w),
        height: 160.0.h,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.07, 0),
            end: Alignment(1.108, 0),
            colors: [
              Color(0xFF4476F6),
              Color(0xFF07236B),
            ],
            stops: [0.0362, 1.108],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            8,
            (index) => HorizontalBar(
              percentage: (index + 1) / 8 * percentage,
              label: "$index:00/\n${index + 1}:00",
            ),
          ),
        ),
      ),
    );
  }
}

class _OverviewCard extends StatelessWidget {
  _OverviewCard();

  final gridDataList = [
    _GridData(
      bottom: "20% less than yesterday",
      color: const Color(0XFF0D2D80),
      content: "45",
      icon: AppIcons.sunFog,
      title: "Number of cry episodes",
      hasWarning: false,
    ),
    _GridData(
      bottom: "20% worse than yesterday",
      color: const Color(0XFF896511),
      content: "30 mins",
      icon: AppIcons.wifi,
      title: "Longest cry duration",
      hasWarning: true,
    ),
    _GridData(
      bottom: "20% better than yesterday",
      color: const Color(0XFFAC228E),
      content: "4 hours",
      icon: AppIcons.chart,
      title: "Cummulative cry duration",
      hasWarning: false,
    )
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TitledCard(
      title: "Today's Overview",
      content: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        crossAxisSpacing: 12.0.w,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1 / 1.1,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          gridDataList.length,
          (index) {
            final gridData = gridDataList[index];
            return Container(
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(
                    width: .5,
                    color: Color(0XFF132C84),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6.0.w),
                          decoration: ShapeDecoration(
                            color: gridData.color.withOpacity(.2),
                            shape: const CircleBorder(),
                          ),
                          child: Icon(
                            gridData.icon,
                            size: 15.0.w,
                            color: gridData.color,
                          ),
                        ),
                        const Gap(10.0),
                        Expanded(
                          child: Text(
                            gridData.title,
                            style: textTheme.bodySmall!.copyWith(fontSize: 9.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Gap(5.0.h),
                  const Spacer(),
                  Expanded(
                    flex: 2,
                    child: Text(
                      gridData.content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  //Gap(5.0.h),
                  const Spacer(),
                  Expanded(
                    flex: 2,
                    child: Text(
                      gridData.bottom,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 8.0.sp,
                        color: gridData.hasWarning
                            ? AppColors.red
                            : AppColors.green,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _GridData {
  final String title;
  final IconData icon;
  final Color color;
  final String content;
  final String bottom;
  final bool hasWarning;
  _GridData({
    required this.bottom,
    required this.color,
    required this.content,
    required this.icon,
    required this.title,
    required this.hasWarning,
  });
}

class _ChallengeCard extends StatelessWidget {
  ///This is added as a fake data to auto animate the pieChart. Its just a fake data
  final double pieChartpercentage;
  const _ChallengeCard({required this.pieChartpercentage});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 160.0.h,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(
                    width: .5,
                    color: Color(0xffb7b7b7a),
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(7.0.w),
                          decoration: ShapeDecoration(
                            color: AppColors.accent.shade200,
                            shape: const CircleBorder(),
                          ),
                          child: Icon(
                            AppIcons.star,
                            size: 15.0.w,
                            color: AppColors.accent.shade900,
                          ),
                        ),
                        const Gap(8.0),
                        Text(
                          "Daily challenge",
                          textAlign: TextAlign.center,
                          style: textTheme.bodySmall!.copyWith(
                            fontSize: 11.0.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 8,
                    child: LayoutBuilder(
                      builder: (context, c) {
                        return TweenAnimationBuilder<double>(
                          duration: const Duration(seconds: 1),
                          tween:
                              Tween<double>(begin: 0, end: pieChartpercentage),
                          builder: (context, double value, _) {
                            return CustomPaint(
                              size: Size.square(c.maxHeight),
                              painter: CirclularBarPainter(
                                title: "8",
                                content: "out of 12\n hours of silence",
                                percentage: .8 * value,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gap(15.0.w),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: ShapeDecoration(
                color: AppColors.primary.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image(image: AppImages.feedingBaby2),
                  Gap(5.0.h),
                  Text(
                    "Next predicted cry",
                    style: textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gap(5.0.h),
                  Expanded(
                    child: Text(
                      "12:40 - 14:30",
                      style: textTheme.headlineSmall!.copyWith(
                        color: const Color(0xFFffba18),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        SC.get.navigator.dash.toLoader();
                      },
                      child: const Text("Set alarm"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CirclularBarPainter extends CustomPainter {
  final double percentage;
  CirclularBarPainter(
      {required this.content, required this.title, required this.percentage});
  final String title;
  final String content;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final center = Offset(width / 2, height / 2);
    final thickness = 20.0.w;
    final rect = Rect.fromCenter(center: center, width: width, height: height);

    final paint = Paint()
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final backGroundpaint = Paint()
      ..strokeWidth = thickness
      ..color = const Color(0XFFEFEFEF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    paint.shader = const LinearGradient(
      begin: Alignment(0.5, -0.232615),
      end: Alignment(0.5, 1.14646),
      colors: [
        Color(0xFFFCE1A2),
        Color(0xFFDEA00F),
      ],
    ).createShader(rect);
    //Background complete arc
    canvas.drawArc(
      Rect.fromCenter(center: center, width: width, height: height),
      Angle(0).toRadians,
      Angle(360).toRadians,
      false,
      backGroundpaint,
    );
    //Progress indicator arc
    canvas.drawArc(
      rect,
      Angle(270).toRadians,
      Angle(360 * percentage).toRadians,
      false,
      paint,
    );

    _paintText(canvas, size);
  }

  void _paintText(
    Canvas canvas,
    Size size,
  ) {
    const titleTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.w600,
    );

    const contentTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 10,
      fontWeight: FontWeight.w400,
    );

    final textSpan = TextSpan(
      text: "$title \n",
      children: [
        TextSpan(
          text: content,
          style: contentTextStyle,
        )
      ],
      style: titleTextStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

// TODO: Make the thickness of the circle be deoendent of the  text layout size

    final xCenter = (size.width - textPainter.width) / 2;
    final yCenter = (size.height - textPainter.height) / 2;
    final offset = Offset(xCenter, yCenter);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CirclularBarPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(CirclularBarPainter oldDelegate) => false;
}

class HorizontalBar extends StatefulWidget {
  final double percentage;
  final String label;
  const HorizontalBar(
      {super.key, required this.percentage, required this.label});

  @override
  State<HorizontalBar> createState() => _HorizontalBarState();
}

class _HorizontalBarState extends State<HorizontalBar> {
  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10.0);
    return Column(
      children: [
        Expanded(
          child: Transform.rotate(
            angle: Angle(180).toRadians,
            child: SizedBox(
              width: 8.0.w,
              child: Stack(
                children: [
                  Container(
                    decoration: ShapeDecoration(
                      color: const Color.fromRGBO(5, 35, 112, 0.33),
                      shape: RoundedRectangleBorder(
                        borderRadius: borderRadius,
                      ),
                    ),
                  ),
                  LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraint) {
                    final height = constraint.maxHeight;
                    return AnimatedContainer(
                      curve: Curves.bounceIn,
                      height: widget.percentage * height,
                      duration: const Duration(seconds: 1),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: borderRadius,
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
        const Gap(10.0),
        Text(
          widget.label,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.white,
                fontSize: 10.0.sp,
                fontWeight: FontWeight.w300,
              ),
        )
      ],
    );
  }
}

//TODO: MAKE Implicit animation

class AnimatedValue extends StatefulWidget {
  final Duration? duration;
  final ValueTransitionBuilder builder;
  const AnimatedValue({super.key, this.duration, required this.builder});

  @override
  State<AnimatedValue> createState() => _AnimatedValueState();
}

class _AnimatedValueState extends State<AnimatedValue>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: widget.duration ?? const Duration(seconds: 1));
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return widget.builder(context, controller.value);
      },
    );
  }
}

typedef ValueTransitionBuilder = Widget Function(
  BuildContext context,
  double value,
);
