# F10 — Onboarding: Configuración Inicial — Audionotes

---

## 1. Objetivo del Onboarding

Guiar al usuario en los 3 pasos mínimos necesarios para que la app funcione:
1. Ingresar su API key de Google AI Studio.
2. Autenticarse con Google para que la app pueda escribir en Drive.
3. Ingresar el ID de la carpeta de Drive donde se guardarán los archivos.

El onboarding solo se muestra en el primer inicio. Puede reaccederse desde Ajustes.

---

## 2. Pantalla 1 — Bienvenida

Pantalla simple con:
- Nombre e ícono de la app.
- Descripción en 2 líneas: "Graba audio. Obtén texto. Todo en tu Google Drive."
- Botón: "Comenzar".

---

## 3. Pantalla 2 — API Key de Google AI Studio

**Qué se muestra:**
- Campo de texto para ingresar la API key.
- Enlace informativo: "¿Cómo obtengo mi API key?" → abre `aistudio.google.com` en el navegador.
- Instrucciones breves:
  1. Ve a Google AI Studio.
  2. Crea un proyecto o usa uno existente.
  3. Genera una API key y pégala aquí.
- Botón "Verificar y continuar" → hace una llamada de prueba a Gemini via `requests` para validar la key.

**Almacenamiento:** La key se guarda en `JsonStore` local de Kivy. Nunca sale del dispositivo hacia servidores de Audionotes.

---

## 4. Pantalla 3 — Conectar Google Drive

**Qué se muestra:**
- Explicacion: "Audionotes guardará tus grabaciones y transcripciones en una carpeta de tu Google Drive."
- Botón: "Conectar con Google" → abre el navegador del dispositivo con la URL de autorizacion OAuth 2.0.
- Scope solicitado: solo acceso a archivos creados por la app (`drive.file`).
- Campo de texto: "Pega aqui el codigo de autorizacion que Google te mostro."
- Botón "Confirmar" → la app intercambia el codigo por tokens de acceso via `requests` y los guarda en `JsonStore`.

---

## 5. Pantalla 4 — ID de Carpeta de Drive

**Qué se muestra:**
- Instruccion breve: "Abre Google Drive en tu navegador, navega a la carpeta donde quieras guardar tus grabaciones, y copia el ID que aparece al final de la URL."
- Ejemplo visual: `drive.google.com/drive/folders/`**`1aBcDeFgHiJkLmNoPqRsTuVwXyZ`**
- Campo de texto para pegar el ID.
- Boton "Verificar y continuar" → la app intenta listar el contenido de esa carpeta para confirmar acceso.

**Almacenamiento:** El ID se guarda en SharedPreferences. No se almacena ningun contenido del Drive del usuario.

---

## 6. Pantalla 5 — Permisos del Dispositivo

Se solicitan los siguientes permisos via `android.permissions` (pyjnius), uno a la vez, con explicacion del motivo:
- **RECORD_AUDIO:** "Necesario para grabar audio."
- **WRITE_EXTERNAL_STORAGE:** "Necesario para guardar el audio temporalmente antes de subirlo a Drive."
- **INTERNET:** "Necesario para enviar el audio a Gemini y subir archivos a Drive."

---

## 7. Pantalla Final — Listo

- Confirmación: "Todo está configurado. Ya puedes grabar."
- Botón: "Ir a la app" → navega a la pantalla principal.

---

## 8. Acceso Posterior desde Ajustes

Desde la pantalla de Ajustes el usuario puede:
- Cambiar la API key de Google AI Studio.
- Cambiar el ID de carpeta de Google Drive.
- Desconectar la cuenta de Google.
