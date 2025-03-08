import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFDC3545); // Bootstrap Red
const Color primaryColorLight = Color(0xFF003A75 ); // Material Indigo Blue

const Color lightBackground = Color(0xFFF2F2F2); // Warm off-white
const Color darkBackground = Colors.black; // True dark

const Color lightTextColor = Color(0xFF212121); // Soft dark gray
const Color darkTextColor = Colors.white;

TextStyle baseTextStyle(double fontSize, Color color) {
  return TextStyle(
    fontFamily: 'Space',
    fontSize: fontSize,
    color: color,
    fontWeight: FontWeight.normal,
  );
}

TextStyle headerTextStyle(double fontSize, Color color) {
  return TextStyle(
    fontFamily: 'Space',
    fontSize: fontSize,
    color: color,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
  );
}

ThemeData appTheme(double screenWidth, bool isDarkMode) {
  return ThemeData(
    brightness: isDarkMode ? Brightness.dark : Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: isDarkMode ? darkBackground : lightBackground,
    textTheme: TextTheme(
      bodyLarge: baseTextStyle(screenWidth * 0.02, isDarkMode ? darkTextColor : lightTextColor),
      bodyMedium: baseTextStyle(screenWidth * 0.02, isDarkMode ? darkTextColor : lightTextColor),
      displayLarge: headerTextStyle(screenWidth * 0.03, isDarkMode ? darkTextColor : lightTextColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: primaryColor, width: 3),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: isDarkMode ? Colors.black : lightBackground,
      iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
      titleTextStyle: headerTextStyle(screenWidth * 0.03, isDarkMode ? Colors.white : Colors.black),
    ),
  );
}
