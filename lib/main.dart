import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/storage/local_storage.dart';
import 'core/theme/app_theme.dart';

// Onboarding
import 'features/onboarding/onboarding_welcome_screen.dart';
import 'features/onboarding/onboarding_apikey_screen.dart';
import 'features/onboarding/onboarding_oauth_screen.dart';
import 'features/onboarding/onboarding_drive_screen.dart';
import 'features/onboarding/onboarding_permissions_screen.dart';
import 'features/onboarding/onboarding_done_screen.dart';

// Pantallas principales
import 'features/home/home_screen.dart';
import 'features/recording/recording_screen.dart';
import 'features/result/result_screen.dart';
import 'features/settings/settings_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Equivalente al store.exists("config") de main.py en Kivy:
  // Si el onboarding ya se completó, va directo a Home
  final onboardingDone = await LocalStorage.isOnboardingDone();

  runApp(
    ProviderScope(
      child: AudionotesApp(initialRoute: onboardingDone ? '/home' : '/'),
    ),
  );
}

class AudionotesApp extends StatelessWidget {
  final String initialRoute;

  const AudionotesApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audionotes',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: initialRoute,
      routes: {
        '/': (_) => const OnboardingWelcomeScreen(),
        '/onboarding_apikey': (_) => const OnboardingApiKeyScreen(),
        '/onboarding_oauth': (_) => const OnboardingOAuthScreen(),
        '/onboarding_drive': (_) => const OnboardingDriveScreen(),
        '/onboarding_permissions': (_) => const OnboardingPermissionsScreen(),
        '/onboarding_done': (_) => const OnboardingDoneScreen(),
        '/home': (_) => const HomeScreen(),
        '/recording': (_) => const RecordingScreen(),
        '/result': (_) => const ResultScreen(),
        '/settings': (_) => const SettingsScreen(),
      },
    );
  }
}
