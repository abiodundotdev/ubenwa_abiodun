import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ubenwa/core/core.dart';
import 'package:ubenwa/core/extensions/flexible_extension.dart';
//import 'dart:math' as math;
import 'package:ubenwa/presentation/widget/app_scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Duration duration = const Duration(milliseconds: 300);
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            WifiSign(
              duration: duration,
            ),
            Gap(12.0.w),
            Expanded(
              flex: 3,
              child: Shimmer.fromColors(
                period: duration * 5,
                baseColor: AppColors.white,
                highlightColor: AppColors.primary,
                child: Text(
                  "Mums health",
                  style: TextStyle(
                    fontFamily: AppFonts.irishGrover,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WifiSign extends StatefulWidget {
  final Duration duration;
  const WifiSign({super.key, required this.duration});

  @override
  State<WifiSign> createState() => _WifiSignState();
}

class _WifiSignState extends State<WifiSign> {
  int currentIndex = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _animateWifi();
  }

  //TODO: TO BE OPTIMIZED FOR PERFORMANCE
  void _animateWifi() {
    timer = Timer.periodic(widget.duration, (timer) {
      if (currentIndex < 4) {
        setState(() {
          currentIndex++;
        });
      } else {
        setState(() {
          currentIndex = 0;
        });
      }
    });
  }

  set _currentIndex(int index) {
    setState(() {
      index;
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    int length = 4;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          length,
          (index) => AnimatedOpacity(
            opacity: index >= currentIndex ? 0 : 1,
            duration: widget.duration,
            child: CustomPaint(
              painter: WifiPainter(),
              size: Size(2 * (index + 1), 12 * (index + 1)),
            ),
          ),
        ).reversed.toList().spacedRow(space: 2),
      );
    });
  }
}

class WifiPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final paint = Paint()
      ..color = AppColors.yellow
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final width = size.width;
    final height = size.height;

    // final rect = Rect.fromCenter(
    //     center: Offset(width / 2, height / 2), width: width, height: height);
    path.moveTo(width / 2, 0);
    path.arcToPoint(
      Offset(width / 2, height),
      radius: const Radius.circular(40.0),
      clockwise: false,
    );
    canvas.drawPath(path, paint);
    //canvas.drawArc(rect, (3 * math.pi) / 2, -math.pi, false, paint);
  }

  @override
  bool shouldRepaint(WifiPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(WifiPainter oldDelegate) => false;
}
