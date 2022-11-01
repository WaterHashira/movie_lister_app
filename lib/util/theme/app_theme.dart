import 'package:flutter/material.dart';
import 'package:movie_lister_app/util/color_constants.dart';

class AppTheme {
  static const _designFileWidth = 360;
  static final _deviceWidth = MediaQueryData.fromWindow(
    WidgetsBinding.instance.window,
  ).size.width;

  static double getAdaptiveSize(double size) =>
      size * _deviceWidth / _designFileWidth;

  static const _defaultElevation = 2.5;
  static const _defaultFontFamily = 'Inter';

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorConstants.appGeneralBackgroundColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ColorConstants.inactiveCardColor,
      elevation: _defaultElevation,
      selectedItemColor: ColorConstants.bottomNavigtionSelectedItemColor,
      type: BottomNavigationBarType.fixed,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: getAdaptiveSize(32),
        color: const Color(0xFFFFFFFF),
        fontFamily: _defaultFontFamily,
        fontWeight: FontWeight.w600,
      ),
      headline2: TextStyle(
        fontSize: getAdaptiveSize(24),
        color: const Color(0xFFFFFFFF),
        fontFamily: _defaultFontFamily,
        fontWeight: FontWeight.w600,
      ),
      headline3: TextStyle(
        fontSize: getAdaptiveSize(14),
        fontFamily: _defaultFontFamily,
        color: const Color(0xFFFFFFFF),
        fontWeight: FontWeight.w400,
      ),
      headline4: TextStyle(
        fontSize: getAdaptiveSize(12),
        fontFamily: _defaultFontFamily,
        color: const Color(0xFFFFFFFF).withOpacity(0.6),
        fontWeight: FontWeight.w400,
      ),
      headline5: TextStyle(
        fontSize: getAdaptiveSize(20),
        fontFamily: _defaultFontFamily,
        color: const Color(0xFFFFFFFF),
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
