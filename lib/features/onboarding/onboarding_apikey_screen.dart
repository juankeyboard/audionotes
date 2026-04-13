import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/storage/local_storage.dart';
import '../../shared/widgets/primary_button.dart';

/// Pantalla 2 — Ingreso de API key de Google AI Studio
/// Equivalente a OnboardingApiKeyScreen en Kivy
class OnboardingApiKeyScreen extends StatefulWidget {
  const OnboardingApiKeyScreen({super.key});

  @override
  State<OnboardingApiKeyScreen> createState() => _OnboardingApiKeyScreenState();
}

class _OnboardingApiKeyScreenState extends State<OnboardingApiKeyScreen> {
  final _controller = TextEditingController();
  String _error = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _verificarYContinuar() async {
    final key = _controller.text.trim();
    if (key.isEmpty) {
      setState(() => _error = 'Por favor ingresa tu API key.');
      return;
    }
    await LocalStorage.setApiKey(key);
    setState(() => _error = '');
    if (mounted) Navigator.pushNamed(context, '/onboarding_oauth');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 64),

              const Text('PASO 2 DE 5', style: AppTextStyles.sectionLabel),
              const SizedBox(height: 12),

              const Text(
                'API key de\nGoogle AI Studio',
                style: AppTextStyles.onboardingTitle,
              ),

              const SizedBox(height: 16),

              const Text(
                '1. Ve a aistudio.google.com\n2. Crea o selecciona un proyecto\n3. Genera una API key y pégala aquí',
                style: AppTextStyles.onboardingBody,
              ),

              const SizedBox(height: 32),

              TextField(
                controller: _controller,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Tu API key',
                ),
              ),

              if (_error.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  _error,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.error,
                  ),
                ),
              ],

              const Spacer(),

              PrimaryButton(
                text: 'Continuar',
                onPressed: _verificarYContinuar,
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Volver'),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
