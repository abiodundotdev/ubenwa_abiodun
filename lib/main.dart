import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubenwa/core/core.dart';
import 'package:ubenwa/presentation/presentation.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          builder: (context, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: AppTheme.of(context).light(Theme.of(context)),
              darkTheme: AppTheme.of(context).dark(Theme.of(context)),
              home: const SplashScreen(),
            );
          }),
    );
  }
}
