[app]

# Nombre de la app visible en el lanzador de Android
title = Audionotes

# Nombre del paquete Android (debe ser único, estilo dominio invertido)
package.name = audionotes
package.domain = com.juankeyboard

# Archivo de entrada principal
source.dir = .
source.include_exts = py,kv,json,png,jpg,ttf

# Versión de la app
version = 0.1.1

# Punto de entrada
entrypoint = main.py

# ─────────────────────────────────────────────
# Dependencias Python
# ─────────────────────────────────────────────
# kivy: framework UI
# plyer: acceso a hardware (audio, GPS, permisos)
# pyjnius: llamadas a APIs nativas de Android desde Python
# requests: llamadas HTTP a Gemini API y Google Drive API
# certifi: certificados SSL para requests en Android
requirements = python3,kivy==2.3.0,plyer,pyjnius,requests,certifi

# ─────────────────────────────────────────────
# Permisos Android (mínimos necesarios — principio de menor privilegio)
# ─────────────────────────────────────────────
# RECORD_AUDIO: necesario para grabar con el micrófono
# INTERNET: para enviar audio a Gemini y subir archivos a Drive
# READ_MEDIA_AUDIO: reemplazo moderno de READ_EXTERNAL_STORAGE para audio (API 33+)
#                   Solo se solicita en Android 13+; en versiones anteriores se ignora.
#
# NOTA DE SEGURIDAD:
# Ya no declaramos WRITE_EXTERNAL_STORAGE ni READ_EXTERNAL_STORAGE.
# Desde API 29 (Android 10) el almacenamiento externo está "scoped", y desde
# API 33 (Android 13) READ_EXTERNAL_STORAGE fue reemplazado por permisos
# granulares por tipo de media (READ_MEDIA_AUDIO/IMAGES/VIDEO).
# Los archivos temporales (.m4a, .md) se guardarán en el almacenamiento PRIVADO
# de la app (getFilesDir / getCacheDir), que no requiere ningún permiso y es
# automáticamente borrado al desinstalar la app. Esta es la práctica recomendada
# por Google para evitar el warning de Play Protect.
android.permissions = RECORD_AUDIO,INTERNET,READ_MEDIA_AUDIO

# ─────────────────────────────────────────────
# Configuración Android
# ─────────────────────────────────────────────
# API level 34 = Android 14 (requerido por Google Play desde agosto 2024)
# Evita el warning de Play Protect "built for an older version of Android"
android.api = 34

# API mínima soportada (Android 8.0 = API 26)
android.minapi = 26

# NDK version compatible con Kivy 2.3 y API 34
android.ndk = 25b

# Arquitecturas a compilar (arm64 para dispositivos modernos, armeabi-v7a para compatibilidad)
android.archs = arm64-v8a, armeabi-v7a

# Formato del artefacto release: apk o aab
# Usamos APK porque Audionotes se distribuye via GitHub Releases (sideload directo).
# AAB solo sirve para Google Play Store, que no es nuestro canal de distribución.
android.release_artifact = apk

# Orientación (portrait = solo vertical, como dicta el diseño de la app)
orientation = portrait

# Pantalla completa (oculta la barra de estado de Android)
fullscreen = 0

# ─────────────────────────────────────────────
# Seguridad de red (Network Security Config)
# ─────────────────────────────────────────────
# Bloquea tráfico HTTP en texto plano (cleartext) — requerido por Android 9+
# Solo se permite HTTPS. Gemini API y Google Drive API usan HTTPS.
android.manifest.uses_cleartext_traffic = false

# ─────────────────────────────────────────────
# Privacidad y backup
# ─────────────────────────────────────────────
# Deshabilitamos el backup automático de Android para evitar que los tokens
# OAuth y la API key del usuario se suban a la cuenta Google del dispositivo.
# Esto es especialmente importante porque Audionotes guarda la API key en
# JsonStore — no queremos que se respalde automáticamente a la nube de Google.
android.allow_backup = False

# ─────────────────────────────────────────────
# Buildozer / Build
# ─────────────────────────────────────────────
[buildozer]

# Nivel de log: 0 = silencioso, 1 = normal, 2 = verbose (para debug de errores)
log_level = 2

# Advertencia al instalar: pide confirmación antes de instalar en el dispositivo
# (Desactivada en CI/entornos no interactivos — buildozer falla sin stdin.)
warn_on_root = 0
