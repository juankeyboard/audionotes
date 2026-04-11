# F2 — Bitácora de Aprendizaje e Interacción — Audionotes

**¿Para qué es este documento?**
Registro histórico de decisiones, hitos técnicos y soluciones implementadas durante el ciclo de vida del proyecto. Sirve como guía pedagógica para el desarrollador y trazabilidad de cambios.

---

## Perfil del Desarrollador

- **Nivel de Experiencia:** Aprendiz de Programación Junior.
- **Directiva Pedagógica:** El Agente de IA actúa como Mentor Senior, proporcionando guías paso a paso, explicaciones detalladas y contextualización de cada herramienta.

---

## Registro de Actividad — 10 de abril de 2026

### Origen del Proyecto
- El proyecto **Audionotes** surge como una nueva iniciativa derivada del aprendizaje acumulado en el proyecto Truq.
- Se adopta un enfoque radicalmente diferente: **open source, sin backend propio, sin monetización**.

### Decisiones Arquitectónicas Clave
- **Sin Firebase:** Se elimina toda dependencia de servicios de backend (Firestore, Firebase Auth, Firebase Storage, Crashlytics).
- **BYOK — Google AI Studio:** El usuario provee su propia API key de Gemini. Esto elimina costos de infraestructura y garantiza privacidad total.
- **Google Drive como sistema de archivos:** En lugar de una base de datos, los archivos `.m4a` y `.md` viven directamente en la carpeta de Drive del usuario, organizados cronológicamente.
- **Distribución por APK en GitHub:** La primera etapa no requiere Google Play Store. El APK se publica en GitHub Releases.
- **Licencia MIT:** El código es completamente público y reutilizable.

### Infraestructura del Proyecto
- **Repositorio:** `git@github.com:juankeyboard/audionotes.git`
- **Servidor de desarrollo:** Linux (Ubuntu), acceso SSH configurado.
- **Framework:** Python + Kivy. Build con Buildozer para generar el APK.

---

## Aprendizajes Clave

1. **BYOK (Bring Your Own Key):** Delegar la API key al usuario elimina la necesidad de gestionar cuotas, costos y privacidad de datos en un backend propio.
2. **Google Drive como base de datos:** Para aplicaciones de archivos personales, Drive es un sistema de almacenamiento suficiente y familiar para el usuario.
3. **GitHub Releases:** Permite distribuir APKs directamente sin depender de las políticas y tiempos de revisión de Google Play Store.
4. **Open Source desde el inicio:** Definir la licencia MIT desde el primer commit facilita la contribución de la comunidad y la transparencia.
5. **Python + Kivy + Buildozer:** Se elige Python como lenguaje principal por su simplicidad y curva de aprendizaje. Kivy provee el framework UI multiplataforma y Buildozer empaqueta el proyecto como APK para Android. Las llamadas a la API de Gemini y a Google Drive se hacen via `requests` directamente, sin SDKs adicionales, para mantener el proyecto liviano y legible.
