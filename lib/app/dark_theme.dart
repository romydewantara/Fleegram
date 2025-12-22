import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _primaryColor = Colors.white;
const _secondaryColor = Colors.white70;
const _backgroundColor = Colors.black;
const _surfaceColor = Color(0xFF121212);
const _errorColor = Colors.redAccent;
const _textPrimary = Colors.white;
const _textSecondary = Colors.white70;

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,

  dividerColor: Colors.white.withValues(alpha: 0.08),

  colorScheme: const ColorScheme.dark(
    primary: _primaryColor,
    secondary: _secondaryColor,
    surface: _surfaceColor,
    error: _errorColor,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: _textPrimary,
    onError: Colors.black,
  ),

  scaffoldBackgroundColor: _backgroundColor,

  appBarTheme: const AppBarTheme(
    backgroundColor: _surfaceColor,
    elevation: 0,
    foregroundColor: _textPrimary,
    centerTitle: false,
  ),

  textTheme: GoogleFonts.manropeTextTheme(
    const TextTheme(
      bodySmall: TextStyle(color: _textSecondary),
      bodyMedium: TextStyle(color: _textPrimary),
      bodyLarge: TextStyle(color: _textPrimary),

      titleSmall: TextStyle(fontWeight: FontWeight.w600, color: _textPrimary),
      titleMedium: TextStyle(fontWeight: FontWeight.w600, color: _textPrimary),
      titleLarge: TextStyle(fontWeight: FontWeight.w700, color: _textPrimary),

      headlineSmall: TextStyle(
        fontWeight: FontWeight.bold,
        color: _textPrimary,
      ),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.bold,
        color: _textPrimary,
      ),
      headlineLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: _textPrimary,
      ),
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
