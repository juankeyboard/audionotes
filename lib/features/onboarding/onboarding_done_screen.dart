import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/storage/local_storage.dart';
import '../../shared/widgets/primary_button.dart';

/// Pantalla 6 — Confirmación final del onboarding
/// Equivalente a OnboardingDoneScreen en Kivy
class OnboardingDoneScreen extends StatelessWidget {
  const OnboardingDoneScreen({super.key});

  Future<void> _irALaApp(BuildContext context) async {
    await LocalStorage.setOnboardingDone();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const SizedBox(height: 80),

              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(44),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 48,
                  color: AppColors.success,
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                '¡Todo listo!',
                style: AppTextStyles.onboardingTitle,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              const Text(
                'Audionotes está configurado.\nYa puedes grabar, transcribir y guardar\ntodo en tu Google Drive.',
                style: AppTextStyles.onboardingBody,
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              PrimaryButton(
                text: 'Ir a Audionotes',
                onPressed: () => _irALaApp(context),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
