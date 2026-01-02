import 'package:flutter/material.dart';

const _primaryColor = Color(0xFF01579B);
const _secondaryColor = Color(0xFF54C5F8);
const _tertiaryColor = Color(0xFF2191F6);
const _backgroundColor = Color(0xFFF9FBFD);
const _surfaceColor = Colors.white;
const _errorColor = Color(0xFFD32F2F);
const _textPrimary = Color(0xFF0D1B2A);
const _textSecondary = Color(0xFF6B7280);

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  iconTheme: IconThemeData(color: _primaryColor),

  dividerColor: Colors.black.withValues(alpha: .4),

  colorScheme: ColorScheme.light(
    primary: _primaryColor,
    secondary: _secondaryColor,
    tertiary: _tertiaryColor,
    surface: _surfaceColor,
    error: _errorColor,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: _textPrimary,
    onSurfaceVariant: _textSecondary,
    onError: Colors.white,
  ),

  scaffoldBackgroundColor: _backgroundColor,

  appBarTheme: AppBarTheme(
    backgroundColor: _surfaceColor,
    elevation: 0,
    foregroundColor: _textPrimary,
    centerTitle: false,
  ),

  textTheme: TextTheme(
    bodySmall: TextStyle(fontFamily: 'Manrope', color: _textSecondary),
    bodyMedium: TextStyle(fontFamily: 'Manrope', color: _textPrimary),
    bodyLarge: TextStyle(fontFamily: 'Manrope', color: _textPrimary),

    titleSmall: TextStyle(
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w600,
      color: _textPrimary,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Manrope',
      fontWeight: FontWeight.w600,
      color: _textPrimary,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Manrope',
      fontWeight: FontWeight.bold,
      color: _textPrimary,
    ),

    headlineSmall: TextStyle(
      fontFamily: 'Manrope',
      fontWeight: FontWeight.bold,
      color: _textPrimary,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Manrope',
      fontWeight: FontWeight.bold,
      color: _textPrimary,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'Manrope',
      fontWeight: FontWeight.bold,
      color: _textPrimary,
    ),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: _primaryColor,
    foregroundColor: Colors.white,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: TextStyle(fontWeight: FontWeight.w600),
    ),
  ),

  cardTheme: CardThemeData(
    color: _surfaceColor,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
);
