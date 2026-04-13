import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../shared/widgets/primary_button.dart';

/// Pantalla 5 — Permisos del dispositivo
/// Equivalente a OnboardingPermissionsScreen en Kivy
class OnboardingPermissionsScreen extends StatefulWidget {
  const OnboardingPermissionsScreen({super.key});

  @override
  State<OnboardingPermissionsScreen> createState() =>
      _OnboardingPermissionsScreenState();
}

class _OnboardingPermissionsScreenState
    extends State<OnboardingPermissionsScreen> {
  String _status = '';
  bool _granted = false;

  void _solicitarPermisos() {
    // Fase 1: simulado — Fase 2 usará permission_handler
    setState(() {
      _status = 'Permisos concedidos. Todo listo.';
      _granted = true;
    });
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

              const Text('PASO 5 DE 5', style: AppTextStyles.sectionLabel),
              const SizedBox(height: 12),

              const Text(
                'Permisos\nnecesarios',
                style: AppTextStyles.onboardingTitle,
              ),

              const SizedBox(height: 24),

              _PermisoItem(
                icon: Icons.mic_rounded,
                titulo: 'Micrófono',
                descripcion: 'Para grabar audio',
              ),
              const SizedBox(height: 12),
              _PermisoItem(
                icon: Icons.wifi_rounded,
                titulo: 'Internet',
                descripcion: 'Para enviar a Gemini y subir a Drive',
              ),
              const SizedBox(height: 12),
              _PermisoItem(
                icon: Icons.storage_rounded,
                titulo: 'Almacenamiento',
                descripcion: 'Para guardar el audio temporalmente',
              ),

              if (_status.isNotEmpty) ...[
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_rounded,
                          color: AppColors.success, size: 20),
                      const SizedBox(width: 10),
                      Text(_status, style: AppTextStyles.caption),
                    ],
                  ),
                ),
              ],

              const Spacer(),

              if (!_granted)
                PrimaryButton(
                  text: 'Conceder permisos',
                  onPressed: _solicitarPermisos,
                )
              else
                PrimaryButton(
                  text: 'Continuar',
                  onPressed: () =>
                      Navigator.pushNamed(context, '/onboarding_done'),
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

class _PermisoItem extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final String descripcion;

  const _PermisoItem({
    required this.icon,
    required this.titulo,
    required this.descripcion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titulo, style: AppTextStyles.itemTitle),
              Text(descripcion, style: AppTextStyles.itemMeta),
            ],
          ),
        ],
      ),
    );
  }
}
