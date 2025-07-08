import 'package:flutter/material.dart';

class AppColors {
  final bool isDark;

  AppColors({this.isDark = false});

  final Duration animationDuration = const Duration(milliseconds: 300);

  Color get mainColor => const Color(0xff0BC266);

  Color get sidebarBG => isDark ? const Color(0xff0B3D2E) : const Color(0xffDFF5E3);

  Color get secondaryColor => const Color(0xffA5E6B2);

  Color get accentColor => isDark ? const Color(0xff26734D) : const Color(0xffE8F9ED);

  Color get highlightColor => const Color(0xFF65C2F5);

  Color get actionColor => const Color(0xFF09B1EC);

  Color get textColor => isDark ? Colors.white : const Color(0xff0B3D2E);

  Color get secondaryTextColor => isDark ? const Color(0xffb2b2b2) : const Color(0xff5c8a72);

  Color get appBarColor => isDark ? const Color(0xff0B3D2E) : mainColor;

  Color get appBarTextColor => Colors.white;

  Color get appBarIconColor => Colors.white;

  Color get scaffoldBgColor => isDark ? const Color(0xff001F12) : const Color(0xffF2FBF5);

  Color get cardColor => isDark ? const Color(0xff1A3D32) : Colors.white;

  Color get dividerColor => isDark ? Colors.grey[700]! : Colors.grey[300]!;

  Color get buttonColor => mainColor;

  Color get iconColor => isDark ? Colors.white : mainColor;

  ThemeData get themeData => ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: isDark ? Brightness.dark : Brightness.light,
    primaryColor: mainColor,
    scaffoldBackgroundColor: scaffoldBgColor,
    appBarTheme: AppBarTheme(
      backgroundColor: appBarColor,
      titleTextStyle: TextStyle(color: appBarTextColor, fontSize: 20, fontFamily: "Medium"),
      iconTheme: IconThemeData(color: appBarIconColor),
    ),
    cardColor: cardColor,
    dividerColor: dividerColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: Colors.white,
      ),
    ),
    iconTheme: IconThemeData(color: iconColor),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: textColor, fontFamily: "Extra-Bold"),
      bodyMedium: TextStyle(color: textColor, fontFamily: "Medium"),
      bodySmall: TextStyle(color: secondaryTextColor, fontFamily: "Regular"),
    ),
  );

  Color get green => const Color(0xff0BC266);

  Color get red => const Color(0xffD05333);

  get amber => Colors.amber;

  get purple => Colors.purple;

  Color get yellow => Colors.yellow;

  Color get orange => Colors.orange;

  Color get pink => Colors.pink;

  get white => Colors.white;

  get black => Colors.black;
}
