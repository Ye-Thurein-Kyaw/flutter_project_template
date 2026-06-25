import 'package:flutter/material.dart';

bool isDarkTheme(BuildContext context) => Theme.of(context).brightness == Brightness.dark;

ThemeData kLightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF005BAA),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFD7E9FF),
    onPrimaryContainer: Color(0xFF003A65),
    secondary: Color(0xFF3d83ff),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFDCE5FF),
    onSecondaryContainer: Color(0xFF103A8D),
    tertiary: Color(0xFF6B5CA8),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFEBDDFF),
    onTertiaryContainer: Color(0xFF25184D),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF1a1f38),
    outline: Color(0xFFD8DCE6),
    error: Color(0xFFB3261E),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    bodyMedium: TextStyle(fontSize: 14),
    bodySmall: TextStyle(fontSize: 12),
  ),
);

ThemeData kDarkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF3d83ff),
    onPrimary: Color(0xFF002A72),
    primaryContainer: Color(0xFF0F4AA1),
    onPrimaryContainer: Color(0xFFD7E9FF),
    secondary: Color(0xFF82A8FF),
    onSecondary: Color(0xFF0C214D),
    secondaryContainer: Color(0xFF27468E),
    onSecondaryContainer: Color(0xFFDCE5FF),
    tertiary: Color(0xFFC8B7FF),
    onTertiary: Color(0xFF35265F),
    tertiaryContainer: Color(0xFF4D3C84),
    onTertiaryContainer: Color(0xFFEBDDFF),
    surface: Color(0xFF1a1f38),
    onSurface: Color(0xFFF5F7FF),
    outline: Color(0xFF30385D),
    error: Color(0xFFFF6B6B),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    bodyMedium: TextStyle(fontSize: 14),
    bodySmall: TextStyle(fontSize: 12),
  ),
);
