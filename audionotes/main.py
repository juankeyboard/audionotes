# main.py — Punto de entrada de Audionotes
#
# Este archivo inicializa la app Kivy, registra todas las pantallas
# y decide si mostrar el onboarding o la pantalla principal según
# si el usuario ya completó la configuración inicial.

from kivy.app import App
from kivy.uix.screenmanager import ScreenManager, SlideTransition
from kivy.storage.jsonstore import JsonStore
from kivy.core.window import Window
from kivy.lang import Builder
import os

# Importamos cada pantalla desde su módulo
from screens.onboarding import (
    OnboardingWelcomeScreen,
    OnboardingApiKeyScreen,
    OnboardingOAuthScreen,
    OnboardingDriveScreen,
    OnboardingPermissionsScreen,
    OnboardingDoneScreen,
)
from screens.home import HomeScreen
from screens.recording import RecordingScreen
from screens.result import ResultScreen
from screens.settings import SettingsScreen

# Color de fondo oscuro para toda la ventana (útil en desktop al hacer pruebas)
Window.clearcolor = (0.1, 0.1, 0.18, 1)


class AudionotesApp(App):
    """
    Clase principal de la aplicación.
    Kivy llama a build() al iniciar y espera que retornemos el widget raíz.
    """

    def build(self):
        # Cargamos todos los archivos .kv de la carpeta kv/
        # Cada archivo define el diseño visual de una pantalla
        kv_dir = os.path.join(os.path.dirname(__file__), "kv")
        for kv_file in sorted(os.listdir(kv_dir)):
            if kv_file.endswith(".kv"):
                Builder.load_file(os.path.join(kv_dir, kv_file))

        # ScreenManager maneja la navegación entre pantallas
        # SlideTransition da una animación de deslizamiento al cambiar pantalla
        sm = ScreenManager(transition=SlideTransition())

        # Registramos todas las pantallas con sus nombres
        # El nombre es el identificador que usamos para navegar: sm.current = 'home'
        sm.add_widget(OnboardingWelcomeScreen(name="onboarding_welcome"))
        sm.add_widget(OnboardingApiKeyScreen(name="onboarding_apikey"))
        sm.add_widget(OnboardingOAuthScreen(name="onboarding_oauth"))
        sm.add_widget(OnboardingDriveScreen(name="onboarding_drive"))
        sm.add_widget(OnboardingPermissionsScreen(name="onboarding_permissions"))
        sm.add_widget(OnboardingDoneScreen(name="onboarding_done"))
        sm.add_widget(HomeScreen(name="home"))
        sm.add_widget(RecordingScreen(name="recording"))
        sm.add_widget(ResultScreen(name="result"))
        sm.add_widget(SettingsScreen(name="settings"))

        # Decidimos qué pantalla mostrar al iniciar:
        # Si el usuario ya completó el onboarding → ir directo a Home
        # Si es la primera vez → mostrar Bienvenida del onboarding
        store = JsonStore("audionotes_config.json")
        if store.exists("config") and store.get("config").get("onboarding_done"):
            sm.current = "home"
        else:
            sm.current = "onboarding_welcome"

        return sm


if __name__ == "__main__":
    AudionotesApp().run()
