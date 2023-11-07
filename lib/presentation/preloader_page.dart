import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ubenwa/core/core.dart';
import 'package:ubenwa/presentation/presentation.dart';
import 'package:ubenwa/service_container.dart';

class PreloaderPage extends StatefulWidget {
  const PreloaderPage({super.key});

  @override
  State<PreloaderPage> createState() => _PreloaderPageState();
}

class _PreloaderPageState extends State<PreloaderPage>
    with SingleTickerProviderStateMixin {
  late AnimationController waterDropController;
  late Animation<num> waterDroplet;

  int dropCount = 0;

  @override
  void initState() {
    super.initState();
    waterDropController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    waterDroplet = Tween<num>(begin: -1, end: 1).animate(waterDropController)
      ..addListener(
        () {
          if (waterDroplet.value == 0.9) {
            dropCount++;
          }
        },
      );
    _animateToPageAfterCompletion();
  }

  @override
  void dispose() {
    waterDropController.dispose();
    super.dispose();
  }

  //TODO: This should animate after network call his completed, this should not be done live applications
  void _animateToPageAfterCompletion() async {
    await Future.delayed(const Duration(seconds: 8));
    SC.get.navigator.auth.pop();
  }

  @override
  Widget build(BuildContext context) {
    const _colors = [
      Colors.white54,
      Colors.white54,
      Colors.white,
    ];
    const _durations = [
      10000,
      9000,
      8000,
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
                    size: Size(10.0 + (10 * waterDroplet.value),
                        30.0 + (5 * waterDroplet.value)),
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
                      size: Size.fromHeight(80.h + (dropCount * 10)),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class WaterDropletPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    final width = size.width;
    final height = size.height;
    const controlPoint = .4;
    path.moveTo(width / 2, 0);
    path.lineTo(0, height * controlPoint);
    path.quadraticBezierTo(width / 2, height, width, height * controlPoint);
    path.lineTo(width / 2, 0);
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
