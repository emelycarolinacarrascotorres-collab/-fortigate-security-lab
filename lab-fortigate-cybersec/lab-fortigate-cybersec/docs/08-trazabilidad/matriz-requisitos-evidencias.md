# Matriz de Trazabilidad — Requisito → Configuración → Prueba → Evidencia → Documento

[⬅ Volver al índice principal](../../README.md)

Esta matriz cubre **todos** los requisitos listados en [`../01-introduccion/requisitos.md`](../01-introduccion/requisitos.md), sin omisiones ni agrupaciones. Permite a un evaluador ir directamente de un requisito a su implementación, prueba y evidencia.

| ID | Requisito | Componente | Configuración | Prueba | Evidencia | Documento | Estado |
|----|-----------|------------|----------------|--------|-----------|-----------|--------|
| FGT-01 | Ruta por defecto | FortiGate | Static Route `0.0.0.0/0` vía `192.168.42.1` en `port1` | Ping 8.8.8.8 desde cliente | EVID-FGT-002, EVID-USR-003 | [`ruta-default.md`](../03-fortigate/ruta-default.md) | ✅ Implementado |
| FGT-02 | NAT | FortiGate | NAT habilitado en política `Usuarios-a-Internet` (port2.10→port1) | Ping 8.8.8.8 desde cliente | EVID-FGT-012, EVID-FGT-013, EVID-USR-003 | [`nat.md`](../03-fortigate/nat.md) | ✅ Implementado |
| FGT-03 | Política 1: Usuarios → WEB-Server HTTPS/443 | FortiGate | Política `USUARIOS-a-WEB` (ACCEPT, servicio HTTPS-443) | Test-NetConnection 443 exitoso | EVID-FGT-011, EVID-TEST-001 | [`politica-usuarios-web.md`](../03-fortigate/politica-usuarios-web.md) | ✅ Implementado |
| FGT-04 | Política 2: Bloquear Usuarios → DB-Server TCP/3306 | FortiGate | Política `BLOQUEO-Usuarios-a-DB` (DENY) | Test-NetConnection 3306 fallido | EVID-FGT-011, EVID-TEST-003 | [`politica-usuarios-db.md`](../03-fortigate/politica-usuarios-db.md) | ✅ Implementado |
| FGT-05 | Activar DPI | FortiGate | Perfil SSL/SSH Inspection `custom-deep-inspection` (modo Protecting SSL Server, HTTPS/443) | Detección exitosa de SQLi (requiere descifrado) | EVID-FGT-014, EVID-FGT-020 | [`dpi.md`](../03-fortigate/dpi.md) | ✅ Implementado |
| FGT-06 | Regla de detección de SQL Injection | FortiGate | Perfil IPS `IPS-Anti-SQLi` con firmas SQLi | Payload SQLi generado y detectado | EVID-FGT-016, EVID-FGT-020 | [`sql-injection.md`](../03-fortigate/sql-injection.md) | ✅ Implementado |
| FGT-07 | Bloquear intentos de SQL Injection | FortiGate | Acción `Quarantine` en firmas del perfil IPS | Página "Blocked because of an intrusion attack" | EVID-FGT-016, EVID-FGT-024 | [`sql-injection.md`](../03-fortigate/sql-injection.md) | ✅ Implementado |
| FGT-08 | Colocar al atacante en cuarentena | FortiGate | Acción `Quarantine (Expires 5 Minute(s))` del perfil IPS | Widget de cuarentena con IP baneada | EVID-FGT-023 | [`cuarentena.md`](../03-fortigate/cuarentena.md) | ✅ Implementado |
| FGT-09 | Generar tráfico/payloads de prueba | Cliente Usuarios | Payload `id=1' OR '1'='1` vía Invoke-WebRequest y navegador | Historial del navegador con el payload | EVID-TEST-005 | [`sql-injection.md`](../03-fortigate/sql-injection.md) | ✅ Implementado |
| FGT-10 | Demostrar que FortiGate bloquea los intentos | FortiGate | Perfil IPS + SSL Inspection en política `USUARIOS-a-WEB` | Página de bloqueo mostrada al atacante | EVID-FGT-024 | [`sql-injection.md`](../03-fortigate/sql-injection.md) | ✅ Implementado |
| FGT-11 | Demostrar que FortiGate genera logs | FortiGate | Logging `All` en política `USUARIOS-a-WEB` | Consulta de logs UTM/IPS | EVID-FGT-020, EVID-FGT-021 | [`sql-injection.md`](../03-fortigate/sql-injection.md) | ✅ Implementado |
| FGT-12 | WEB-Server solo se comunica con DB-Server por TCP/3306 | FortiGate + WEB-Server | Política `WEB-a-DB-3306` (único ACCEPT hacia DB-Server) | `nc` a puerto 3306 desde WEB-Server | EVID-FGT-011, EVID-DB-003 | [`comunicaciones.md`](../05-servidores/comunicaciones.md) | ✅ Implementado |
| FGT-13 | WEB-Server sin comunicación con otros servicios del DB-Server | FortiGate | Denegación implícita + `BLOQUEO-WEB-Todo-Demas` | `nc` a puertos 80/22/443 desde WEB-Server (timeout) | EVID-DB-004 | [`comunicaciones.md`](../05-servidores/comunicaciones.md) | ✅ Implementado |
| FGT-14 | Filtrado de descargas `.exe` | FortiGate | Perfil File Filter `Bloqueo-EXE` (Block, tipo exe) en política `USUARIOS-a-WEB` | Descarga de `prueba.exe` bloqueada | EVID-FGT-015, EVID-WEB-003, EVID-FGT-025 | [`filtrado-exe.md`](../03-fortigate/filtrado-exe.md) | ✅ Implementado |
| FGT-15 | Rate limiting / mitigación DoS | FortiGate | Política `DoS-Protection` (anomalías L3/L4, umbral 5/1000/2000) | Script de 500 conexiones TCP; `clear_session` registrado | EVID-FGT-017, EVID-FGT-018, EVID-WEB-004, EVID-FGT-026, EVID-FGT-027 | [`rate-limiting.md`](../03-fortigate/rate-limiting.md) | ✅ Implementado |
| SW-01 | VLAN | Switch | `vlan 10 name Usuarios`; trunk `Gi0/0`; access `Gi0/1` | Ping al gateway VLAN10; `ipconfig` cliente | EVID-SW-002, EVID-USR-001, EVID-USR-002 | [`vlan.md`](../04-switch/vlan.md) | ✅ Implementado |
| SW-02 | Seguridad básica de redes | Switch | `service password-encryption`, `enable secret`, SSH-only, `no cdp run`, BPDU Guard, port-security (max 2, restrict, sticky) | `show port-security interface Gi0/1` | EVID-SW-001, EVID-SW-004 | [`seguridad.md`](../04-switch/seguridad.md) | ✅ Implementado (con observación, ver nota) |
| SRV-01 | WEB-Server: servicio HTTPS | WEB-Server | Apache2 + mod_ssl, certificado autofirmado | Test-NetConnection 443 exitoso | EVID-TEST-001 | [`web-server.md`](../05-servidores/web-server.md) | ✅ Implementado |
| SRV-02 | WEB-Server se comunica con DB-Server solo por TCP/3306 | WEB-Server + FortiGate | Igual que FGT-12 | Igual que FGT-12 | EVID-DB-003, EVID-DB-004 | [`comunicaciones.md`](../05-servidores/comunicaciones.md) | ✅ Implementado |
| SRV-03 | DB-Server: servidor de base de datos | DB-Server | MariaDB, base `labdb`, tabla `users` | `ss -lntp`, `ps aux` | EVID-DB-001, EVID-DB-002 | [`db-server.md`](../05-servidores/db-server.md) | ✅ Implementado |
| SRV-04 | Puerto de política TCP/3306 (DB) | DB-Server + FortiGate | `bind-address 0.0.0.0`, puerto 3306 | `nc` con banner MariaDB | EVID-DB-003 | [`db-server.md`](../05-servidores/db-server.md) | ✅ Implementado |
| USR-01 | Red de Usuarios `/25` | FortiGate | Objeto `RED-Usuarios` 10.6.97.128/25 | — | EVID-FGT-010 | [`vlan10.md`](../06-usuarios/vlan10.md) | ✅ Implementado |
| USR-02 | VLAN 10 | Switch + FortiGate | `vlan 10`; `port2.10` (type vlan, vlanid 10) | `ipconfig` cliente en 10.6.97.130 | EVID-FGT-006, EVID-USR-001 | [`vlan10.md`](../06-usuarios/vlan10.md) | ✅ Implementado |
| USR-03 | DHCP para Usuarios | FortiGate | DHCP server en `port2.10`, rango 10.6.97.130–254 | `ipconfig` cliente (IP asignada) | EVID-FGT-006, EVID-USR-001 | [`dhcp.md`](../06-usuarios/dhcp.md) | ✅ Implementado |

## Leyenda de estado

- ✅ **Implementado**: configuración, prueba y evidencia disponibles y consistentes.
- ⚠️ **Implementado (con observación)**: implementado y verificado, pero el material incluye un detalle no resuelto/aclarado que se documenta explícitamente (ver el documento referenciado).
- ⏳ **Evidencia pendiente**: requisito implementado pero sin evidencia suficiente (no aplica a ningún requisito de esta lista; ver tabla de evidencia faltante en [`../07-pruebas/resultados.md`](../07-pruebas/resultados.md)).

## Nota sobre SW-02

Ver [`../04-switch/seguridad.md`](../04-switch/seguridad.md): la salida `show port-security interface Gi0/1` muestra `Port Security: Disabled` / `Port Status: Secure-down` en el momento de la captura, a pesar de que el running-config incluye el comando `switchport port-security` en esa interfaz. Se documenta como observación sin inventar causa.
