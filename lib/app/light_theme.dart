import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _primaryColor = Color(0xFF01579B);
const _secondaryColor = Color(0xFF54C5F8);
const _backgroundColor = Color(0xFFF9FBFD);
const _surfaceColor = Colors.white;
const _errorColor = Color(0xFFD32F2F);
const _textPrimary = Color(0xFF0D1B2A);
const _textSecondary = Color(0xFF6B7280);

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,

  dividerColor: Colors.black.withValues(alpha: 0.08),

  colorScheme: const ColorScheme.light(
    primary: _primaryColor,
    secondary: _secondaryColor,
    surface: _surfaceColor,
    error: _errorColor,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: _textPrimary,
    onError: Colors.white,
  ),

  scaffoldBackgroundColor: _backgroundColor,

  appBarTheme: const AppBarTheme(
    backgroundColor: _surfaceColor,
    elevation: 0,
    foregroundColor: _textPrimary,
    centerTitle: false,
  ),

  textTheme: GoogleFonts.poppinsTextTheme(
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
    foregroundColor: Colors.white,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
    ),
  ),

  cardTheme: CardThemeData(
    color: _surfaceColor,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
);
