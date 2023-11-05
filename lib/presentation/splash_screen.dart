import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ubenwa/core/core.dart';
//import 'dart:math' as math;
import 'package:ubenwa/presentation/widget/app_scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Row(
          children: const [
            Expanded(
              flex: 2,
              child: WifiSign(),
            ),
            Gap(20.0),
            // Expanded(
            //   flex: 3,
            //   child: Shimmer.fromColors(
            //     baseColor: AppColors.white,
            //     highlightColor: AppColors.primary,
            //     child: Text(
            //       "Mums health",
            //       style: TextStyle(
            //         fontFamily: AppFonts.irishGrover,
            //         color: AppColors.white,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 30.0,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class WifiSign extends StatefulWidget {
  const WifiSign({super.key});

  @override
  State<WifiSign> createState() => _WifiSignState();
}

class _WifiSignState extends State<WifiSign> {
  int currentIndex = 0;
  Duration duration = const Duration(milliseconds: 300);
  late Timer timer;

  @override
  void initState() {
    super.initState();
    // _animateWifi();
  }

  void _animateWifi() {
    timer = Timer.periodic(duration, (timer) {
      if (currentIndex < 4) {
        _currentIndex = currentIndex++;
      } else {
        _currentIndex = 0;
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
        children: List.generate(
          length,
          (index) => AnimatedOpacity(
            ///opacity: index >= currentIndex ? 0 : 1,
            opacity: 1,
            duration: duration,
            child: CustomPaint(
              painter: WifiPainter(),
              size: Size(10 * (index + 1), 20 * (index + 1)),
            ),
          ),
        ).reversed.toList(),
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
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.bevel
      ..strokeCap = StrokeCap.round;
    final width = size.width;
    final height = size.height;

    final rect = Rect.fromCenter(
        center: Offset(width / 2, height / 2), width: width, height: height);
    path.moveTo(width / 2, 0);
    path.arcToPoint(
      Offset(width / 2, height),
      radius: const Radius.circular(60.0),
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
