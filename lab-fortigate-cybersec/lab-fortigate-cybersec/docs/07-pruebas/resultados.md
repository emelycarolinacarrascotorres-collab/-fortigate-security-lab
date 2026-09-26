# Resultados Generales de las Pruebas

[⬅ Volver al índice principal](../../README.md)

## Resumen ejecutivo

Todas las pruebas ejecutadas y documentadas en esta sección arrojaron el resultado esperado, confirmando que los controles de seguridad implementados en el FortiGate, el switch y los servidores funcionan según lo diseñado:

| # | Prueba | Resultado |
|---|---|---|
| 1 | Cliente → Gateway VLAN 10 | ✅ Éxito |
| 2 | Cliente → Internet (NAT + ruta default) | ✅ Éxito |
| 3 | Cliente → WEB-Server HTTPS/443 | ✅ Éxito (permitido) |
| 4 | Cliente → WEB-Server HTTP/80 | ✅ Éxito (bloqueado, como se esperaba) |
| 5 | Cliente → DB-Server TCP/3306 | ✅ Éxito (bloqueado, como se esperaba) |
| 6 | WEB-Server → DB-Server TCP/3306 | ✅ Éxito (permitido) |
| 7 | WEB-Server → DB-Server (80/22/443) | ✅ Éxito (bloqueado, como se esperaba) |
| 8 | Conexión aplicativa PHP → MariaDB | ✅ Éxito |
| 9 | SQL Injection (detección, bloqueo, cuarentena, logs) | ✅ Éxito |
| 10 | Filtrado de descarga `.exe` | ✅ Éxito |
| 11 | Rate limiting / mitigación DoS | ✅ Éxito |

## Requisitos con evidencia completa vs. pendiente

| Requisito | Evidencia disponible | Evidencia faltante |
|---|---|---|
| FGT-01 a FGT-15 | Configuración GUI, pruebas activas y logs para todos los ítems | Valor numérico adicional de "rate limit" en pps/cps más allá de los umbrales de sesión documentados (ver nota en [`../03-fortigate/rate-limiting.md`](../03-fortigate/rate-limiting.md)) |
| SW-01, SW-02 | Running-config completo, `show port-security` | Segunda verificación de `show port-security` que aclare el estado "Disabled"/"Secure-down" observado (ver [`../04-switch/seguridad.md`](../04-switch/seguridad.md)) |
| SRV-01 a SRV-04 | Dockerfiles, scripts, pruebas de puerto, banner MariaDB | Captura de `ip addr` ejecutada directamente en `db-server-lab-1` |
| USR-01 a USR-03 | Objeto de dirección, interfaz VLAN, `ipconfig` del cliente | Servidor(es) DNS entregado(s) al cliente por DHCP (no proporcionado) |

## Conclusiones generales

1. La segmentación de red diseñada (Usuarios / WEB-Server / DB-Server) se comporta exactamente como fue especificada: cada política de firewall produjo el resultado esperado en las pruebas activas.
2. Los controles de inspección de aplicación (DPI, SSL Inspection, IPS Anti-SQLi) demostraron ser efectivos contra un ataque real de SQL Injection, incluyendo la respuesta automática de cuarentena.
3. El filtrado de contenido (`.exe`) y la protección DoS (anomalías L3/L4) fueron verificados con tráfico de prueba generado específicamente para activarlos, y ambos registraron el evento correctamente en los logs del FortiGate.
4. La seguridad básica del switch (cifrado de contraseñas, acceso SSH únicamente, BPDU Guard, CDP deshabilitado, port-security) está configurada conforme al running-config, con una observación menor pendiente de verificar (ver tabla anterior).

Ver el detalle completo de trazabilidad requisito → configuración → prueba → evidencia en la [Matriz de Trazabilidad](../08-trazabilidad/matriz-requisitos-evidencias.md).
