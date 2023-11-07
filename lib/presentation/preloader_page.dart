import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ubenwa/core/core.dart';
import 'package:ubenwa/presentation/widget/animations/water_wave.dart';
import 'package:ubenwa/presentation/widget/widget.dart';

import 'widget/animations/water_wave_config.dart';

class PreloaderPage extends StatefulWidget {
  const PreloaderPage({super.key});

  @override
  State<PreloaderPage> createState() => _PreloaderPageState();
}

class _PreloaderPageState extends State<PreloaderPage>
    with SingleTickerProviderStateMixin {
  late AnimationController waterDropController;
  late Animation<num> waterDroplet;

  @override
  void initState() {
    super.initState();
    waterDropController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    waterDroplet = Tween<num>(begin: -1, end: 1).animate(waterDropController)
      ..addStatusListener(
        (status) {
          if (status.isCompleted) {
            print(status);
            print("object");
            dropCount++;
          }
        },
      );

    Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        print(dropCount);
        dropCount++;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    waterDropController.dispose();
  }

  int dropCount = 1;

  @override
  Widget build(BuildContext context) {
    const _colors = [
      Colors.white54,
      Colors.white54,
      Colors.white,
    ];
    const _durations = [
      5000,
      6000,
      7000,
    ];
    const _heightPercentages = [
      0.65,
      0.66,
      0.66,
    ];
    final waveConfig = CustomConfig(
      colors: _colors,
      durations: _durations,
      heightPercentages: _heightPercentages,
    );
    return AppScaffold(
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.primary,
      body: SizedBox(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image(image: AppImages.babyBottle),
            ),
            Align(
              alignment: Alignment.center,
              child: Shimmer.fromColors(
                baseColor: AppColors.white,
                highlightColor: AppColors.primary,
                child: Text(
                  "Please wait while we\ngather your Baby’s data...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0.sp,
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: waterDropController,
              builder: (context, _) {
                return Align(
                  alignment: Alignment(0, waterDroplet.value.toDouble()),
                  child: CustomPaint(
                    size: const Size(30, 25),
                    painter: WaterDropletPainter(),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedBuilder(
                  animation: waterDropController,
                  builder: (context, _) {
                    return WaterWave(
                      config: waveConfig,
                      size: const Size.fromHeight(200),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

//+ (dropCount.toDouble() * 20)
class WaterDropletPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    final width = size.width;
    final height = size.height;
    path.moveTo(width / 2, 0);
    path.quadraticBezierTo(
        size.width, size.height / 2, size.width / 2, size.height);
    path.quadraticBezierTo(0, size.height / 2, size.width / 2, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

extension XAnimationStatus on AnimationStatus {
  bool get isCompleted => this == AnimationStatus.completed;
}
