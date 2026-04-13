import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../shared/widgets/primary_button.dart';

/// Pantalla de resultado — equivalente a ResultScreen en Kivy
class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late String _nombreArchivo;
  late String _duracion;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    _duracion = args?['duracion'] ?? '00:00';

    final ahora = DateTime.now();
    final fmt = DateFormat('yyyy-MM-dd_HH-mm-ss');
    _nombreArchivo = '${fmt.format(ahora)}_nota-de-voz.md';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
          child: Column(
            children: [
              const SizedBox(height: 96),

              // Ícono de éxito
              const Text(
                '✓',
                style: TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                  color: AppColors.success,
                ),
              ),

              const SizedBox(height: 16),

              // Mensaje principal
              const Text(
                'Transcripción lista\ny guardada en Drive.',
                style: AppTextStyles.resultTitle,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              // Card con detalles
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.outlineVariant.withValues(alpha: 0.35),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Archivo generado',
                        style: AppTextStyles.caption),
                    const SizedBox(height: 6),
                    Text(
                      _nombreArchivo,
                      style: AppTextStyles.itemTitle,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Duración: $_duracion',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              PrimaryButton(
                text: 'Nueva grabación',
                onPressed: () => Navigator.pushReplacementNamed(
                    context, '/recording'),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (_) => false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryContainer,
                    foregroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text('Volver al inicio',
                      style: TextStyle(fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
