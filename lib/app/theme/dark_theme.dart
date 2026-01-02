import 'package:flutter/material.dart';

const _primaryColor = Colors.white;
const _secondaryColor = Colors.white70;
const _tertiaryColor = Color(0xFF50A0F3);
const _backgroundColor = Colors.black;
const _surfaceColor = Color(0xFF121212);
const _errorColor = Colors.redAccent;
const _textPrimary = Colors.white;
const _textSecondary = Colors.white70;

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  iconTheme: const IconThemeData(color: Colors.white),

  dividerColor: Colors.white.withValues(alpha: .4),

  colorScheme: ColorScheme.dark(
    primary: _primaryColor,
    secondary: _secondaryColor,
    tertiary: _tertiaryColor,
    surface: _surfaceColor,
    error: _errorColor,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: _textPrimary,
    onSurfaceVariant: _textSecondary,
    onError: Colors.black,
  ),

  scaffoldBackgroundColor: _backgroundColor,

  appBarTheme: const AppBarTheme(
    backgroundColor: _surfaceColor,
    elevation: 0,
    foregroundColor: _textPrimary,
    centerTitle: false,
  ),

  textTheme: TextTheme(
    bodySmall: const TextStyle(fontFamily: 'Manrope', color: _textSecondary),
    bodyMedium: const TextStyle(fontFamily: 'Manrope', color: _textPrimary),
    bodyLarge: const TextStyle(fontFamily: 'Manrope', color: _textPrimary),

    titleSmall: const TextStyle(
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w600,
      color: _textPrimary,
    ),
    titleMedium: const TextStyle(
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w600,
      color: _textPrimary,
    ),
    titleLarge: const TextStyle(
      fontFamily: 'Manrope',
      fontWeight: FontWeight.bold,
      color: _textPrimary,
    ),

    headlineSmall: const TextStyle(
      fontFamily: 'Manrope',
      fontWeight: FontWeight.bold,
      color: _textPrimary,
    ),
    headlineMedium: const TextStyle(
      fontFamily: 'Manrope',
      fontWeight: FontWeight.bold,
      color: _textPrimary,
    ),
    headlineLarge: const TextStyle(
      fontFamily: 'Manrope',
      fontWeight: FontWeight.bold,
      color: _textPrimary,
    ),
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: _primaryColor,
    foregroundColor: Colors.black,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
    ),
  ),

  cardTheme: CardThemeData(
    color: _surfaceColor,
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
);
