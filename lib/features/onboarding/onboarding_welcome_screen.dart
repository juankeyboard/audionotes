import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../shared/widgets/primary_button.dart';

/// Pantalla 1 del onboarding — Bienvenida
/// Equivalente a OnboardingWelcomeScreen en Kivy
class OnboardingWelcomeScreen extends StatelessWidget {
  const OnboardingWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const SizedBox(height: 64),

              // Ícono hero
              const Icon(
                Icons.mic_none_rounded,
                size: 80,
                color: AppColors.primary,
              ),

              const SizedBox(height: 24),

              // Etiqueta pequeña
              const Text(
                'BIENVENIDO A',
                style: AppTextStyles.sectionLabel,
              ),

              const SizedBox(height: 8),

              // Título editorial
              const Text(
                'Audionotes',
                style: AppTextStyles.onboardingTitle,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              // Subtítulo en primary
              const Text(
                'Tu voz, perfectamente capturada.',
                style: AppTextStyles.onboardingSubtitle,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Descripción
              const Text(
                'Graba audio. Obtén transcripción.\nTodo organizado en tu Google Drive.',
                style: AppTextStyles.onboardingBody,
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              PrimaryButton(
                text: 'Comenzar',
                onPressed: () =>
                    Navigator.pushNamed(context, '/onboarding_apikey'),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
