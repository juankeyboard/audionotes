import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Tema global "Sonic Clarity" — MD3 light
/// Equivalente al Window.clearcolor y paleta definida en main.py / home.kv
class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          surface: AppColors.surface,
          onSurface: AppColors.onSurface,
          onPrimary: AppColors.white,
          surfaceContainerLow: AppColors.surfaceLow,
          surfaceContainer: AppColors.surfaceContainer,
          outline: AppColors.outlineVariant,
          error: AppColors.error,
        ),
        scaffoldBackgroundColor: AppColors.surface,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.surfaceLow,
          foregroundColor: AppColors.onSurface,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.onSurface,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceContainer,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 16,
          ),
          hintStyle: const TextStyle(color: AppColors.outlineVariant),
        ),
      );
}
