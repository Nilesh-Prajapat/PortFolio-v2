import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFD32F2F);
const Color primaryColorLight = Color(0xFF17A2B8);

const Color lightBackground = Color(0xFFF2F2F2);
const Color darkBackground = Colors.black;

const Color lightTextColor = Colors.black;
const Color darkTextColor = Colors.white;

ThemeData lightTheme(double screenWidth) {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColorLight,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColorLight,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: lightBackground,
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontFamily: 'Space',
        fontSize: screenWidth * 0.02,
        color: lightTextColor,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Space',
        fontSize: screenWidth * 0.02,
        color: lightTextColor,
        fontWeight: FontWeight.normal,
      ),
      displayLarge: TextStyle(
        fontFamily: 'Space',
        fontSize: screenWidth * 0.03,
        color: lightTextColor,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColorLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: primaryColorLight, width: 3),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: lightBackground,
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        fontFamily: 'Space',
        fontSize: screenWidth * 0.03,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    ),
  );
}

ThemeData darkTheme(double screenWidth) {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: darkBackground,
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontFamily: 'Space',
        fontSize: screenWidth * 0.02,
        color: darkTextColor,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Space',
        fontSize: screenWidth * 0.02,
        color: darkTextColor,
        fontWeight: FontWeight.normal,
      ),
      displayLarge: TextStyle(
        fontFamily: 'Space',
        fontSize: screenWidth * 0.03,
        color: darkTextColor,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: primaryColor, width: 3),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: darkBackground,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontFamily: 'Space',
        fontSize: screenWidth * 0.03,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    ),
  );
}
