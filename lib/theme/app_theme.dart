import 'package:flutter/material.dart';

/// Centralised color palette, pulled directly from the corrected DineEasy
/// Figma file (post Assessment-3-feedback contrast fix).
class AppColors {
  AppColors._();

  static const background = Color(0xFFFDF0E4); // warm cream
  static const cardWhite = Color(0xFFFFFFFF);

  /// Brand accent for large fills / icons where no text sits on top.
  static const primaryOrange = Color(0xFFE85D2A);

  /// Used wherever the orange carries white text (selected chips, primary
  /// buttons). Corrected from #E85D2A -> #C2410C during Cowork's contrast
  /// pass: raises white-on-orange contrast from ~3.48:1 to ~5.18:1,
  /// clearing the WCAG 2.2 AA 4.5:1 minimum for normal text.
  static const selectedOrange = Color(0xFFC2410C);

  static const textDark = Color(0xFF1A1A1A);
  static const textMuted = Color(0xFF6B6B6B);
  static const success = Color(0xFF1D8A4C);
  static const successBg = Color(0xFFE3F5EA);
  static const border = Color(0xFFEFE1D3);
}

class AppTextStyles {
  AppTextStyles._();

  static const heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static const subheading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  static const body = TextStyle(
    fontSize: 14,
    color: AppColors.textMuted,
  );

  static const bodyDark = TextStyle(
    fontSize: 14,
    color: AppColors.textDark,
  );

  static const caption = TextStyle(
    fontSize: 12,
    color: AppColors.textMuted,
  );

  static const button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const buttonOutline = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.selectedOrange,
  );
}

class AppSpacing {
  AppSpacing._();

  static const s = 8.0;
  static const m = 16.0;
  static const l = 24.0;
  static const xl = 32.0;
}

class AppRadius {
  AppRadius._();

  static const card = 20.0;
  static const chip = 12.0;
  static const button = 28.0;
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: 'Roboto',
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.selectedOrange,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.textDark),
      titleTextStyle: AppTextStyles.subheading,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.chip),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
