import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFF2196F3);
const Color primaryColorLight = Color(0xFFFF6D00);

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
    textTheme: GoogleFonts.spaceMonoTextTheme().apply(
      bodyColor: lightTextColor,
      displayColor: lightTextColor,
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
      scrolledUnderElevation: 0,
      elevation: 0,
      backgroundColor: lightBackground,
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: GoogleFonts.spaceMono(
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
    textTheme: GoogleFonts.spaceMonoTextTheme().apply(
      bodyColor: darkTextColor,
      displayColor: darkTextColor,
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
      titleTextStyle: GoogleFonts.spaceMono(
        fontSize: screenWidth * 0.03,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    ),
  );
}
