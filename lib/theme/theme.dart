import 'package:flutter/material.dart';

class AppTheme {
  static const Color vibrantYellow = Color(0xFFFFC107);
  static const Color deepBlack = Color(0xFF1C2526);
  static const Color softGray = Color(0xFFB0BEC5);
  static const Color calmingTeal = Color(0xFF26A69A);
  static const Color playfulCoral = Color(0xFFFF6F61);
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFE0E0E0);
  // New colors for the additional moods
  static const Color cheerfulPink = Color(0xFFF06292); // For Happy
  static const Color boldOrange = Color(0xFFFF5722); // For Adventurous

  static Color getMoodColor(String mood) {
    switch (mood) {
      case 'Relaxed':
        return calmingTeal;
      case 'Excited':
        return playfulCoral;
      case 'Tired':
        return softGray;
      case 'Happy':
        return cheerfulPink; // New mood color
      case 'Adventurous':
        return boldOrange; // New mood color
      default:
        return vibrantYellow;
    }
  }

  static final ThemeData lightTheme = ThemeData(
    primaryColor: vibrantYellow,
    scaffoldBackgroundColor: pureWhite,
    cardColor: softGray,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: deepBlack),
      bodyMedium: TextStyle(color: lightGray),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: vibrantYellow,
        foregroundColor: deepBlack,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      filled: true,
      fillColor: softGray,
      labelStyle: TextStyle(color: lightGray),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: vibrantYellow,
    scaffoldBackgroundColor: deepBlack,
    cardColor: softGray,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: pureWhite),
      bodyMedium: TextStyle(color: lightGray),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: vibrantYellow,
        foregroundColor: deepBlack,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      filled: true,
      fillColor: softGray,
      labelStyle: TextStyle(color: lightGray),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: deepBlack,
      titleTextStyle: TextStyle(
        color: pureWhite,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(deepBlack),
      ),
      textStyle: TextStyle(color: pureWhite),
    ),
  );
}
