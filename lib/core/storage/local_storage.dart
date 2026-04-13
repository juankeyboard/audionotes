import 'package:shared_preferences/shared_preferences.dart';

/// Equivalente a JsonStore("audionotes_config.json") de Kivy
/// Guarda la configuración del usuario localmente en el dispositivo
class LocalStorage {
  static const _keyApiKey = 'api_key';
  static const _keyOauthCode = 'oauth_code';
  static const _keyFolderId = 'drive_folder_id';
  static const _keyOnboardingDone = 'onboarding_done';

  static Future<SharedPreferences> get _prefs =>
      SharedPreferences.getInstance();

  static Future<String> getApiKey() async =>
      (await _prefs).getString(_keyApiKey) ?? '';

  static Future<void> setApiKey(String value) async =>
      (await _prefs).setString(_keyApiKey, value);

  static Future<String> getOauthCode() async =>
      (await _prefs).getString(_keyOauthCode) ?? '';

  static Future<void> setOauthCode(String value) async =>
      (await _prefs).setString(_keyOauthCode, value);

  static Future<String> getFolderId() async =>
      (await _prefs).getString(_keyFolderId) ?? '';

  static Future<void> setFolderId(String value) async =>
      (await _prefs).setString(_keyFolderId, value);

  static Future<bool> isOnboardingDone() async =>
      (await _prefs).getBool(_keyOnboardingDone) ?? false;

  static Future<void> setOnboardingDone() async =>
      (await _prefs).setBool(_keyOnboardingDone, true);

  static Future<void> clearOauthTokens() async {
    final prefs = await _prefs;
    await prefs.remove(_keyOauthCode);
  }
}
