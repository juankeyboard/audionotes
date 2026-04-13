import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/storage/local_storage.dart';
import '../../shared/widgets/primary_button.dart';

/// Pantalla 3 — Conexión con Google (OAuth 2.0)
/// Equivalente a OnboardingOAuthScreen en Kivy
class OnboardingOAuthScreen extends StatefulWidget {
  const OnboardingOAuthScreen({super.key});

  @override
  State<OnboardingOAuthScreen> createState() => _OnboardingOAuthScreenState();
}

class _OnboardingOAuthScreenState extends State<OnboardingOAuthScreen> {
  final _controller = TextEditingController();
  String _status = '';
  String _error = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _simularAbrirNavegador() {
    setState(() {
      _status = 'Navegador abierto. Autoriza el acceso y copia el código.';
    });
  }

  Future<void> _confirmarCodigo() async {
    final codigo = _controller.text.trim();
    if (codigo.isEmpty) {
      setState(() => _error = 'Por favor pega el código de autorización.');
      return;
    }
    await LocalStorage.setOauthCode(codigo);
    setState(() => _error = '');
    if (mounted) Navigator.pushNamed(context, '/onboarding_drive');
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

              const Text('PASO 3 DE 5', style: AppTextStyles.sectionLabel),
              const SizedBox(height: 12),

              const Text(
                'Conecta tu\ncuenta de Google',
                style: AppTextStyles.onboardingTitle,
              ),

              const SizedBox(height: 16),

              const Text(
                'Necesitamos acceso a Google Drive para guardar\ntus transcripciones automáticamente.',
                style: AppTextStyles.onboardingBody,
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: _simularAbrirNavegador,
                  icon: const Icon(Icons.open_in_browser_rounded),
                  label: const Text('Conectar con Google'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              if (_status.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(_status, style: AppTextStyles.caption),
              ],

              const SizedBox(height: 20),

              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Pega el código de autorización aquí',
                ),
              ),

              if (_error.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  _error,
                  style: const TextStyle(fontSize: 13, color: AppColors.error),
                ),
              ],

              const Spacer(),

              PrimaryButton(
                text: 'Continuar',
                onPressed: _confirmarCodigo,
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
