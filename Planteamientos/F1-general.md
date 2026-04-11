# F1 — Especificaciones Generales y Hoja de Ruta — Audionotes

**¿Para qué es este documento?**
Plano maestro del proyecto. Define la arquitectura técnica, los módulos principales y las fases de implementación de Audionotes.

---

## 1. Identidad del Proyecto

- **Nombre:** Audionotes
- **Repositorio oficial:** `github.com/juankeyboard/audionotes`
- **Licencia:** MIT (open source completo)
- **Plataforma:** Android (APK)
- **Distribución:** GitHub Releases (sin Google Play Store)
- **Lenguaje de desarrollo:** Python
- **Framework UI:** Kivy
- **Build:** Buildozer (genera el APK desde Python)

---

## 2. Propósito

Audionotes es una aplicación Android de código abierto que permite al usuario grabar audio, transcribirlo y exportarlo como archivo `.md`, usando su propia API key de Google AI Studio (Gemini). Toda la gestión de archivos se realiza directamente en una carpeta de Google Drive configurada por el usuario.

**Sin backend propio. Sin servidores. Sin suscripciones.**

---

## 3. Principios Fundamentales

- **Open Source:** Código 100% público bajo licencia MIT.
- **BYOK (Bring Your Own Key):** El usuario provee su API key de Google AI Studio. La app no procesa ni almacena la clave en servidores externos.
- **Google Drive como sistema de archivos:** Audionotes no tiene base de datos propia. Los audios y los `.md` viven en la carpeta de Drive del usuario.
- **Local-First:** El procesamiento se realiza directamente desde el dispositivo hacia la API de Gemini. No hay intermediarios.
- **Organización cronológica:** Los archivos se nombran y ordenan por fecha/hora de creación (`YYYY-MM-DD_HH-MM-SS_titulo.md`).

---

## 4. Arquitectura Técnica

```
[Dispositivo Android]
    ↓ graba audio
[Archivo de audio local temporal]
    ↓ envía a API
[Google Gemini API] ← API Key del usuario (Google AI Studio)
    ↓ retorna transcripción + análisis
[Archivo .md generado localmente]
    ↓ sube ambos archivos
[Google Drive — Carpeta configurada por el usuario]
```

**Stack:**
- **Lenguaje:** Python 3
- **Framework UI:** Kivy (KV language)
- **Build:** Buildozer → APK
- **IA:** Gemini 1.5 Flash via REST (`requests`) con API key del usuario
- **Audio:** `plyer.audio` para grabacion desde el microfono
- **Almacenamiento:** Google Drive API via `requests` (scope `drive.file`)
- **Autenticación Drive:** OAuth 2.0 via navegador del dispositivo + pegado de token/code
- **Persistencia local:** `kivy.storage.JsonStore` (API key, ID de carpeta Drive)

---

## 5. Fases de Implementación

### Fase 1 — Interfaz de Usuario: APK Navegable en GitHub *(Prioridad actual)*

Objetivo: construir y publicar un APK instalable con todas las pantallas navegables. Sin lógica real — los botones responden visualmente, los formularios aceptan texto, pero no hay llamadas a APIs ni grabación de audio real. Permite validar el diseño y el flujo antes de conectar funcionalidad.

- [ ] Configurar proyecto Python + Kivy + Buildozer
- [ ] Pantalla de Onboarding: campo API key, pantalla OAuth (placeholder), campo ID carpeta Drive
- [ ] Pantalla Principal (Home): lista simulada de grabaciones con datos de prueba
- [ ] Pantalla de Grabacion: waveform visual, temporizador, boton de detener (sin audio real)
- [ ] Pantalla de Resultado: confirmacion de subida simulada (sin Drive real)
- [ ] Pantalla de Ajustes: campos editables para API key e ID de carpeta
- [ ] Navegacion completa entre todas las pantallas
- [ ] Pipeline de build con Buildozer configurado y funcionando
- [ ] APK publicado en GitHub Releases e instalable en Android

### Fase 2 — Funcionalidad Real *(siguiente etapa)*
- [ ] Grabacion de audio con microfono interno (`plyer.audio`)
- [ ] Envio a Gemini y recepcion de transcripcion en `.md` (`requests`)
- [ ] Autenticacion OAuth 2.0 con Google Drive (flujo real via navegador)
- [ ] Subida de audio a `audio/` y `.md` a `texto/` en Drive
- [ ] Lista de grabaciones leida desde Drive (no simulada)
- [ ] Manejo de errores: sin conexion, API key invalida, cuota agotada

### Fase 3 — Mejoras de Experiencia
- [ ] Soporte para microfonos Bluetooth
- [ ] Identificacion de participantes (diarizacion)
- [ ] Cola automatica de sincronizacion offline

### Fase 4 — Funcionalidades Avanzadas
- [ ] Busqueda semantica en el historial
- [ ] Registro GPS al momento de la grabacion
- [ ] Exportacion con timestamps `[hh:mm:ss]`

---

## 6. Estructura de Archivos en Google Drive

```
📁 {carpeta configurada por el usuario}/
  📁 audio/
    🎙️ 2026-04-10_14-32-00_reunion-equipo.m4a
    🎙️ 2026-04-10_09-15-00_nota-personal.m4a
  📁 texto/
    📄 2026-04-10_14-32-00_reunion-equipo.md
    📄 2026-04-10_09-15-00_nota-personal.md
```

- `audio/` contiene los archivos de grabacion originales.
- `texto/` contiene los archivos `.md` transcritos.
- Los archivos se nombran con datetime + titulo generado por Gemini (`YYYY-MM-DD_HH-MM-SS_titulo`).
- Cada par audio/texto comparte el mismo nombre base.

---

## 7. Modelo de Costos para el Usuario

La app es gratuita. El único costo es el uso de la API de Gemini:
- **Google AI Studio** ofrece una capa gratuita generosa (actualmente 1,500 req/día con Gemini 1.5 Flash).
- Para uso personal normal, el costo es **$0**.
- El usuario controla su consumo directamente desde su cuenta de Google.
