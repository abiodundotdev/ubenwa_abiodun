import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

extension XList on List<Widget> {
  // List<Widget> spacedColumn(
  //     {required double space, bool includeBottom = true}) {
  //   return List.generate(
  //     length,
  //     (index) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: [
  //         this[index],
  //         if (index < length - 1) Gap(space.h),
  //       ],
  //     ),
  //   );
  // }

  List<Widget> spacedRow({required double space, bool includeBottom = true}) {
    return List.generate(
      length,
      (index) => Row(
        children: [
          this[index],
          if (index < length - 1) Gap(space.h),
        ],
      ),
    );
  }
}
