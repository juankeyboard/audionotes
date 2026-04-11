# F6 — Diseño Visual y UI/UX — Audionotes

---

## 1. Filosofía de Diseño

- **Simple y funcional:** La app tiene una sola función principal (grabar y transcribir). La UI no debe distraer de eso.
- **Kivy UI:** Widgets nativos de Kivy con tema oscuro/claro sencillo. Sin dependencias de Material Design.
- **Sin pantallas innecesarias:** Flujo mínimo de pasos para llegar a grabar.

---

## 2. Pantallas Principales

### Pantalla de Onboarding (primer inicio)
1. Ingreso de API key de Google AI Studio.
2. Autenticación con Google (OAuth — para acceso a Drive).
3. Ingreso manual del ID de carpeta de Google Drive (el usuario lo copia desde la URL de Drive).
4. Solicitud de permisos de micrófono y almacenamiento.

### Pantalla Principal (Home)
- **Lista cronológica descendente** de grabaciones (la más reciente primero).
- Cada item muestra: título, fecha/hora, duración.
- **Botón central prominente** (FAB): "Nueva grabación".
- Estado de sincronización con Drive (icono de nube).

### Pantalla de Grabación
- Indicador visual de nivel de audio (waveform).
- Temporizador de duración.
- Botón de detener y procesar.

### Pantalla de Resultado
- Confirmación de subida a Google Drive (icono de exito o mensaje de error).
- No hay visualizacion del `.md` en la app — el archivo vive en Drive.

---

## 3. Gestión del Listado

- **Ordenamiento:** Cronológico descendente (más reciente primero).
- **Agrupación:** Por mes (encabezados como "Abril 2026").
- **Información por item:** Título automático, fecha/hora, duración.
- **Indicador de estado:** Procesando / Sincronizado / Error.

---

## 4. Configuración (Settings)

Accesible desde el menú o ícono en la barra superior:
- Cambiar API key de Google AI Studio.
- Cambiar el ID de carpeta de Google Drive.
- Revocar y reconectar cuenta de Google (Drive).
- Información sobre la app (versión, licencia, repositorio).

*Todos los ajustes se persisten en `JsonStore` local de Kivy.*
