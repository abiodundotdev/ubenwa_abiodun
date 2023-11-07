import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubenwa/core/core.dart';
import 'package:ubenwa/environment.dart';
import 'package:ubenwa/presentation/presentation.dart';
import 'package:ubenwa/service_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Alarm.init();
  await SC.initialize();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final environment = Environment.fromConfig;
    final app = AppTheme(
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          builder: (context, child) {
            return MaterialApp(
              navigatorKey: rootNavigatorKey,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.of(context).light(Theme.of(context)),
              darkTheme: AppTheme.of(context).dark(Theme.of(context)),
              themeMode: ThemeMode.light,
              home: const SplashScreen(),
            );
          }),
    );
    if (environment.isProd) {
      return app;
    }
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Banner(
        color: AppColors.primary,
        message: environment.name.toUpperCase(),
        location: BannerLocation.topStart,
        child: app,
      ),
    );
  }
}
