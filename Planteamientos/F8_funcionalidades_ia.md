# F8 — Motor de Análisis de IA — Audionotes

---

## 1. Modelo de IA

- **Modelo:** Gemini 1.5 Flash
- **Acceso:** Google AI Studio REST API (`generativelanguage.googleapis.com`) via `requests` (Python)
- **Autenticación:** API key provista por el usuario (sin backend intermediario)
- **Capacidad clave:** Multimodal nativo — puede recibir audio directamente sin necesidad de transcripción previa separada.

---

## 2. Flujo de Procesamiento

```
[Audio .m4a grabado]
    ↓
[Codificado en base64 o enviado como archivo]
    ↓
[Petición a Gemini API con prompt estructurado]
    ↓
[Respuesta: transcripción + título + análisis en formato .md]
    ↓
[Archivo .md guardado localmente y subido a Drive]
```

---

## 3. Entregables del Análisis por Grabación

Para cada grabación, Gemini generará:

- **Título automático:** Breve y descriptivo, basado en el contenido (ej. `reunion-equipo-abril`, `nota-compras`).
- **Transcripción completa:** Texto plano organizado por párrafos.
- **Identificación de participantes (Fase 2):** Si hay múltiples voces, etiquetarlas como `Participante 1`, `Participante 2`, etc. (diarización básica).
- **Resumen ejecutivo (Fase 2):** Párrafo breve con los puntos principales.
- **Palabras clave / temas (Fase 2):** Lista al final del `.md`.

---

## 4. Estructura del Prompt a Gemini

```
Eres un asistente de transcripción. Analiza el siguiente audio y devuelve:
1. Un título corto (máximo 5 palabras, en minúsculas con guiones).
2. La transcripción completa, organizada en párrafos.

Formato de respuesta en Markdown.
```

*(La diarizacion de voces se incorpora en el prompt a partir de la Fase 2.)*

*(El prompt puede personalizarse en versiones futuras desde los Ajustes de la app.)*

---

## 5. Manejo de Límites de la API

- La capa gratuita de Google AI Studio permite ~1,500 solicitudes/día con Gemini 1.5 Flash.
- Si la API devuelve un error de cuota, la app informa al usuario con un mensaje claro y reintenta automáticamente después de un intervalo.
- Los audios largos se dividen en segmentos si superan el límite de tamaño de la API (Fase 2).

---

## 6. Funcionalidades de IA — Fases

| Funcionalidad | Fase |
|---|---|
| Transcripción básica | 1 |
| Título automático | 1 |
| Diarización (identificación de voces) | 2 |
| Resumen y palabras clave | 2 |
| Búsqueda semántica en historial (RAG) | 3 |
| Segmentación de audios largos | 2 |
