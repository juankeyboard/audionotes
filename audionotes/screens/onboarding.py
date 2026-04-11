# screens/onboarding.py — Pantallas de configuración inicial
#
# El onboarding solo se muestra la primera vez que el usuario abre la app.
# Son 6 pantallas encadenadas que guían al usuario para:
#   1. Darle la bienvenida
#   2. Ingresar su API key de Google AI Studio
#   3. Conectar su cuenta de Google (OAuth — solo placeholder en Fase 1)
#   4. Ingresar el ID de su carpeta de Google Drive
#   5. Ver la solicitud de permisos del dispositivo
#   6. Confirmar que todo está listo

from kivy.uix.screenmanager import Screen
from kivy.storage.jsonstore import JsonStore
from kivy.app import App


# Almacenamiento local donde guardamos la config del usuario
# JsonStore guarda un archivo JSON en el dispositivo, nunca sale de él
store = JsonStore("audionotes_config.json")


class OnboardingWelcomeScreen(Screen):
    """
    Pantalla 1: Bienvenida.
    Solo muestra el nombre de la app y un botón para continuar.
    """
    def ir_a_apikey(self):
        self.manager.transition.direction = "left"
        self.manager.current = "onboarding_apikey"


class OnboardingApiKeyScreen(Screen):
    """
    Pantalla 2: Ingreso de API key de Google AI Studio.
    En Fase 1 solo guarda el texto — no hace ninguna llamada real a Gemini.
    En Fase 2 se agregará una llamada de prueba para validar la key.
    """
    def verificar_y_continuar(self):
        # Leemos el texto del campo desde el KV por su id
        api_key = self.ids.input_apikey.text.strip()

        if not api_key:
            # Mostramos error si el campo está vacío
            self.ids.lbl_error.text = "Por favor ingresa tu API key."
            return

        # Guardamos la key en el almacenamiento local del dispositivo
        # IMPORTANTE: esta key NUNCA se envía a servidores de Audionotes
        store.put("config", api_key=api_key, onboarding_done=False)
        self.ids.lbl_error.text = ""

        self.manager.transition.direction = "left"
        self.manager.current = "onboarding_oauth"

    def ir_atras(self):
        self.manager.transition.direction = "right"
        self.manager.current = "onboarding_welcome"


class OnboardingOAuthScreen(Screen):
    """
    Pantalla 3: Conexión con Google (OAuth 2.0).
    En Fase 1 es un placeholder visual — el botón simula que se abrió el navegador
    y el campo acepta cualquier texto como "código de autorización".
    En Fase 2 esto hará el flujo real de OAuth 2.0.
    """
    def simular_abrir_navegador(self):
        # Fase 1: solo cambia el label para simular que se abrió el navegador
        self.ids.lbl_oauth_status.text = "Navegador abierto. Autoriza el acceso y copia el código."

    def confirmar_codigo(self):
        codigo = self.ids.input_codigo_oauth.text.strip()

        if not codigo:
            self.ids.lbl_error_oauth.text = "Por favor pega el código de autorización."
            return

        # Fase 1: guardamos el código como placeholder (no lo intercambiamos por tokens reales)
        existing = store.get("config") if store.exists("config") else {}
        store.put("config", **{**existing, "oauth_code": codigo})
        self.ids.lbl_error_oauth.text = ""

        self.manager.transition.direction = "left"
        self.manager.current = "onboarding_drive"

    def ir_atras(self):
        self.manager.transition.direction = "right"
        self.manager.current = "onboarding_apikey"


class OnboardingDriveScreen(Screen):
    """
    Pantalla 4: Ingreso del ID de la carpeta de Google Drive.
    El usuario copia el ID desde la URL de Drive (la parte final de la URL).
    Ej: drive.google.com/drive/folders/1aBcDeFgHiJkLmNoPqRsTuVwXyZ
                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ este es el ID
    """
    def verificar_y_continuar(self):
        folder_id = self.ids.input_folder_id.text.strip()

        if not folder_id:
            self.ids.lbl_error_drive.text = "Por favor ingresa el ID de la carpeta."
            return

        # Guardamos el ID de la carpeta junto con la config existente
        existing = store.get("config") if store.exists("config") else {}
        store.put("config", **{**existing, "drive_folder_id": folder_id})
        self.ids.lbl_error_drive.text = ""

        self.manager.transition.direction = "left"
        self.manager.current = "onboarding_permissions"

    def ir_atras(self):
        self.manager.transition.direction = "right"
        self.manager.current = "onboarding_oauth"


class OnboardingPermissionsScreen(Screen):
    """
    Pantalla 5: Solicitud de permisos del dispositivo.
    En Fase 1 es solo visual — muestra los permisos que se pedirán.
    En Fase 2 se usará pyjnius para solicitar los permisos reales en Android.
    Permisos necesarios:
      - RECORD_AUDIO: para grabar con el micrófono
      - WRITE_EXTERNAL_STORAGE: para guardar el audio temporalmente
      - INTERNET: para enviar a Gemini y subir a Drive
    """
    def solicitar_permisos(self):
        # Fase 1: simulamos que los permisos fueron concedidos
        self.ids.lbl_permisos_status.text = "Permisos concedidos. Todo listo."
        self.ids.btn_permisos.text = "Permisos concedidos"

    def continuar(self):
        self.manager.transition.direction = "left"
        self.manager.current = "onboarding_done"

    def ir_atras(self):
        self.manager.transition.direction = "right"
        self.manager.current = "onboarding_drive"


class OnboardingDoneScreen(Screen):
    """
    Pantalla 6: Confirmación final del onboarding.
    Marca el onboarding como completado en el almacenamiento local
    y envía al usuario a la pantalla principal.
    """
    def ir_a_la_app(self):
        # Marcamos onboarding como completado — la próxima vez que abra la app
        # irá directo a Home sin pasar por el onboarding
        existing = store.get("config") if store.exists("config") else {}
        store.put("config", **{**existing, "onboarding_done": True})

        self.manager.transition.direction = "left"
        self.manager.current = "home"
