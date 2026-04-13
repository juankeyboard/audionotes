import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/storage/local_storage.dart';
import '../../shared/widgets/primary_button.dart';

const _appVersion = '0.2.0-flutter';

/// Pantalla de ajustes — equivalente a SettingsScreen en Kivy
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _apikeyController = TextEditingController();
  final _folderController = TextEditingController();
  String _mensaje = '';

  @override
  void initState() {
    super.initState();
    _cargarConfig();
  }

  @override
  void dispose() {
    _apikeyController.dispose();
    _folderController.dispose();
    super.dispose();
  }

  Future<void> _cargarConfig() async {
    final apiKey = await LocalStorage.getApiKey();
    final folderId = await LocalStorage.getFolderId();
    setState(() {
      _apikeyController.text = apiKey;
      _folderController.text = folderId;
    });
  }

  Future<void> _guardarCambios() async {
    final apiKey = _apikeyController.text.trim();
    final folderId = _folderController.text.trim();

    if (apiKey.isEmpty || folderId.isEmpty) {
      setState(
          () => _mensaje = 'Completa todos los campos antes de guardar.');
      return;
    }

    await LocalStorage.setApiKey(apiKey);
    await LocalStorage.setFolderId(folderId);
    setState(() => _mensaje = 'Cambios guardados correctamente.');
  }

  Future<void> _desconectarGoogle() async {
    await LocalStorage.clearOauthTokens();
    setState(() => _mensaje = 'Cuenta de Google desconectada.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Column(
        children: [
          // TopAppBar
          Container(
            height: 64,
            color: AppColors.surfaceLow,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.chevron_left_rounded,
                      color: AppColors.primary),
                  label: const Text('Volver',
                      style: TextStyle(color: AppColors.primary)),
                ),
                const Expanded(
                  child: Text('Ajustes', style: AppTextStyles.appBarTitle),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sección: Configuración
                  const Text('CONFIGURACIÓN',
                      style: AppTextStyles.sectionLabel),
                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('API Key de Google AI Studio',
                            style: AppTextStyles.caption),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _apikeyController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: 'Tu API key'),
                        ),
                        const SizedBox(height: 16),
                        const Text('ID de carpeta de Google Drive',
                            style: AppTextStyles.caption),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _folderController,
                          decoration: const InputDecoration(
                              hintText: 'ID de la carpeta en Drive'),
                        ),
                      ],
                    ),
                  ),

                  if (_mensaje.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(_mensaje,
                        style: const TextStyle(
                            fontSize: 13, color: AppColors.success)),
                  ],

                  const SizedBox(height: 16),

                  PrimaryButton(
                      text: 'Guardar cambios',
                      onPressed: _guardarCambios),

                  const SizedBox(height: 28),

                  // Sección: Cuenta
                  const Text('CUENTA DE GOOGLE',
                      style: AppTextStyles.sectionLabel),
                  const SizedBox(height: 8),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _desconectarGoogle,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFE8EB),
                        foregroundColor: AppColors.error,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text('Desconectar cuenta de Google',
                          style: TextStyle(fontSize: 14)),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Sección: Acerca de
                  const Text('ACERCA DE', style: AppTextStyles.sectionLabel),
                  const SizedBox(height: 8),

                  Text('Versión $_appVersion — Licencia MIT',
                      style: AppTextStyles.caption),
                  const SizedBox(height: 4),
                  const Text(
                    'github.com/juankeyboard/audionotes',
                    style: TextStyle(
                        fontSize: 13, color: AppColors.primary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
