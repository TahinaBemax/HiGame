import 'package:flutter/material.dart';
import 'tokens/app_colors.dart';

abstract class AppTextStyles {
  static const String _fontFamily = 'Inter';

  static TextTheme get light => _buildTextTheme(AppColors.textPrimary);

  static TextTheme _buildTextTheme(Color baseColor) {
    return TextTheme(
      headlineLarge: _style(24, FontWeight.w700, baseColor, height: 32 / 24),
      headlineMedium: _style(18, FontWeight.w600, baseColor, height: 24 / 18),
      headlineSmall: _style(16, FontWeight.w600, baseColor, height: 22 / 16),
      titleLarge: _style(20, FontWeight.w700, baseColor, height: 26 / 20),
      titleMedium: _style(16, FontWeight.w600, baseColor, letterSpacing: 0.15),
      titleSmall: _style(14, FontWeight.w600, baseColor, letterSpacing: 0.1),
      bodyLarge: _style(16, FontWeight.w400, baseColor, height: 1.5),
      bodyMedium: _style(14, FontWeight.w400, baseColor, height: 1.43),
      bodySmall:
          _style(12, FontWeight.w400, AppColors.textSecondary, height: 1.33),
      labelLarge: _style(15, FontWeight.w600, baseColor, letterSpacing: 0.1),
      labelMedium: _style(12, FontWeight.w500, baseColor, letterSpacing: 0.5),
      labelSmall: _style(11, FontWeight.w500, AppColors.textSecondary,
          letterSpacing: 0.5),
    );
  }

  static TextStyle _style(
    double size,
    FontWeight weight,
    Color color, {
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      decoration: TextDecoration.none,
    );
  }

  static TextStyle monetary(Color color) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: color,
      height: 26 / 20,
    );
  }
}
