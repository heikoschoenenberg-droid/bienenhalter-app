import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.goldText,
      onPrimary: Colors.white,
      secondary: AppColors.sageGreen,
      onSecondary: Colors.white,
      tertiary: AppColors.honeyYellow,
      onTertiary: AppColors.anthracite,
      error: AppColors.warningRed,
      onError: Colors.white,
      errorContainer: AppColors.warningBackground,
      onErrorContainer: AppColors.warningRed,
      surface: AppColors.cardSurface,
      onSurface: AppColors.anthracite,
      surfaceContainerHighest: Color(0xFFF0EEE3),
      onSurfaceVariant: Color(0xFF4F5349),
      outline: Color(0xFF7C806F),
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.lightBackground,
      primaryColor: AppColors.goldText,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        foregroundColor: AppColors.anthracite,
        centerTitle: false,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        margin: EdgeInsets.zero,
        color: colorScheme.surface,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.goldText,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.goldText,
          side: const BorderSide(color: AppColors.goldText),
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.goldText),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.goldText,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.goldText, width: 2),
        ),
        prefixIconColor: AppColors.goldText,
        suffixIconColor: AppColors.goldText,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.warmChipBackground,
        selectedColor: AppColors.goldText,
        checkmarkColor: Colors.white,
        labelStyle: const TextStyle(color: AppColors.anthracite),
        secondaryLabelStyle: const TextStyle(color: Colors.white),
        iconTheme: const IconThemeData(color: AppColors.goldText),
        side: const BorderSide(color: Color(0xFFD8C483)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.anthracite,
        contentTextStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
