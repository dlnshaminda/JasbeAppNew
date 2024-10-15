import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jasbe/common/colors.dart';
import 'package:jasbe/common/custom/ink_ripple_fast.dart';
import 'package:jasbe/common/functions.dart';

class JasbeThemes {
  // Light Theme
  static ThemeData light = ThemeData.light().copyWith(
    useMaterial3: true,
    primaryColor: mainColor,
    dividerColor: gitHubLightBorderColor,
    brightness: Brightness.light,
    focusColor: mainColor,
    highlightColor: gitHubLightHilightColor,
    dialogBackgroundColor: gitHubLightBackgroundColor,
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: getMaterialColor(mainColor),
        accentColor: gitHubLightAccentColor,
        backgroundColor: gitHubLightBackgroundColor,
        cardColor: gitHubLightSecondBackgroundColor,
        errorColor: gitHubLightErrorColor),
    textTheme: ThemeData.light().textTheme.apply(
          displayColor: gitHubLightTextColor,
          bodyColor: gitHubLightTextColor,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
    scaffoldBackgroundColor: gitHubLightBackgroundColor,
    splashFactory: InkRippleFast.splashFactory,
    bottomSheetTheme: const BottomSheetThemeData(surfaceTintColor: Colors.transparent, backgroundColor: Colors.transparent),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: gitHubLightSecondBackgroundColor,
    ),
    appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.transparent,
        backgroundColor: gitHubLightBackgroundColor,
        foregroundColor: gitHubLightForegroundColor,
       ),
    cardTheme: const CardTheme(surfaceTintColor: Colors.transparent, color: gitHubLightSecondBackgroundColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: mainColor, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20))),
    outlinedButtonTheme: OutlinedButtonThemeData(style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20))),
    textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20))),
    popupMenuTheme: PopupMenuThemeData(
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    dialogTheme: const DialogTheme(surfaceTintColor: Colors.transparent),
  );
}
