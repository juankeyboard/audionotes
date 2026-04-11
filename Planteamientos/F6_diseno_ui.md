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

---

## 5. Diseño de Referencia — "Sonic Clarity" (Mockup HTML)

Este mockup sirve como referencia visual para el estilo y estructura de la app.

### Identidad Visual

- **Nombre de referencia:** Sonic Clarity
- **Lema visual:** *"Your voice, perfectly captured."*
- **Estética:** "Sonic Canvas" — uso de orbs desenfocadas (blur) en fondo para profundidad ambiental.
- **Tema:** Light por defecto, con soporte dark.

### Paleta de Colores (Material Design 3)

| Token | Valor hex |
|---|---|
| `primary` | `#004ced` |
| `primary-dim` | `#0042d1` |
| `primary-container` | `#dde1ff` |
| `on-primary-container` | `#0041d0` |
| `surface` | `#f8f9fa` |
| `surface-container-lowest` | `#ffffff` |
| `surface-container-low` | `#f1f4f6` |
| `surface-container` | `#eaeff1` |
| `surface-container-high` | `#e3e9ec` |
| `on-surface` | `#2b3437` |
| `on-surface-variant` | `#586064` |
| `outline` | `#737c7f` |
| `outline-variant` | `#abb3b7` |
| `secondary` | `#5f5e62` |
| `tertiary` | `#635b77` |
| `tertiary-container` | `#e9ddff` |
| `error` | `#9e3f4e` |

### Tipografía

| Rol | Familia | Pesos usados |
|---|---|---|
| Headlines / Body | Manrope | 200, 400, 600, 700, 800 |
| Labels / UI pequeño | Inter | 400, 500, 600 |

### Border Radius

- Cards grandes: `2rem` (32px)
- Cards medianas: `1.5rem` (24px)
- Pills / badges: `full` (9999px)
- Default: `0.25rem`

### Componentes Clave

#### TopAppBar
- Fija en top, `z-50`, fondo `slate-50/80` con `backdrop-blur-xl`.
- Altura: `h-16`. Contenido: ícono menú izquierda + nombre app + avatar usuario derecha.

#### Hero Section
- Etiqueta pequeña en mayúsculas (font-label, on-surface-variant).
- Título editorial `text-5xl` → `text-7xl` en md, `font-extrabold`, `tracking-tighter`.
- Parte del título en color `primary`.

#### Bento Grid de Stats
- Grid de 12 columnas: card principal `col-span-7`, card cita `col-span-5`.
- Card principal: ícono `graphic_eq`, badge "Live status", número grande + descripción.
- Card cita: texto italic en `on-surface-variant`.
- Bordes redondeados `rounded-[2rem]`, sin borde explícito, sombra `shadow-sm`.

#### Lista de Transcripciones
- Cada item: fecha+hora (izquierda) | título+extracto (centro) | chevron (derecha).
- Hover: fondo blanco + borde izquierdo `border-primary` de 4px.
- Extracto con `line-clamp-2`.

#### FAB (Botón de Nueva Grabación)
- Posición: `fixed bottom-24`, centrado horizontalmente.
- Ancho: `90%` del viewport, máx `max-w-md`.
- Fondo: gradiente `from-primary to-primary-dim`.
- Forma: `rounded-full`.
- Sombra: `shadow-[0_8px_32px_rgba(0,76,237,0.3)]`.
- Contenido: ícono `mic` (filled) + texto "Start New Recording" + flecha derecha.
- Interacción: `hover:scale-[1.02]` / `active:scale-95`.

#### BottomNavBar
- Fija en bottom, `backdrop-blur-xl`, `rounded-t-3xl`.
- 4 ítems: **Home** (activo), **Record**, **History**, **Search**.
- Ítem activo: pill azul (`bg-blue-600`), `scale-110`, sombra `shadow-blue-500/20`.
- Ítems inactivos: `text-slate-400`, hover → `text-blue-500`.

#### Decoración de Fondo (Sonic Canvas)
- Solo visible en `lg+` (`hidden lg:block`).
- Dos orbs con `blur-[120px]` / `blur-[100px]` en esquina derecha.
- Colores: `primary` y `tertiary-container`, `opacity-20`.
- `pointer-events-none`, `z-0`.
