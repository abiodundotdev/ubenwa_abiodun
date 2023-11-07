import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ubenwa/core/core.dart';

class TitledCard extends StatelessWidget {
  final String title;
  final String? extra;
  final Widget content;
  final Color? titleColor;
  final TextStyle? titleTextStyle;
  final TextStyle? extraTextStyle;
  final VoidCallback? onExtraPressed;
  const TitledCard({
    Key? key,
    required this.title,
    required this.content,
    this.extra,
    this.onExtraPressed,
    this.titleColor,
    this.titleTextStyle,
    this.extraTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: titleTextStyle ??
                  theme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: const Color(0XFF686868),
                  ),
            ),
            if (extra != null && onExtraPressed != null)
              TextButton(
                onPressed: onExtraPressed,
                child: Text(
                  extra!,
                  style: extraTextStyle ??
                      theme.titleSmall!.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              )
          ],
        ),
        Gap(8.0.h),
        content
      ],
    );
  }
}
