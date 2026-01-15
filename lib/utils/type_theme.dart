import 'dart:ui';

import 'package:flutter/material.dart';

class AppTypography {
  static TextTheme getTheme(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'PJS',
        fontWeight: FontWeight.bold,
        fontSize: 32,
        color: colorScheme.onSurface,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'PJS',
        fontWeight: FontWeight.w600,
        fontSize: 24,
        color: colorScheme.onSurface,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'PJS',
        fontWeight: FontWeight.normal,
        fontSize: 16,
        color: colorScheme.onSurface,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'PJS',
        fontWeight: FontWeight.normal,
        fontSize: 14,
        color: colorScheme.onSurfaceVariant,
      ),
      labelLarge: TextStyle(
        fontFamily: 'PJS',
        fontWeight: FontWeight.w600,
        fontSize: 14,
        letterSpacing: 0.5,
        color: colorScheme.primary,
      ),
    );
  }
}