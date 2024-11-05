import 'dart:ui';
import 'package:flutter/material.dart';

import 'ThemeColors.dart';

class CustomTheme {
  // Colors
  final errorColor = Colors.red;
  final successColor = Colors.green;

  // Font Sizes
  final soulMilanFontSize = 40.0;
  final onBoardingHeadingFontSize = 24.0;
  final onBoardingSubHeadingFontSize = 18.0;
  final soulMilanSubscriptionFontSize = 20.0;
  final authHeadingsFontSize = 28.0;
  final socialTextSize = 16.0;
  final fontSize = 14.0;
  final fontSize1 = 15.0;
  final paddingInput = 15.0;
  final errorBorderWidth = 2.0;
  final subDetails = 32.0;

  ThemeData theme() {
    ThemeColors color = ThemeColors();
    return ThemeData(
      primaryColor: color.soulColor,
      secondaryHeaderColor: color.milanColor,
      scaffoldBackgroundColor: color.scaffoldColor,
      primaryColorDark: color.onBoardingHeadingColor,
      primaryColorLight: color.onBoardingSubTextColor,

      // Fonts
      fontFamily: "Urbanist",

      // Complete Theme
      textTheme: textTheme(),
      inputDecorationTheme: inputDecorationTheme(),
    );
  }
  InputDecorationTheme inputDecorationTheme() {
    ThemeColors color = ThemeColors();
    return InputDecorationTheme(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: color.enabledBorderColor,
        ),
      ),
        errorStyle: const TextStyle(height: 0),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: errorColor,
            width: errorBorderWidth,
          ),
        ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: color.labelTextColor,
        ),
      ),
      contentPadding: EdgeInsets.all(paddingInput),
      hintStyle: TextStyle(
        color: color.hintTextColor,
      ),
      labelStyle: TextStyle(
        color: color.labelTextColor,
      ),
    );
  }

  TextTheme textTheme() {
    ThemeColors color = ThemeColors();
    return TextTheme(
      displayLarge: TextStyle(color: color.soulColor, fontSize: soulMilanFontSize, fontWeight: FontWeight.bold,),
      displayMedium: TextStyle(color: color.milanColor, fontSize: soulMilanFontSize, fontWeight: FontWeight.bold,),
      displaySmall: TextStyle(color: color.onBoardingHeadingColor, fontSize: onBoardingHeadingFontSize, fontWeight: FontWeight.bold,),
      headlineMedium: TextStyle(color: color.onBoardingHeadingColor, fontSize: onBoardingSubHeadingFontSize, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(color: color.onBoardingHeadingColor, fontSize: authHeadingsFontSize,fontWeight: FontWeight.w500),
      headlineLarge: TextStyle(color: color.buttonColor, fontSize:fontSize, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: color.blackColor, fontSize: onBoardingSubHeadingFontSize,),
      titleLarge: TextStyle(color: color.buttonColor, fontSize:fontSize,),
      titleSmall: TextStyle(color: color.onBoardingHeadingColor, fontSize: socialTextSize,),
      bodyLarge: TextStyle(color: color.deleteFromThisDevice, fontSize: fontSize,),
      bodyMedium: TextStyle(color: color.buttonColor, fontSize: socialTextSize, fontWeight: FontWeight.w600),
      bodySmall: TextStyle(color: color.onBoardingHeadingColor, fontSize: fontSize1),
      labelSmall: TextStyle(color: color.buttonColor, fontSize: fontSize1,),
      labelMedium: TextStyle(color: color.onBoardingHeadingColor, fontSize: onBoardingSubHeadingFontSize, fontWeight: FontWeight.w600),
      labelLarge: TextStyle(color: color.deleteFromThisDevice, fontSize: onBoardingSubHeadingFontSize,fontWeight: FontWeight.w300),
      
    );
  }
}