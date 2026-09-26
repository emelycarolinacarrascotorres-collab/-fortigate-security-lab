# Matriz de Evidencias

[⬅ Volver al índice principal](../../README.md) · [Matriz de Trazabilidad](matriz-requisitos-evidencias.md)

Cada captura/evidencia entregada tiene un identificador único. Ninguna imagen fue omitida del material recibido.

## Topología (`evidence/01-topologia/`)

| ID Evidencia | Requisito relacionado | Archivo | Descripción | Qué demuestra |
|---|---|---|---|---|
| EVID-TOPO-001 | Topología / Direccionamiento | `EVID-TOPO-001.png` | Tabla de direccionamiento de diseño WEB-Server / DB-Server | Subredes, gateways e IPs de host planificados |
| EVID-TOPO-002 | Topología | `EVID-TOPO-002.png` | Vista GNS3 de enlaces NAT1/web-server-lab-1/windows10-1 | Enlaces físicos entre nodos |
| EVID-TOPO-003 | Topología | `EVID-TOPO-003.png` | Lista completa de nodos y enlaces GNS3 | Topología completa verificada |
| EVID-TOPO-004 | Topología | `EVID-TOPO-004.png` | Diagrama gráfico del canvas GNS3 | Vista visual de la topología desplegada |

## FortiGate (`evidence/02-fortigate/`)

| ID Evidencia | Requisito relacionado | Archivo | Descripción | Qué demuestra |
|---|---|---|---|---|
| EVID-FGT-001 | FGT-01 / USR-02 | `EVID-FGT-001.png` | CLI: `config system interface edit port2` (static, IP VLAN) | Configuración CLI de la interfaz de VLAN |
| EVID-FGT-002 | FGT-01 | `EVID-FGT-002.png` | Tabla de rutas estáticas | Ruta por defecto `0.0.0.0/0` vía `192.168.42.1` |
| EVID-FGT-003 | FGT-01, USR-03 | `EVID-FGT-003.png` | Interfaces físicas port1/port2 | Direccionamiento WAN y estado de port2 |
| EVID-FGT-004 | Topología, SRV-01 | `EVID-FGT-004.png` | Interfaz Web-server (port5) | Gateway de la subred WEB-Server |
| EVID-FGT-005 | Topología, SRV-03 | `EVID-FGT-005.png` | Interfaz Web-BD (port4) | Gateway de la subred DB-Server |
| EVID-FGT-006 | USR-02, USR-03 | `EVID-FGT-006.png` | Interfaz port2.10 (VLAN 10) | IP de gateway VLAN10 y rango DHCP |
| EVID-FGT-007 | USR-03 | `EVID-FGT-007.png` | Pantalla DHCP Server | Configuración de un alcance DHCP (10.6.97.2-14/28) |
| EVID-FGT-008 | FGT-03 | `EVID-FGT-008.png` | Objeto de dirección WEB-Server | Definición 10.6.97.2/32 |
| EVID-FGT-009 | FGT-04 | `EVID-FGT-009.png` | Objeto de dirección DB-Server | Definición 10.6.97.18/32 |
| EVID-FGT-010 | USR-01 | `EVID-FGT-010.png` | Objeto de dirección RED-Usuarios | Definición 10.6.97.128/25 |
| EVID-FGT-011 | FGT-03, FGT-04, FGT-12, FGT-13 | `EVID-FGT-011.png` | Tabla de políticas de firewall | Las 4 políticas internas (Usuarios↔WEB↔DB) |
| EVID-FGT-012 | FGT-02 | `EVID-FGT-012.png` | Edición de política Usuarios-a-Internet | NAT habilitado |
| EVID-FGT-013 | FGT-02, FGT-05 | `EVID-FGT-013.png` | Tabla política Usuarios-a-Internet | NAT Enabled + perfiles SSL/FF |
| EVID-FGT-014 | FGT-05 | `EVID-FGT-014.png` | Perfil SSL/SSH Inspection custom-deep-inspection | Configuración de DPI/SSL Inspection |
| EVID-FGT-015 | FGT-14 | `EVID-FGT-015.png` | Perfil File Filter Bloqueo-EXE | Regla de bloqueo de archivos .exe |
| EVID-FGT-016 | FGT-06, FGT-07, FGT-08 | `EVID-FGT-016.png` | Perfil IPS IPS-Anti-SQLi | Firmas SQLi con acción Quarantine 5 min |
| EVID-FGT-017 | FGT-15 | `EVID-FGT-017.png` | Política DoS-Protection (L3 Anomalies) | Umbrales ip_src_session / ip_dst_session |
| EVID-FGT-018 | FGT-15 | `EVID-FGT-018.png` | Tabla de anomalías L4 | Umbrales tcp_syn_flood, tcp_src_session, etc. |
| EVID-FGT-019 | FGT-15 | `EVID-FGT-019.png` | Fila de política DoS-Protection en tabla | Resumen de la política DoS |

## Logs y eventos (`evidence/07-logs/`)

| ID Evidencia | Requisito relacionado | Archivo | Descripción | Qué demuestra |
|---|---|---|---|---|
| EVID-FGT-020 | FGT-06, FGT-11 | `EVID-FGT-020.png` | Log IPS HTTP.URI.SQL.Injection | Detección de SQLi por firma IPS |
| EVID-FGT-021 | FGT-10, FGT-11 | `EVID-FGT-021.png` | Lista de logs, evento dropped | Registro del bloqueo del ataque |
| EVID-FGT-022 | FGT-14 | `EVID-FGT-022.png` | Detalle de sesión hacia puerto 80 | Sesión asociada al bloqueo de prueba.exe |
| EVID-FGT-023 | FGT-08 | `EVID-FGT-023.png` | Panel de cuarentena | IP 10.6.97.130 baneada por IPS |
| EVID-FGT-024 | FGT-07, FGT-10 | `EVID-FGT-024.png` | Página "Blocked because of an intrusion attack" | Bloqueo efectivo mostrado al atacante |
| EVID-FGT-025 | FGT-14 | `EVID-FGT-025.png` | Log de File Filter | Bloqueo de descarga de prueba.exe |
| EVID-FGT-026 | FGT-15 | `EVID-FGT-026.png` | Log de anomalía tcp_src_session | Umbral de DoS superado (6 > 5) |
| EVID-FGT-027 | FGT-15 | `EVID-FGT-027.png` | Detalle de log DoS (clear_session) | Terminación de sesión por política DoS |
| EVID-FGT-028 | FGT-15 | `EVID-FGT-028.png` | Lista de logs clear_session | Doble evento DoS (tcp_src_session + tcp_syn_flood) |

## Switch (`evidence/03-switch/`)

| ID Evidencia | Requisito relacionado | Archivo | Descripción | Qué demuestra |
|---|---|---|---|---|
| EVID-SW-001 | SW-02 | `EVID-SW-001.png` | Running-config: enable secret / no aaa new-model | Cifrado de credenciales |
| EVID-SW-002 | SW-01 | `EVID-SW-002.png` | Running-config: trunk Gi0/0 | VLAN 1,10 permitidas en el trunk |
| EVID-SW-003 | SW-02 | `EVID-SW-003.png` | Running-config: versión IOS / password-encryption | Hardening general del switch |
| EVID-SW-004 | SW-02 | `EVID-SW-004.webp` | `show port-security interface Gi0/1` | Estado de port-security en el puerto del cliente |

## Servidores (`evidence/04-servidores/`)

| ID Evidencia | Requisito relacionado | Archivo | Descripción | Qué demuestra |
|---|---|---|---|---|
| EVID-WEB-001 | SRV-01 | `EVID-WEB-001.png` | `ip addr` en WEB-Server | IP 10.6.97.2/28 verificada en el propio contenedor |
| EVID-WEB-002 | SRV-02, FGT-12 | `EVID-WEB-002.webp` | Ejecución de `db-test.php` | Conexión aplicativa WEB→DB exitosa |
| EVID-WEB-003 | FGT-14 | `EVID-WEB-003.png` | Página "Attention: file blocked" | Bloqueo de prueba.exe desde el navegador |
| EVID-WEB-004 | FGT-15 | `EVID-WEB-004.png` | Script PowerShell 500 conexiones TCP | Generación de tráfico de prueba DoS |
| EVID-DB-001 | SRV-03 | `EVID-DB-001.webp` | `ss -lntp` en DB-Server | Puerto 3306 en escucha |
| EVID-DB-002 | SRV-03 | `EVID-DB-002.webp` | `ps aux` en DB-Server | Proceso `mariadbd` activo |
| EVID-DB-003 | FGT-12, SRV-04 | `EVID-DB-003.png` | `nc` WEB→DB puerto 3306 | Puerto 3306 abierto (banner MariaDB) |
| EVID-DB-004 | FGT-13 | `EVID-DB-004.png` | `nc` WEB→DB puertos 80/22/443 | Otros puertos cerrados (timeout) |

## Usuarios (`evidence/05-usuarios/`)

| ID Evidencia | Requisito relacionado | Archivo | Descripción | Qué demuestra |
|---|---|---|---|---|
| EVID-USR-001 | USR-02, USR-03 | `EVID-USR-001.png` | `ipconfig` del cliente | IP asignada por DHCP en VLAN10 |
| EVID-USR-002 | SW-01, FGT-01 | `EVID-USR-002.png` | Ping al gateway 10.6.97.129 | Conectividad cliente↔FortiGate |
| EVID-USR-003 | FGT-01, FGT-02 | `EVID-USR-003.png` | Ping a 8.8.8.8 | Conectividad a Internet vía NAT |

## Pruebas (`evidence/06-pruebas/`)

| ID Evidencia | Requisito relacionado | Archivo | Descripción | Qué demuestra |
|---|---|---|---|---|
| EVID-TEST-001 | FGT-03 | `EVID-TEST-001.png` | Test-NetConnection 443 | Política Usuarios→WEB permite HTTPS |
| EVID-TEST-002 | FGT-03 | `EVID-TEST-002.png` | Test-NetConnection 80 | Puerto 80 no autorizado |
| EVID-TEST-003 | FGT-04 | `EVID-TEST-003.png` | Test-NetConnection 3306 | Política Usuarios→DB bloqueada |
| EVID-TEST-004 | FGT-03 | `EVID-TEST-004.png` | Navegador timeout HTTP | Confirmación de bloqueo de puerto 80 |
| EVID-TEST-005 | FGT-06, FGT-09 | `EVID-TEST-005.png` | Historial del navegador con payload SQLi | Payload de prueba generado |

> [!NOTE]
> Se identificaron dos archivos idénticos en el material entregado (la captura de las interfaces físicas `port1`/`port2`, subida dos veces con nombres de archivo distintos en momentos diferentes de la conversación). Solo se conserva una copia como `EVID-FGT-003`, evitando duplicados en el repositorio.
