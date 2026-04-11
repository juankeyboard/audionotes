# F7 — Guía de Voz, Tono y Estilo — Audionotes

---

## 1. Tono General

Audionotes es una herramienta personal y de código abierto. El tono es **claro, directo y amigable**, sin ser informal ni corporativo. Se trata al usuario como a alguien técnicamente capaz.

---

## 2. Principios de Comunicación

- **Claridad:** Los mensajes explican qué pasó y qué hacer a continuación.
- **Brevedad:** Sin textos largos en la UI. Una acción, una frase.
- **Honestidad:** Si algo falla, el error debe ser descriptivo y útil (especialmente cuando involucra la API de Gemini o Google Drive).

---

## 3. Ejemplos de Vocabulario

| En lugar de... | Usar... |
|---|---|
| "Grabar" | "Nueva grabación" |
| "Algo salió mal" | "Error al conectar con Gemini. Verifica tu API key." |
| "Listo" | "Transcripción lista y guardada en Drive." |
| "Configuración" | "Ajustes" |
| "Iniciar sesión" | "Conectar con Google" |
| "Subiendo..." | "Guardando en Drive..." |

---

## 4. Mensajes de Error

Los errores deben ser **accionables**:
- Error de API key inválida: "API key inválida. Ve a Ajustes para actualizarla."
- Error de conexión: "Sin conexión a internet. La grabación se procesará cuando vuelvas a conectarte."
- Error de Drive: "No se pudo acceder a la carpeta de Drive. Verifica los permisos."

---

## 5. Idioma

La app estará en **español** como idioma principal en la primera fase, con estructura preparada para internacionalización (i18n con Flutter) en fases posteriores.
