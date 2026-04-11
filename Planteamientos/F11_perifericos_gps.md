# F11 — Periféricos y Geolocalización — Audionotes

---

## 1. Soporte Bluetooth (Fase 2)

### Micrófonos y Auriculares Externos
- La app permitirá seleccionar el dispositivo de entrada de audio antes de iniciar una grabación.
- Compatibilidad con micrófonos externos y auriculares con perfil de audio Bluetooth.

### Reglas de Uso
- La selección del dispositivo debe hacerse **antes** de iniciar la grabación.
- Una vez iniciada, no se puede cambiar la fuente de audio (para garantizar integridad del archivo).
- Si el dispositivo Bluetooth se desconecta durante la grabación, la app cambia automáticamente al micrófono interno y notifica al usuario.

---

## 2. Registro GPS (Fase 3)

### Propósito
Registrar las coordenadas donde se realizó cada grabación como metadato adicional en el archivo `.md`.

### Lógica de Captura
- **Punto de inicio:** Coordenadas GPS al momento de iniciar la grabación.
- **Muestreo periódico:** Cada 10 segundos durante la grabación.
- **Optimización de batería (regla 500m):** Si la nueva posición está dentro de un radio de 500 metros del último punto registrado, no se genera una nueva entrada.

### Formato en el `.md`

```markdown
## Ubicación

- **Inicio:** 4.7110° N, 74.0721° W (Bogotá, Colombia)
- **Fin:** 4.7120° N, 74.0715° W
```

### Permisos Requeridos
- `ACCESS_FINE_LOCATION` para GPS preciso (solicitado via `android.permissions` de pyjnius).
- El permiso es **opcional** — si el usuario lo deniega, la grabacion funciona sin metadato de ubicacion.

### Implementacion en Python
- Libreria: `plyer.gps` para captura de coordenadas en Android.

---

## 3. Resumen de Fases por Periférico

| Funcionalidad | Fase |
|---|---|
| Grabación con micrófono interno | 1 |
| Selección de fuente Bluetooth | 2 |
| Metadato GPS en el `.md` | 3 |
