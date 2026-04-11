# screens/settings.py — Pantalla de Ajustes
#
# Permite al usuario modificar su configuración después del onboarding:
#   - Cambiar la API key de Google AI Studio
#   - Cambiar el ID de carpeta de Google Drive
#   - Desconectar la cuenta de Google
#   - Ver info de la app

from kivy.uix.screenmanager import Screen
from kivy.storage.jsonstore import JsonStore

# Mismo almacenamiento que usa el onboarding
store = JsonStore("audionotes_config.json")

# Versión de la app (actualizar en cada release)
APP_VERSION = "0.1.0-fase1"


class SettingsScreen(Screen):
    """
    Pantalla de configuración editable en cualquier momento.
    Los campos se pre-rellenan con los valores actuales guardados en JsonStore.
    """

    def on_enter(self):
        """Cargamos los valores guardados cada vez que el usuario entra a Ajustes."""
        if store.exists("config"):
            config = store.get("config")
            # Pre-rellenamos los campos con los valores actuales
            self.ids.input_apikey.text = config.get("api_key", "")
            self.ids.input_folder_id.text = config.get("drive_folder_id", "")

        # Mostramos la versión de la app
        self.ids.lbl_version.text = f"Versión {APP_VERSION} — Licencia MIT"

    def guardar_cambios(self):
        """
        Guarda los nuevos valores ingresados por el usuario.
        No valida contra la API en Fase 1 — eso se agrega en Fase 2.
        """
        nueva_apikey = self.ids.input_apikey.text.strip()
        nuevo_folder_id = self.ids.input_folder_id.text.strip()

        if not nueva_apikey or not nuevo_folder_id:
            self.ids.lbl_mensaje.text = "Completa todos los campos antes de guardar."
            return

        # Obtenemos la config existente para no borrar otros campos (ej: oauth_code)
        existing = store.get("config") if store.exists("config") else {}
        store.put("config", **{
            **existing,
            "api_key": nueva_apikey,
            "drive_folder_id": nuevo_folder_id,
        })

        self.ids.lbl_mensaje.text = "Cambios guardados correctamente."

    def desconectar_google(self):
        """
        Revoca los tokens de acceso a Drive guardados localmente.
        En Fase 2 también llamará al endpoint de revocación de Google.
        """
        if store.exists("config"):
            existing = store.get("config")
            # Borramos solo los tokens OAuth, mantenemos API key y folder ID
            existing.pop("oauth_code", None)
            existing.pop("access_token", None)
            existing.pop("refresh_token", None)
            store.put("config", **existing)

        self.ids.lbl_mensaje.text = "Cuenta de Google desconectada."

    def volver(self):
        """Regresa a la pantalla principal."""
        self.manager.transition.direction = "right"
        self.manager.current = "home"
