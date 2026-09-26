# Prueba de Rate Limiting / Mitigación de DoS

[⬅ Volver al índice principal](../../README.md)

## Objetivo
Demostrar que la política `DoS-Protection` (anomalías L3/L4) del FortiGate detecta y mitiga un patrón de múltiples conexiones TCP simultáneas hacia el WEB-Server, típico de un ataque de denegación de servicio.

## Condiciones iniciales
- Política `DoS-Protection.` configurada sobre `port2.10`, origen `RED-Usuarios`, destino `WEB-Server`, servicio `HTTPS-443`, con anomalías `tcp_syn_flood` y `tcp_src_session` en acción `Block`, umbral `5` (ver [`../03-fortigate/rate-limiting.md`](../03-fortigate/rate-limiting.md)).

## Procedimiento
Ejecución, desde el cliente de Usuarios (`10.6.97.130`), del siguiente script PowerShell que abre hasta 500 conexiones TCP consecutivas hacia `10.6.97.2:443`:

```powershell
1..500 | ForEach-Object {
    try {
        $tcp = New-Object System.Net.Sockets.TcpClient
        $tcp.Connect("10.6.97.2", 443)
        $tcp.Close()
    } catch {}
}
```

## Resultado esperado
El FortiGate debe detectar que el número de sesiones desde el mismo origen supera el umbral configurado (5) y terminar (`clear_session`) las sesiones ofensoras, registrando el evento como anomalía DoS.

## Resultado observado
- Log de anomalía: `Threat Level: Critical`, `Threat Score: 50`, `Anomaly Attack Name: tcp_src_session`, mensaje **`anomaly: tcp_src_session, 6 > threshold 5`**.
- Acción registrada: `clear_session`, `Policy ID: DoS-Protection. (1)`.
- Segundo evento relacionado, pocos segundos después, con anomalía `tcp_syn_flood`, también con acción `clear_session`.

## Evidencia

| Evidencia | Descripción |
|---|---|
| [`EVID-WEB-004`](../../evidence/04-servidores/EVID-WEB-004.png) | Script generador de tráfico (500 conexiones TCP) |
| [`EVID-FGT-026`](../../evidence/07-logs/EVID-FGT-026.png) | Log de anomalía `tcp_src_session` (Critical, 6 > umbral 5) |
| [`EVID-FGT-027`](../../evidence/07-logs/EVID-FGT-027.png) | Detalle de sesión con acción `clear_session` |
| [`EVID-FGT-028`](../../evidence/07-logs/EVID-FGT-028.png) | Lista de logs con dos eventos `clear_session` |

## Conclusión de la prueba

**Éxito.** El requisito FGT-15 (rate limiting / mitigación de DoS) queda demostrado: el umbral configurado (5 sesiones concurrentes) fue efectivamente excedido por el tráfico de prueba (6 sesiones detectadas) y el FortiGate terminó activamente las sesiones ofensoras, dejando registro completo en los logs.
