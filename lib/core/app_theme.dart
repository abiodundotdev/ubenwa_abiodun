import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubenwa/core/core.dart';

class AppTheme extends InheritedTheme {
  const AppTheme({super.key, required Widget child}) : super(child: child);

  static const Color hintColor = Color(0xFFAAAAAA);
  static const Color borderSideColor = Color(0x66D1D1D1);
  static Color borderSideErrorColor = Colors.red..shade900;
  static const Color textDarkColor = Color(0xFFFFFFFF);
  static const Color kTextLightColor = Color(0xFF000000);

  ThemeData light(ThemeData theme) {
    final textFieldBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0XFFD9D9D9)),
      borderRadius: BorderRadius.circular(5.0),
    );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: AppColors.primary,
      primaryColor: AppColors.primary,
      primaryIconTheme: theme.primaryIconTheme.copyWith(
        color: AppColors.primary,
      ),
      textTheme: theme.textTheme
          .copyWith(
            labelLarge: theme.textTheme.labelLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          )
          .apply(
            bodyColor: kTextLightColor,
            displayColor: kTextLightColor,
            fontFamily: AppFonts.inter,
          ),
      iconTheme: theme.iconTheme.copyWith(size: 20, color: AppColors.dark),
      listTileTheme: ListTileThemeData(
        tileColor: const Color(0XFFBCBBC1).withOpacity(.10),
      ),
      appBarTheme: theme.appBarTheme.copyWith(
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 14.0,
        ),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(color: AppColors.white),
      canvasColor: Colors.white,
      colorScheme: ColorScheme.light(primary: AppColors.primary),
      shadowColor: Colors.grey.shade400,
      buttonTheme: theme.buttonTheme.copyWith(
        height: 66.0,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),
        shape: const RoundedRectangleBorder(),
        highlightColor: Colors.white10,
        splashColor: Colors.white10,
        textTheme: ButtonTextTheme.primary,
      ),
      dividerTheme: DividerThemeData(
        color: const Color(0XFFBCBBC1).withOpacity(.10),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        border: textFieldBorder,
        focusedBorder: textFieldBorder.copyWith(
          borderSide: BorderSide(
            color: AppColors.primary,
          ),
        ),
        focusColor: AppColors.primary,
        suffixIconColor: const Color(0xFFC7C7C7),
        hintStyle: theme.textTheme.bodySmall!.copyWith(
          color: const Color(0XFFBFBFBF),
        ),
        enabledBorder: textFieldBorder,
        errorBorder: textFieldBorder.copyWith(
          borderSide: BorderSide(color: borderSideErrorColor, width: 1.0),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 13.0.h,
          horizontal: 12.0.h,
        ),
        fillColor: Colors.white,
        filled: true,
      ),
      textSelectionTheme: theme.textSelectionTheme.copyWith(
        cursorColor: AppColors.primary,
        selectionColor: AppColors.primary.shade300,
        selectionHandleColor: AppColors.primary.shade300,
      ),
      fontFamily: AppStrings.fontName,
      hintColor: hintColor,
      disabledColor: hintColor,
      dividerColor: borderSideColor,
    );
  }

  ThemeData dark(ThemeData theme) {
    final textFieldBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.grey),
      borderRadius: BorderRadius.circular(5.0),
    );

    return ThemeData(
      scaffoldBackgroundColor: AppColors.dark,
      primarySwatch: AppColors.primary,
      primaryColor: AppColors.primary,
      //brightness: Brightness.dark,
      primaryIconTheme: theme.primaryIconTheme.copyWith(
        color: AppColors.primary,
      ),
      textTheme: theme.textTheme
          .copyWith(
              labelLarge: theme.textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.w700,
              ),
              bodyMedium: theme.textTheme.bodyMedium!.copyWith(
                color: AppColors.dark,
              ))
          .apply(
            bodyColor: textDarkColor,
            displayColor: textDarkColor,
            fontFamily: AppStrings.fontName,
          ),
      iconTheme: theme.iconTheme.copyWith(size: 20, color: AppColors.white),
      appBarTheme: theme.appBarTheme.copyWith(
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 14.0,
        ),
      ),
      listTileTheme: ListTileThemeData(
        tileColor: const Color(0XFFBCBBC1).withOpacity(.20),
      ),
      canvasColor: AppColors.dark,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: AppColors.primary,
        accentColor: AppColors.accent,
      ),
      shadowColor: Colors.grey.shade400,
      buttonTheme: theme.buttonTheme.copyWith(
        height: 66.0,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: AppColors.primary,
        ),
        shape: const RoundedRectangleBorder(),
        highlightColor: Colors.white10,
        splashColor: Colors.white10,
        textTheme: ButtonTextTheme.primary,
      ),
      bottomAppBarTheme: BottomAppBarTheme(color: AppColors.dark),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        border: textFieldBorder,
        focusedBorder: textFieldBorder,
        suffixIconColor: const Color(0xFFC7C7C7),
        hintStyle:
            theme.textTheme.bodySmall!.copyWith(color: AppColors.grey.shade900),
        enabledBorder: textFieldBorder,
        errorBorder: textFieldBorder.copyWith(
            borderSide: BorderSide(color: borderSideErrorColor, width: 1.0)),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 12.0,
        ),
        fillColor: AppColors.grey.shade500,
        filled: true,
        //errorStyle: AppFonts.normal(),
      ),
      textSelectionTheme: theme.textSelectionTheme.copyWith(
        cursorColor: Colors.white,
        selectionColor: AppColors.primary,
        selectionHandleColor: AppColors.primary.shade300,
      ),
      fontFamily: AppStrings.fontName,
      hintColor: hintColor,
      disabledColor: hintColor,
      dividerColor: borderSideColor,
    );
  }

  static AppTheme? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppTheme>();
  }

  static AppTheme of(BuildContext context) {
    final AppTheme? result = maybeOf(context);
    assert(result != null, 'No FrogColor found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant AppTheme oldWidget) {
    return true;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return AppTheme(
      child: child,
    );
  }
}
