# screens/result.py — Pantalla de Resultado
#
# Se muestra después de que una grabación termina de procesarse.
# Confirma al usuario que el audio y la transcripción fueron guardados en Drive.
#
# En Fase 1: todo es simulado (nombre de archivo generado, estado de éxito).
# En Fase 2: mostrará el resultado real del procesamiento de Gemini y Drive.

from kivy.uix.screenmanager import Screen
from kivy.clock import Clock
import datetime


class ResultScreen(Screen):
    """
    Pantalla de confirmación post-grabación.
    Muestra el nombre del archivo generado y el estado de la subida a Drive.
    """

    # Duración de la grabación (recibida desde RecordingScreen)
    duracion_grabacion = "00:00"

    def on_enter(self):
        """
        Al entrar, generamos un nombre de archivo simulado y mostramos
        la confirmación de éxito.
        """
        # Generamos un nombre de archivo con timestamp actual (como lo haría Gemini en Fase 2)
        ahora = datetime.datetime.now()
        nombre_simulado = ahora.strftime("%Y-%m-%d_%H-%M-%S") + "_nota-de-voz"

        # Actualizamos los labels en la pantalla
        self.ids.lbl_nombre_archivo.text = f"{nombre_simulado}.md"
        self.ids.lbl_duracion.text = f"Duración: {self.duracion_grabacion}"
        self.ids.lbl_estado.text = "Transcripción lista y guardada en Drive."

    def volver_al_inicio(self):
        """Vuelve a la pantalla principal."""
        self.manager.transition.direction = "right"
        self.manager.current = "home"

    def nueva_grabacion(self):
        """Inicia una nueva grabación directamente desde el resultado."""
        self.manager.transition.direction = "left"
        self.manager.current = "recording"
