import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/storage/local_storage.dart';
import '../../shared/widgets/primary_button.dart';

/// Pantalla 4 — ID de carpeta de Google Drive
/// Equivalente a OnboardingDriveScreen en Kivy
class OnboardingDriveScreen extends StatefulWidget {
  const OnboardingDriveScreen({super.key});

  @override
  State<OnboardingDriveScreen> createState() => _OnboardingDriveScreenState();
}

class _OnboardingDriveScreenState extends State<OnboardingDriveScreen> {
  final _controller = TextEditingController();
  String _error = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _verificarYContinuar() async {
    final id = _controller.text.trim();
    if (id.isEmpty) {
      setState(() => _error = 'Por favor ingresa el ID de la carpeta.');
      return;
    }
    await LocalStorage.setFolderId(id);
    setState(() => _error = '');
    if (mounted) Navigator.pushNamed(context, '/onboarding_permissions');
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

              const Text('PASO 4 DE 5', style: AppTextStyles.sectionLabel),
              const SizedBox(height: 12),

              const Text(
                'Carpeta de\nGoogle Drive',
                style: AppTextStyles.onboardingTitle,
              ),

              const SizedBox(height: 16),

              const Text(
                'Copia el ID de la carpeta desde la URL de Drive:\ndrive.google.com/drive/folders/[ESTE ES EL ID]',
                style: AppTextStyles.onboardingBody,
              ),

              const SizedBox(height: 32),

              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'ID de la carpeta en Drive',
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
