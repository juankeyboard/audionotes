# F3 — Marco Legal: Licencia, Términos y Privacidad — Audionotes

---

## 1. Licencia de Software

- **Tipo:** MIT License
- **Implicación:** Cualquier persona puede usar, copiar, modificar, fusionar, publicar, distribuir, sublicenciar y/o vender copias del software libremente, siempre que se mantenga el aviso de copyright original.

---

## 2. Términos de Uso

- **Responsabilidad del usuario:** El usuario es el único responsable del contenido grabado y de cumplir con las leyes locales sobre grabación de terceros (consentimiento).
- **Propiedad de los datos:** El usuario retiene el 100% de la propiedad de sus audios y transcripciones. Los archivos viven en su propia cuenta de Google Drive.
- **Sin garantías:** El software se entrega "tal cual" (as-is), sin garantías de ningún tipo, conforme a los términos de la licencia MIT.

---

## 3. Política de Privacidad

### Datos que la app NO recopila
- La app **no tiene servidor propio**. No hay base de datos, no hay analítica, no hay telemetría.
- La API key del usuario se almacena **únicamente en el dispositivo** (archivo local `JsonStore` de Kivy) y nunca se transmite a servidores de Audionotes.

### Flujo de datos real
| Dato | Origen | Destino | Propósito |
|---|---|---|---|
| Audio grabado | Micrófono del dispositivo | Google Gemini API (vía API key del usuario) | Transcripción |
| Transcripción `.md` | Gemini API | Google Drive del usuario | Almacenamiento |
| Audio `.m4a` | Dispositivo | Google Drive del usuario | Almacenamiento |
| API key | Usuario (ingresada en onboarding) | JsonStore local del dispositivo | Autenticación con Gemini |

### Terceros involucrados
- **Google Gemini API:** El audio es procesado por Google bajo los términos de uso de Google AI Studio del propio usuario.
- **Google Drive API:** Los archivos se almacenan en la cuenta de Drive del usuario bajo sus propias políticas de privacidad de Google.

---

## 4. Contribuciones (Open Source)

Las contribuciones al repositorio se rigen por la misma licencia MIT. Al enviar un Pull Request, el contribuyente acepta que su código queda bajo esta licencia.
