import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

/// Datos simulados — equivalente a GRABACIONES_SIMULADAS en home.py
const _grabacionesSimuladas = [
  {
    'titulo': 'Reunión de equipo — Sprint review',
    'fecha': '2026-04-10',
    'hora': '14:32',
    'duracion': '00:05:42',
    'mes': 'Abril 2026',
  },
  {
    'titulo': 'Nota personal — ideas proyecto',
    'fecha': '2026-04-09',
    'hora': '09:15',
    'duracion': '00:02:18',
    'mes': 'Abril 2026',
  },
  {
    'titulo': 'Llamada con cliente',
    'fecha': '2026-04-08',
    'hora': '11:00',
    'duracion': '00:18:05',
    'mes': 'Abril 2026',
  },
  {
    'titulo': 'Lista de compras del fin de semana',
    'fecha': '2026-03-28',
    'hora': '08:45',
    'duracion': '00:01:10',
    'mes': 'Marzo 2026',
  },
  {
    'titulo': 'Resumen de lectura — capítulo 7',
    'fecha': '2026-03-15',
    'hora': '21:30',
    'duracion': '00:04:55',
    'mes': 'Marzo 2026',
  },
];

/// Pantalla principal — equivalente a HomeScreen en Kivy
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Agrupar por mes
    final List<Widget> items = [];
    String? mesActual;

    for (final g in _grabacionesSimuladas) {
      if (g['mes'] != mesActual) {
        mesActual = g['mes'];
        items.add(_MesHeader(mes: mesActual!));
      }
      items.add(_GrabacionItem(
        titulo: g['titulo']!,
        fecha: g['fecha']!,
        hora: g['hora']!,
        duracion: g['duracion']!,
      ));
    }

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Column(
        children: [
          // TopAppBar
          _TopBar(
            onSettings: () => Navigator.pushNamed(context, '/settings'),
          ),

          // Hero
          const _HeroSection(),

          // Lista scrollable
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              itemCount: items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (_, i) => items[i],
            ),
          ),

          // FAB ancho completo
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/recording'),
                icon: const Icon(Icons.add_rounded),
                label: const Text('Nueva grabación'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // Bottom nav
          const _BottomNav(activeIndex: 0),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final VoidCallback onSettings;

  const _TopBar({required this.onSettings});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: AppColors.surfaceLow,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Expanded(
            child: Text('Audionotes', style: AppTextStyles.appBarTitle),
          ),
          IconButton(
            onPressed: onSettings,
            icon: const Icon(Icons.more_horiz_rounded),
            color: AppColors.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('TUS GRABACIONES', style: AppTextStyles.sectionLabel),
          SizedBox(height: 4),
          Text('Tu voz, capturada.', style: AppTextStyles.heroTitle),
        ],
      ),
    );
  }
}

class _MesHeader extends StatelessWidget {
  final String mes;

  const _MesHeader({required this.mes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(mes, style: AppTextStyles.monthHeader),
    );
  }
}

class _GrabacionItem extends StatelessWidget {
  final String titulo;
  final String fecha;
  final String hora;
  final String duracion;

  const _GrabacionItem({
    required this.titulo,
    required this.fecha,
    required this.hora,
    required this.duracion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.mic_none_rounded,
              size: 22, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(titulo,
                    style: AppTextStyles.itemTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 3),
                Text('$fecha  $hora   $duracion',
                    style: AppTextStyles.itemMeta),
              ],
            ),
          ),
          const Icon(Icons.sync_rounded, size: 16, color: AppColors.primary),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right_rounded,
              size: 16, color: AppColors.outlineVariant),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int activeIndex;

  const _BottomNav({required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(color: AppColors.outlineVariant.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: [
          _NavItem(icon: Icons.home_rounded, label: 'Inicio', active: activeIndex == 0),
          _NavItem(icon: Icons.fiber_manual_record_rounded, label: 'Grabar', active: activeIndex == 1),
          _NavItem(icon: Icons.list_rounded, label: 'Historial', active: activeIndex == 2),
          _NavItem(icon: Icons.search_rounded, label: 'Buscar', active: activeIndex == 3),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: active
            ? BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: active ? AppColors.primary : AppColors.outlineVariant,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
                color: active ? AppColors.primary : AppColors.outlineVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
