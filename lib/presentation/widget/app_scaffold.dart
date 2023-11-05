import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppScaffold extends StatefulWidget {
  final Widget body;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final bool useSafeArea;
  const AppScaffold(
      {required this.body,
      this.appBar,
      this.backgroundColor,
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
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: body,
      appBar: widget.appBar,
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }

  Widget get body {
    final result = Padding(
      padding: widget.padding ?? EdgeInsets.all(10.0.w),
      child: widget.body,
    );
    if (!widget.useSafeArea) return result;
    return SafeArea(
      child: result,
    );
  }
}
