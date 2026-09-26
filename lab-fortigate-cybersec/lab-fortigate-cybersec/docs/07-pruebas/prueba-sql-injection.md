# Prueba de SQL Injection

[⬅ Volver al índice principal](../../README.md)

## Objetivo
Demostrar que el FortiGate detecta, bloquea y registra un intento de explotación de SQL Injection contra la página vulnerable `search.php` del WEB-Server, y que pone al atacante en cuarentena.

## Condiciones iniciales
- Perfil IPS `IPS-Anti-SQLi` asignado a la política `USUARIOS-a-WEB`, acción `Quarantine (Expires 5 Minute(s))` (ver [`../03-fortigate/sql-injection.md`](../03-fortigate/sql-injection.md)).
- SSL Inspection (`custom-deep-inspection`) activo sobre el mismo tráfico (ver [`../03-fortigate/dpi.md`](../03-fortigate/dpi.md)).
- Cliente `10.6.97.130` en la red de Usuarios.

## Procedimiento

1. Envío de una petición con payload de tautología SQL contra el parámetro `id` de `search.php`, vía PowerShell:
   ```
   Invoke-WebRequest -Uri "http://10.6.97.2/?id=1'%20OR%20'1'='1"
   ```
2. Envío de un segundo intento directamente desde la barra de direcciones del navegador:
   ```
   http://10.6.97.2/' OR '1'='1
   ```

## Resultado esperado
El FortiGate debe bloquear la petición, generar un log de intrusión y poner en cuarentena la IP de origen durante el tiempo configurado (5 minutos).

## Resultado observado

1. El navegador recibe la página de reemplazo del FortiGate: **"Blocked because of an intrusion attack"**, indicando explícitamente que el equipo fue bloqueado por un ataque de intrusión detectado.
2. El widget de cuarentena del FortiGate muestra la IP `10.6.97.130` baneada, origen `IPS`, con 4 minutos 25 segundos restantes de una ventana de 5 minutos.
3. El log de intrusión registra: `Attack Name: HTTP.URI.SQL.Injection`, `Attack ID: 15621`, `Direction: outgoing`, `Message: web_misc: HTTP.URI.SQL.Injection`.
4. La lista de logs de seguridad registra el evento con acción `dropped`.

## Evidencia

| Evidencia | Descripción |
|---|---|
| [`EVID-TEST-005`](../../evidence/06-pruebas/EVID-TEST-005.png) | Payload utilizado (historial del navegador) |
| [`EVID-FGT-024`](../../evidence/07-logs/EVID-FGT-024.png) | Página de bloqueo por intrusión |
| [`EVID-FGT-023`](../../evidence/07-logs/EVID-FGT-023.png) | Widget de cuarentena con IP baneada |
| [`EVID-FGT-020`](../../evidence/07-logs/EVID-FGT-020.png) | Detalle del log IPS |
| [`EVID-FGT-021`](../../evidence/07-logs/EVID-FGT-021.png) | Entrada en lista de logs (`dropped`) |

## Conclusión de la prueba

**Éxito.** Se demuestra de forma consistente y correlacionada en el tiempo (ver análisis de correlación en [`../03-fortigate/cuarentena.md`](../03-fortigate/cuarentena.md)) que el FortiGate:
1. Detecta el patrón de SQL Injection mediante el perfil IPS (FGT-06).
2. Bloquea la solicitud (FGT-07, FGT-10).
3. Pone al atacante en cuarentena por 5 minutos (FGT-08).
4. Genera logs completos y trazables del evento (FGT-11).

Cumple íntegramente los requisitos FGT-06, FGT-07, FGT-08, FGT-09, FGT-10 y FGT-11.
