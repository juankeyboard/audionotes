import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

/// Pantalla de grabación — equivalente a RecordingScreen en Kivy
class RecordingScreen extends StatefulWidget {
  const RecordingScreen({super.key});

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  int _segundos = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _iniciarGrabacion();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _iniciarGrabacion() {
    _segundos = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _segundos++);
    });
  }

  String get _timerText {
    final m = _segundos ~/ 60;
    final s = _segundos % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  void _detenerYProcesar() {
    _timer?.cancel();
    final m = _segundos ~/ 60;
    final s = _segundos % 60;
    final duracion =
        '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';

    Navigator.pushReplacementNamed(
      context,
      '/result',
      arguments: {'duracion': duracion},
    );
  }

  void _cancelar() {
    _timer?.cancel();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Barra superior
              SizedBox(
                height: 64,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: _cancelar,
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: AppColors.error, fontSize: 14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Indicador REC
              Row(
                children: const [
                  Icon(Icons.circle, size: 14, color: AppColors.error),
                  SizedBox(width: 8),
                  Text(
                    'GRABANDO',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.error,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Temporizador
              Center(
                child: Text(_timerText, style: AppTextStyles.timer),
              ),

              const SizedBox(height: 24),

              // Waveform animado
              const SizedBox(
                height: 120,
                child: _WaveformWidget(),
              ),

              const Spacer(),

              // Card de info
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    'La grabación se procesará automáticamente al detener',
                    style: AppTextStyles.caption,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Botón detener
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _detenerYProcesar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Detener y procesar',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Waveform animado — equivalente a WaveformWidget en recording.py
class _WaveformWidget extends StatefulWidget {
  const _WaveformWidget();

  @override
  State<_WaveformWidget> createState() => _WaveformWidgetState();
}

class _WaveformWidgetState extends State<_WaveformWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => CustomPaint(
        painter: _WaveformPainter(time: _controller.lastElapsedDuration?.inMilliseconds.toDouble() ?? 0),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _WaveformPainter extends CustomPainter {
  final double time;
  final Random _rng = Random();

  _WaveformPainter({required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    const numBarras = 30;
    final anchoBarra = size.width / (numBarras * 2);
    final espacio = anchoBarra;

    for (int i = 0; i < numBarras; i++) {
      final alturaBase = sin(i * 0.4 + time * 0.003) * 0.3 + 0.5;
      double altura =
          (alturaBase + _rng.nextDouble() * 0.3 - 0.15) * size.height * 0.8;
      altura = altura.clamp(4.0, size.height * 0.9);

      final x = i * (anchoBarra + espacio) + espacio;
      final y = (size.height - altura) / 2;

      final t = i / numBarras;
      final paint = Paint()
        ..color = Color.fromRGBO(
          (102 + (t * 51)).toInt(),
          51,
          (204 + (t * 51)).toInt(),
          0.9,
        )
        ..style = PaintingStyle.fill;

      final rrect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, anchoBarra, altura),
        const Radius.circular(2),
      );
      canvas.drawRRect(rrect, paint);
    }
  }

  @override
  bool shouldRepaint(_WaveformPainter old) => true;
}
