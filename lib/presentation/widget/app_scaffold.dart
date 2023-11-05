import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppScaffold extends StatefulWidget {
  final Widget body;
  final EdgeInsets? padding;
  final Widget? bottomNavigationBar;
  final DecorationImage? backgroundImage;
  final PreferredSizeWidget? appBar;
  final bool useSafeArea;
  const AppScaffold(
      {required this.body,
      this.appBar,
      this.backgroundImage,
      this.bottomNavigationBar,
      this.padding,
      this.useSafeArea = true,
      super.key});

  static _AppScaffoldState of(BuildContext context) {
    return context.findAncestorStateOfType<_AppScaffoldState>()!;
  }

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: widget.backgroundImage,
      ),
      child: Scaffold(
        body: body(),
        appBar: widget.appBar,
        bottomNavigationBar: widget.bottomNavigationBar,
      ),
    );
  }

  Widget body() {
    final result = Padding(
      padding: widget.padding ?? EdgeInsets.all(10.0.w),
      child: widget.body,
    );
    if (!widget.useSafeArea) return result;
    return SafeArea(
      child: result,
    );
  }

  Future<void> showPreloader({bool isDismissible = true}) async {
    const settings = RouteSettings(name: "preloader");
    return showDialog(
      context: context,
      barrierDismissible: isDismissible,
      // barrierColor: AppColors.primary.shade50,
      routeSettings: settings,
      builder: (context) {
        return BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: 2.0,
            sigmaY: 2.0,
          ),
          child: const Align(
            alignment: Alignment.topCenter,
            child: LinearProgressIndicator(
                //   backgroundColor: AppColors.primary.shade50,
                ),
          ),
        );
      },
    );
  }

  Future<void> hidePreloader() async {
    final routeName = ModalRoute.of(context)?.settings.name;
    if (routeName == "preloader") {
      Navigator.of(context).pop();
    }
  }
}
