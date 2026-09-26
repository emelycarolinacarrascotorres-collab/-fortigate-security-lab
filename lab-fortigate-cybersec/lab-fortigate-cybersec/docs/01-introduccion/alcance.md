# Alcance del Laboratorio

[⬅ Volver al índice principal](../../README.md)

## Dentro del alcance

- Diseño y despliegue de la topología en **GNS3**, con los siguientes nodos: 1 FortiGate (`FortiGate7.0.9-1`), 1 switch Cisco IOS (`CiscoIOSvL215.2`), 1 servidor WEB (contenedor Docker, `web-server-lab-1`), 1 servidor de base de datos (contenedor Docker, `db-server-lab-1`), 1 equipo cliente Windows (`windows10-1`) y una nube NAT (`NAT1`) para la salida hacia Internet.
- Configuración completa del FortiGate vía **GUI**: interfaces, rutas, NAT, objetos de dirección, políticas de firewall, perfiles de seguridad (IPS, SSL/SSH Inspection, File Filter) y política de protección DoS.
- Configuración del switch Cisco IOS vía CLI: VLAN 10, enlace troncal, port-security y hardening básico.
- Configuración de los servidores WEB y DB mediante Dockerfiles y scripts de arranque de red.
- Ejecución de pruebas de conectividad, de política y de ataque (SQL Injection, descarga de `.exe`, simulación de DoS) desde el cliente Windows y desde los propios contenedores.
- Recolección de evidencia (capturas de pantalla, salidas de consola, logs del FortiGate) de cada control implementado.

## Fuera del alcance / no cubierto por el material disponible

> [!NOTE]
> Conforme a la regla de no inventar información, se listan explícitamente los aspectos para los que **no se recibió evidencia o dato** en el material proporcionado. Estos se marcan también en las secciones correspondientes y en la [Matriz de Trazabilidad](../08-trazabilidad/matriz-requisitos-evidencias.md).

- Valor numérico exacto configurado para el *rate limiting* de aplicación (si existiera uno adicional al perfil DoS-Protection): **Dato no proporcionado en el material disponible.** Lo documentado corresponde a la política **DoS-Protection** con anomalías L3/L4 (ver [`rate-limiting.md`](../03-fortigate/rate-limiting.md)).
- Configuración de DHCP Snooping, STP avanzado o shutdown de puertos en el switch: **no se documentan** por no aparecer en el material (ver [`seguridad.md`](../04-switch/seguridad.md)).
- Running-config completo y exportado del FortiGate (`show full-configuration`): **no proporcionado**; se documenta a partir de capturas de GUI y de los fragmentos CLI entregados.
- Enlace del video demostrativo: **pendiente de incorporar** (ver [README](../../README.md)).
