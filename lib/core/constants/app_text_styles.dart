import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Estilos de texto centralizados — equivalente al sistema de font_size en .kv
class AppTextStyles {
  AppTextStyles._();

  // Título editorial grande (home hero)
  static const TextStyle heroTitle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppColors.onSurface,
  );

  // Nombre de la app en AppBar
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.onSurface,
  );

  // Título de onboarding
  static const TextStyle onboardingTitle = TextStyle(
    fontSize: 42,
    fontWeight: FontWeight.bold,
    color: AppColors.onSurface,
  );

  // Subtítulo de onboarding
  static const TextStyle onboardingSubtitle = TextStyle(
    fontSize: 16,
    color: AppColors.primary,
  );

  // Descripción de onboarding
  static const TextStyle onboardingBody = TextStyle(
    fontSize: 15,
    color: AppColors.onSurfaceVariant,
    height: 1.5,
  );

  // Etiqueta de sección (uppercase pequeño)
  static const TextStyle sectionLabel = TextStyle(
    fontSize: 11,
    color: AppColors.onSurfaceVariant,
    letterSpacing: 0.5,
  );

  // Título de item en lista
  static const TextStyle itemTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.onSurface,
  );

  // Metadata de item (fecha, hora, duración)
  static const TextStyle itemMeta = TextStyle(
    fontSize: 12,
    color: AppColors.onSurfaceVariant,
  );

  // Temporizador de grabación
  static const TextStyle timer = TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.bold,
    color: AppColors.onSurface,
  );

  // Texto de botón primario
  static const TextStyle buttonPrimary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  // Texto de botón secundario
  static const TextStyle buttonSecondary = TextStyle(
    fontSize: 15,
    color: AppColors.primary,
  );

  // Cuerpo general
  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.onSurface,
  );

  // Caption / helper text
  static const TextStyle caption = TextStyle(
    fontSize: 13,
    color: AppColors.onSurfaceVariant,
  );

  // Mensaje de resultado (éxito)
  static const TextStyle resultTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.onSurface,
  );

  // Encabezado de mes en lista
  static const TextStyle monthHeader = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
}
