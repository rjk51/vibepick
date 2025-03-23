import 'package:flutter/material.dart';

// Define the VibePick app theme
class AppTheme {
  // Color palette based on the VibePick logo and app requirements
  static const Color vibrantYellow = Color(0xFFFFC107); // Primary color for buttons, highlights
  static const Color deepBlack = Color(0xFF1C2526); // Background color
  static const Color softGray = Color(0xFFB0BEC5); // Secondary backgrounds (cards, inputs)
  static const Color calmingTeal = Color(0xFF26A69A); // Accent for "Relaxed" mood
  static const Color playfulCoral = Color(0xFFFF6F61); // Accent for "Excited" mood
  static const Color pureWhite = Color(0xFFFFFFFF); // Primary text
  static const Color lightGray = Color(0xFFE0E0E0); // Secondary text

  // Mood-based color mapping
  static Color getMoodColor(String mood) {
    switch (mood) {
      case 'Relaxed':
        return calmingTeal;
      case 'Excited':
        return playfulCoral;
      case 'Tired':
        return softGray;
      default:
        return vibrantYellow;
    }
  }

  // Light theme (optional, for future use)
  static final ThemeData lightTheme = ThemeData(
    primaryColor: vibrantYellow,
    scaffoldBackgroundColor: pureWhite,
    cardColor: softGray,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: deepBlack), // Primary text
      bodyMedium: TextStyle(color: lightGray), // Secondary text
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

  // Dark theme (default for VibePick)
  static final ThemeData darkTheme = ThemeData(
    primaryColor: vibrantYellow,
    scaffoldBackgroundColor: deepBlack,
    cardColor: softGray,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: pureWhite), // Primary text
      bodyMedium: TextStyle(color: lightGray), // Secondary text
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
