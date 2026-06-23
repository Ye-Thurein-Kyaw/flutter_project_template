import 'package:flutter/material.dart';

bool isDarkTheme(BuildContext context) => Theme.of(context).brightness == Brightness.dark;

ThemeData kLightTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: const Color(0xFF005BAA),
    primaryContainer: const Color(0xFF3d83ff),
    secondary: const Color(0xFFFFFFFF),
    secondaryContainer: const Color(0xFF272727),
    onSurface: const Color(0xFFFFFFFF),
    surface: const Color(0xFFFFFFFF),
    onSecondary: const Color(0xFFFFFFFF),
    onSecondaryContainer: const Color(0xFF272727),
    onPrimary: const Color(0xFFFAFAFA),
    tertiary: const Color(0xFFE2E2E2),
    onTertiaryContainer: const Color(0xFFCECECE),
    brightness: Brightness.light,
    onPrimaryContainer: const Color(0xFF373A40),
  ),
);

ThemeData kDarkTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: const Color(0xFF1a1f38),
    primaryContainer: const Color(0xFF3d83ff),
    secondary: const Color(0xFF151a30),
    secondaryContainer: const Color(0xFFFEFEFE),
    onSurface: const Color(0xFF151a30),
    surface: const Color(0xFFFFFFFF),
    onSecondary: const Color(0xFF151a30),
    onSecondaryContainer: const Color(0xFF30385D),
    onPrimary: const Color(0xFF30385D),
    tertiary: const Color(0xFF1a1f38),
    onTertiaryContainer: const Color(0xFF1A1F38),
    brightness: Brightness.dark,
    onPrimaryContainer:const Color(0xFFF5F5F5),
  ),
);
