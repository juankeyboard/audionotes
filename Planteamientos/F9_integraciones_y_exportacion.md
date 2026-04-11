# F9 — Google Drive: Sistema de Archivos Principal — Audionotes

---

## 1. Rol de Google Drive en Audionotes

Google Drive **no es una exportación opcional** — es el sistema de almacenamiento principal de la app. No hay base de datos local de largo plazo. Todos los archivos generados viven en la carpeta de Drive configurada por el usuario.

---

## 2. Configuración Inicial

Durante el onboarding, el usuario:
1. La app abre el flujo OAuth 2.0 en el navegador del dispositivo.
2. El usuario autoriza el acceso y copia el codigo de autorizacion de vuelta a la app.
3. La app intercambia el codigo por tokens de acceso (guardados en `JsonStore` local).
4. El usuario pega el ID de carpeta de Drive (copiado desde la URL de Drive).

**Scope de permisos de Drive solicitado:** Acceso restringido unicamente a archivos creados por la app (`drive.file`), no a todo el Drive del usuario.

**Libreria:** Llamadas REST directas via `requests` — sin dependencias de SDK de Google para mantener el APK liviano.

---

## 3. Estructura de Archivos en Drive

```
📁 {carpeta configurada por el usuario}/
  📁 audio/
    🎙️ 2026-04-10_14-32-00_titulo.m4a
    🎙️ 2026-04-10_09-15-00_nota-personal.m4a
  📁 texto/
    📄 2026-04-10_14-32-00_titulo.md
    📄 2026-04-10_09-15-00_nota-personal.md
```

- `audio/` contiene todas las grabaciones originales.
- `texto/` contiene todos los archivos `.md` transcritos.
- Los archivos se nombran `YYYY-MM-DD_HH-MM-SS_titulo` (datetime + titulo generado por Gemini).
- Cada par audio/texto comparte el mismo nombre base.
- No hay subcarpetas por mes — la organizacion cronologica se da por el nombre del archivo.

---

## 4. Flujo de Sincronización

1. El usuario graba audio → se guarda temporalmente en el dispositivo.
2. La app envía el audio a Gemini y recibe el `.md`.
3. La app sube el audio a `audio/` y el `.md` a `texto/` en la carpeta configurada.
4. El archivo temporal local se elimina del dispositivo.
5. La lista en la app se actualiza leyendo los archivos de Drive.

---

## 5. Formato del Archivo `.md`

```markdown
# Título de la Grabación

**Fecha:** 2026-04-10  
**Hora:** 14:32:00  
**Duración:** 00:05:42

---

## Transcripción

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore.

*(Identificacion de participantes disponible a partir de Fase 2.)*

---

## Resumen *(Fase 2)*

Breve descripción del contenido.

## Palabras clave *(Fase 2)*
- keyword1, keyword2, keyword3
```

---

## 6. Modo Offline

- Si no hay conexion al momento de procesar, la app informa al usuario con un mensaje claro.
- El usuario reintenta manualmente cuando recupere conexion.
- *(Cola automatica de sincronizacion diferida a Fase 2.)*

---

## 7. Compatibilidad del `.md`

Los archivos generados son compatibles con:
- **Obsidian**, **Notion**, **Logseq** (gestores de conocimiento personal)
- **GitHub** (renderizado nativo de Markdown)
- **VS Code**, cualquier editor de texto
