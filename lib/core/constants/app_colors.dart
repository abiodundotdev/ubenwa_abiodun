import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const Color _basePrimary = Color(0XFF4476F6);
  static const Color _baseRed = Color(0XFFB91C1C);
  static const Color _baseSecondary = Color(0XFF282828);
  static const Color _baseYellow = Color(0xFFFF991f);
  static const Color _basePurple = Color(0xFF5243AA);
  static const Color _baseGreen = Color(0xFF064E3B);
  static const Color _baseDark = Color(0xFF151411);
  static const Color _baseGrey = Color(0xFFBCBBC1);

  static MaterialColor green = MaterialColor(
    _baseGreen.value,
    <int, Color>{
      50: _baseGreen.withOpacity(.1),
      100: _baseGreen.withOpacity(.2),
      200: _baseGreen.withOpacity(.3),
      300: _baseGreen.withOpacity(.4),
      400: _baseGreen.withOpacity(.5),
      500: _baseGreen.withOpacity(.1),
      600: _baseGreen.withOpacity(.7),
      700: _baseGreen.withOpacity(.8),
      800: _baseGreen.withOpacity(.9),
      900: _baseGreen.withOpacity(1),
    },
  );

  static MaterialColor grey = MaterialColor(
    _baseGrey.value,
    <int, Color>{
      50: _baseGrey.withOpacity(.1),
      100: _baseGrey.withOpacity(.2),
      200: _baseGrey.withOpacity(.3),
      300: _baseGrey.withOpacity(.4),
      400: _baseGrey.withOpacity(.5),
      500: _baseGrey.withOpacity(.1),
      600: _baseGrey.withOpacity(.7),
      700: _baseGrey.withOpacity(.8),
      800: _baseGrey.withOpacity(.9),
      900: _baseGrey.withOpacity(1),
    },
  );

  static MaterialColor dark = MaterialColor(
    _baseDark.value,
    <int, Color>{
      50: _baseDark.withOpacity(.1),
      100: _baseDark.withOpacity(.2),
      200: _baseDark.withOpacity(.3),
      300: _baseDark.withOpacity(.4),
      400: _baseDark.withOpacity(.5),
      500: _baseDark.withOpacity(.6),
      600: _baseDark.withOpacity(.7),
      700: _baseDark.withOpacity(.8),
      800: _baseDark.withOpacity(.9),
      900: _baseDark.withOpacity(1),
    },
  );

  static const MaterialColor white = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFfafafa),
      200: Color(0xFFf5f5f5),
      300: Color(0xFFf0f0f0),
      400: Color(0xFFdedede),
      500: Color(0xFFc2c2c2),
      600: Color(0xFF979797),
      700: Color(0xFF818181),
      800: Color(0xFF606060),
      900: Color(0xFF3c3c3c),
    },
  );

  static MaterialColor purple = MaterialColor(
    _basePurple.value,
    <int, Color>{
      50: _basePurple.withOpacity(.1),
      100: _basePurple.withOpacity(.2),
      200: _basePurple.withOpacity(.3),
      300: _basePurple.withOpacity(.4),
      400: _basePurple.withOpacity(.5),
      500: _basePurple.withOpacity(.1),
      600: _basePurple.withOpacity(.7),
      700: _basePurple.withOpacity(.8),
      800: _basePurple.withOpacity(.9),
      900: _basePurple.withOpacity(1),
    },
  );

  static MaterialColor yellow = MaterialColor(
    _baseYellow.value,
    <int, Color>{
      50: _baseYellow.withOpacity(.1),
      100: _baseYellow.withOpacity(.2),
      200: _baseYellow.withOpacity(.3),
      300: _baseYellow.withOpacity(.4),
      400: _baseYellow.withOpacity(.5),
      500: _baseYellow.withOpacity(.1),
      600: _baseYellow.withOpacity(.7),
      700: _baseYellow.withOpacity(.8),
      800: _baseYellow.withOpacity(.9),
      900: _baseYellow.withOpacity(1),
    },
  );

  static MaterialColor primary = MaterialColor(
    _basePrimary.value,
    const <int, Color>{
      50: Color(0XFFA7C0FF),
      100: Color(0XFFA7C0FF),
      200: Color(0XFF7096F8),
      300: Color(0XFF7096F8),
      400: Color(0XFF4476F6),
      500: Color(0XFF4476F6),
      600: Color(0XFF1C419E),
      700: Color(0XFF1C419E),
      800: Color(0XFF0D2D80),
      900: Color(0XFF0D2D80),
    },
  );

  static MaterialColor accent = MaterialColor(
    _baseRed.value,
    const <int, Color>{
      50: Color(0XFFFCF3DD),
      100: Color(0XFFFCF3DD),
      200: Color(0XFFFEE6AF),
      300: Color(0XFFFEE6AF),
      400: Color(0XFFFFC847),
      500: Color(0XFFFFC847),
      600: Color(0XFFFFB300),
      700: Color(0XFFFFB300),
      800: Color(0XFF8A6103),
      900: Color(0XFF8A6103),
    },
  );

  static MaterialColor secondary = MaterialColor(
    _baseSecondary.value,
    const <int, Color>{
      50: Color(0XFF666666),
      100: Color(0XFF666666),
      200: Color(0XFF3A3A3A),
      300: Color(0XFF3A3A3A),
      400: Color(0XFF313131),
      500: Color(0XFF313131),
      600: Color(0XFF282828),
      700: Color(0XFF282828),
      800: Color(0XFF171717),
      900: Color(0XFF171717),
    },
  );
}
