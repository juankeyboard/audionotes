# screens/home.py — Pantalla Principal (Home)
#
# Muestra la lista de grabaciones del usuario, agrupadas por mes.
# En Fase 1 los datos son simulados (hardcodeados).
# En Fase 2 esta lista se leerá desde Google Drive.

from kivy.uix.screenmanager import Screen
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.label import Label
from kivy.uix.button import Button
from kivy.properties import StringProperty, ListProperty
from kivy.lang import Builder


# Datos de prueba para la Fase 1
# Cada item tiene: título, fecha, hora, duración e ícono de estado
GRABACIONES_SIMULADAS = [
    {
        "titulo": "Reunión de equipo — Sprint review",
        "fecha": "2026-04-10",
        "hora": "14:32",
        "duracion": "00:05:42",
        "estado": "sincronizado",
        "mes": "Abril 2026",
    },
    {
        "titulo": "Nota personal — ideas proyecto",
        "fecha": "2026-04-09",
        "hora": "09:15",
        "duracion": "00:02:18",
        "estado": "sincronizado",
        "mes": "Abril 2026",
    },
    {
        "titulo": "Llamada con cliente",
        "fecha": "2026-04-08",
        "hora": "11:00",
        "duracion": "00:18:05",
        "estado": "sincronizado",
        "mes": "Abril 2026",
    },
    {
        "titulo": "Lista de compras del fin de semana",
        "fecha": "2026-03-28",
        "hora": "08:45",
        "duracion": "00:01:10",
        "estado": "sincronizado",
        "mes": "Marzo 2026",
    },
    {
        "titulo": "Resumen de lectura — capítulo 7",
        "fecha": "2026-03-15",
        "hora": "21:30",
        "duracion": "00:04:55",
        "estado": "sincronizado",
        "mes": "Marzo 2026",
    },
]


class HomeScreen(Screen):
    """
    Pantalla principal de la app.
    Muestra la lista de grabaciones y el botón de nueva grabación (FAB).
    """

    def on_enter(self):
        """
        on_enter se llama cada vez que el usuario llega a esta pantalla.
        Aquí cargamos (o recargamos) la lista de grabaciones.
        """
        self.cargar_grabaciones()

    def cargar_grabaciones(self):
        """
        Construye la lista visual de grabaciones.
        En Fase 1: usa datos simulados.
        En Fase 2: leerá los archivos .md desde Google Drive.
        """
        # Referencia al contenedor de la lista definido en home.kv
        lista = self.ids.lista_grabaciones
        lista.clear_widgets()

        mes_actual = None

        for item in GRABACIONES_SIMULADAS:
            # Insertamos un encabezado de mes cuando cambia el mes
            if item["mes"] != mes_actual:
                mes_actual = item["mes"]
                encabezado = Label(
                    text=mes_actual,
                    size_hint_y=None,
                    height=40,
                    color=(0.6, 0.6, 0.8, 1),
                    bold=True,
                    halign="left",
                    text_size=(None, None),
                )
                lista.add_widget(encabezado)

            # Cada grabación es un widget GrabacionItem definido en home.kv
            grabacion_widget = GrabacionItem(
                titulo=item["titulo"],
                fecha=item["fecha"],
                hora=item["hora"],
                duracion=item["duracion"],
            )
            lista.add_widget(grabacion_widget)

    def nueva_grabacion(self):
        """Navega a la pantalla de grabación."""
        self.manager.transition.direction = "left"
        self.manager.current = "recording"

    def ir_a_ajustes(self):
        """Navega a la pantalla de ajustes."""
        self.manager.transition.direction = "left"
        self.manager.current = "settings"


class GrabacionItem(BoxLayout):
    """
    Widget visual para cada grabación en la lista.
    Las propiedades StringProperty permiten pasarle datos desde Python
    y que el KV los muestre automáticamente.
    """
    titulo = StringProperty("")
    fecha = StringProperty("")
    hora = StringProperty("")
    duracion = StringProperty("")
