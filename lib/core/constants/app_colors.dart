import 'package:flutter/material.dart';

/// Paleta "Sonic Clarity" — MD3 light theme
/// Mismos valores que en kv/home.kv de Audionotes (Kivy)
class AppColors {
  AppColors._();

  // Primary — #004CED
  static const Color primary = Color(0xFF004CED);

  // Superficie base — #F8F9FA
  static const Color surface = Color(0xFFF8F9FA);

  // Superficie baja — #F1F4F6
  static const Color surfaceLow = Color(0xFFF1F4F6);

  // Contenedor de superficie — #EAEff1
  static const Color surfaceContainer = Color(0xFFEAEFF1);

  // Texto principal — #2B3437
  static const Color onSurface = Color(0xFF2B3437);

  // Texto secundario — #586064
  static const Color onSurfaceVariant = Color(0xFF586064);

  // Borde sutil — #ABB3B7
  static const Color outlineVariant = Color(0xFFABB3B7);

  // Error / rojo — #9E3F4E (grabando)
  static const Color error = Color(0xFF9E3F4E);

  // Éxito / verde — #1D8859
  static const Color success = Color(0xFF1D8859);

  // Primary container (nav activo) — #DDE1FF
  static const Color primaryContainer = Color(0xFFDDE1FF);

  // Blanco puro
  static const Color white = Colors.white;
}
