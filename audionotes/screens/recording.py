# screens/recording.py — Pantalla de Grabación
#
# Muestra la interfaz de grabación con:
#   - Waveform animado (simulado en Fase 1)
#   - Temporizador que corre en tiempo real
#   - Botón para detener y procesar
#
# En Fase 1: todo es visual, sin audio real.
# En Fase 2: se conectará plyer.audio para grabar de verdad.

from kivy.uix.screenmanager import Screen
from kivy.clock import Clock
from kivy.uix.widget import Widget
from kivy.graphics import Color, Rectangle, RoundedRectangle
import random
import math


class RecordingScreen(Screen):
    """
    Pantalla de grabación activa.
    El temporizador y el waveform se actualizan cada segundo/frame.
    """

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        # Contador de segundos grabados
        self._segundos = 0
        # Referencia al evento del Clock para poder cancelarlo
        self._clock_event = None

    def on_enter(self):
        """Al entrar a la pantalla, iniciamos la grabación simulada."""
        self._segundos = 0
        self.actualizar_display()
        # Clock.schedule_interval llama a una función cada N segundos
        # Aquí llamamos a _tick cada 1 segundo para el temporizador
        self._clock_event = Clock.schedule_interval(self._tick, 1)

    def on_leave(self):
        """Al salir, cancelamos el temporizador para no seguir corriendo en segundo plano."""
        if self._clock_event:
            self._clock_event.cancel()
            self._clock_event = None

    def _tick(self, dt):
        """
        Llamado cada 1 segundo por el Clock.
        dt = delta time (tiempo transcurrido desde la última llamada, aprox. 1.0)
        """
        self._segundos += 1
        self.actualizar_display()

    def actualizar_display(self):
        """Convierte los segundos a formato MM:SS y actualiza el label."""
        minutos = self._segundos // 60
        segundos = self._segundos % 60
        self.ids.lbl_timer.text = f"{minutos:02d}:{segundos:02d}"

    def detener_y_procesar(self):
        """
        Detiene la grabación y navega a la pantalla de resultado.
        En Fase 1: simulado.
        En Fase 2: llamará a plyer.audio.stop() y luego enviará a Gemini.
        """
        if self._clock_event:
            self._clock_event.cancel()
            self._clock_event = None

        # Guardamos la duración para mostrarla en la pantalla de resultado
        minutos = self._segundos // 60
        segundos = self._segundos % 60
        duracion = f"{minutos:02d}:{segundos:02d}"

        # Pasamos la duración a la pantalla de resultado
        result_screen = self.manager.get_screen("result")
        result_screen.duracion_grabacion = duracion

        self.manager.transition.direction = "left"
        self.manager.current = "result"

    def cancelar(self):
        """Cancela la grabación y vuelve a Home."""
        if self._clock_event:
            self._clock_event.cancel()
            self._clock_event = None
        self.manager.transition.direction = "right"
        self.manager.current = "home"


class WaveformWidget(Widget):
    """
    Widget que dibuja un waveform animado simulado.
    Usa el Canvas de Kivy para dibujar barras de distintas alturas.
    En Fase 2 las alturas reflejarán el nivel de audio real del micrófono.
    """

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        # Número de barras del waveform
        self._num_barras = 30
        # Evento de animación (actualiza cada 0.1 segundos para suavidad)
        self._anim_event = Clock.schedule_interval(self._animar, 0.1)

    def _animar(self, dt):
        """Redibuja el waveform con nuevas alturas aleatorias en cada frame."""
        self.canvas.clear()
        if self.width == 0:
            return

        ancho_barra = self.width / (self._num_barras * 2)
        espacio = ancho_barra

        with self.canvas:
            for i in range(self._num_barras):
                # Altura simulada: onda senoidal + variación aleatoria
                # En Fase 2 esto se reemplaza por el nivel real del micrófono
                altura_base = math.sin(i * 0.4 + Clock.get_time() * 3) * 0.3 + 0.5
                altura = (altura_base + random.uniform(-0.15, 0.15)) * self.height * 0.8
                altura = max(4, min(altura, self.height * 0.9))

                x = i * (ancho_barra + espacio) + espacio
                y = (self.height - altura) / 2

                # Color degradado de morado a azul según posición
                r = 0.4 + (i / self._num_barras) * 0.2
                g = 0.2
                b = 0.8 + (i / self._num_barras) * 0.2
                Color(r, g, b, 0.9)
                RoundedRectangle(pos=(x, y), size=(ancho_barra, altura), radius=[2])

    def on_parent(self, widget, parent):
        """Cuando el widget se quita de la pantalla, cancelamos la animación."""
        if parent is None and self._anim_event:
            self._anim_event.cancel()
