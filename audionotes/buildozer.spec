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
version = 0.1.0

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
# Permisos Android
# ─────────────────────────────────────────────
# RECORD_AUDIO: necesario para grabar con el micrófono
# WRITE_EXTERNAL_STORAGE: para guardar audio temporalmente antes de subir a Drive
# READ_EXTERNAL_STORAGE: para leer el archivo de audio guardado
# INTERNET: para enviar audio a Gemini y subir archivos a Drive
android.permissions = RECORD_AUDIO,WRITE_EXTERNAL_STORAGE,READ_EXTERNAL_STORAGE,INTERNET

# ─────────────────────────────────────────────
# Configuración Android
# ─────────────────────────────────────────────
# API level 33 = Android 13 (target moderno)
android.api = 33

# API mínima soportada (Android 8.0 = API 26)
android.minapi = 26

# NDK version compatible con Kivy 2.3
android.ndk = 25b

# Arquitecturas a compilar (arm64 para dispositivos modernos, armeabi-v7a para compatibilidad)
android.archs = arm64-v8a, armeabi-v7a

# Orientación (portrait = solo vertical, como dicta el diseño de la app)
orientation = portrait

# Pantalla completa (oculta la barra de estado de Android)
fullscreen = 0

# ─────────────────────────────────────────────
# Buildozer / Build
# ─────────────────────────────────────────────
[buildozer]

# Nivel de log: 0 = silencioso, 1 = normal, 2 = verbose (para debug de errores)
log_level = 2

# Advertencia al instalar: pide confirmación antes de instalar en el dispositivo
warn_on_root = 1
