# Laboratorio de Ciberseguridad con FortiGate — Segmentación, Control de Acceso e Inspección de Tráfico

![Firewall](https://img.shields.io/badge/Firewall-FortiGate%207.0.9-red) ![Switch](https://img.shields.io/badge/Switch-Cisco%20IOS%2015.2-blue) ![IPS](https://img.shields.io/badge/IPS-SQL%20Injection-critical) ![Estado](https://img.shields.io/badge/Estado-Laboratorio%20Completo-success)

> Laboratorio académico de ciberseguridad de red: segmentación, control de acceso, inspección profunda de paquetes (DPI/SSL Inspection), prevención de intrusos (IPS) y mitigación de DoS, implementado íntegramente con FortiGate 7.0.9 sobre GNS3.

---

## 🎥 Video demostrativo

[(https://www.youtube.com/watch?v=7HyGDk8jk1o]

> Cuando esté disponible, colocar el enlace aquí y/o el archivo en [`video/`](video/). Ver instrucciones en [`video/README.md`](video/README.md).

---

## 📑 Índice

- [Descripción](#-descripción)
- [Objetivo](#-objetivo)
- [Alcance](#-alcance)
- [Tecnologías utilizadas](#-tecnologías-utilizadas)
- [Arquitectura general](#-arquitectura-general)
- [Topología](#-topología)
- [Componentes](#-componentes)
- [Segmentación de red](#-segmentación-de-red)
- [Controles de seguridad implementados](#-controles-de-seguridad-implementados)
- [Tabla resumen de requisitos](#-tabla-resumen-de-requisitos)
- [Navegación de la documentación](#-navegación-de-la-documentación)
- [Resultados](#-resultados)
- [Conclusiones](#-conclusiones)
- [Referencias](#-referencias)

---

## 📖 Descripción

Este repositorio documenta, con trazabilidad completa **requisito → configuración → prueba → evidencia**, un laboratorio de red segmentada protegida por un firewall FortiGate. La red separa tres zonas de confianza (Usuarios, WEB-Server, DB-Server) y demuestra activamente, con tráfico de prueba real, la efectividad de cada control: políticas de firewall, DPI/SSL Inspection, IPS contra SQL Injection con cuarentena automática, filtrado de descargas ejecutables y mitigación de DoS.

## 🎯 Objetivo

Ver el detalle completo en [`docs/01-introduccion/objetivo.md`](docs/01-introduccion/objetivo.md).

## 🗂️ Alcance

Ver el detalle completo, incluyendo lo que **no** está cubierto por el material disponible, en [`docs/01-introduccion/alcance.md`](docs/01-introduccion/alcance.md).

## 🧰 Tecnologías utilizadas

| Categoría | Tecnología |
|---|---|
| Firewall / NGFW | FortiGate VM64-KVM 7.0.9 |
| Switch | Cisco IOS (versión 15.2) |
| Virtualización de red | GNS3 |
| Contenedores | Docker |
| Servidor web | Ubuntu 22.04 + Apache2 + PHP (mysqli) + OpenSSL |
| Base de datos | MariaDB (10.6.23) sobre Ubuntu 22.04 |
| Cliente | Windows 10 |
| Lenguajes/scripts | Bash, PHP, PowerShell |

## 🏗️ Arquitectura general

Ver detalle completo en [`docs/01-introduccion/arquitectura.md`](docs/01-introduccion/arquitectura.md).

## 🌐 Topología

Ver detalle completo, incluyendo capturas de GNS3, en [`docs/02-topologia/topologia.md`](docs/02-topologia/topologia.md) y diagramas de flujo en [`docs/02-topologia/diagrama-red.md`](docs/02-topologia/diagrama-red.md).

```
Internet (NAT1) ── port1 ── FortiGate7.0.9-1 ── port2/port2.10 (VLAN10) ── Switch ── windows10-1 (Usuarios)
                                 │
                                 ├── port5 (Web-server) ── web-server-lab-1 (10.6.97.2/28)
                                 └── port4 (Web-BD)      ── db-server-lab-1  (10.6.97.18/28)
```

## 🧩 Componentes

| Componente | Rol |
|---|---|
| FortiGate7.0.9-1 | Firewall central, NAT, políticas, IPS, SSL Inspection, File Filter, DoS Policy |
| CiscoIOSvL215.2 | Switch: VLAN 10, trunk, port-security |
| web-server-lab-1 | Servidor web HTTPS con página vulnerable a SQLi (uso controlado de laboratorio) |
| db-server-lab-1 | Servidor MariaDB (`labdb`) |
| windows10-1 | Cliente de la red de Usuarios (VLAN 10, DHCP) |
| NAT1 | Salida a Internet (nube GNS3) |

## 🧱 Segmentación de red

| Segmento | Red | VLAN | Gateway |
|---|---|---|---|
| Usuarios | 10.6.97.128/25 | VLAN 10 | 10.6.97.129 |
| WEB-Server | 10.6.97.0/28 | — | 10.6.97.1 |
| DB-Server | 10.6.97.16/28 | — | 10.6.97.17 |

Detalle completo en [`docs/02-topologia/segmentacion.md`](docs/02-topologia/segmentacion.md) y [`docs/02-topologia/direccionamiento.md`](docs/02-topologia/direccionamiento.md).

## 🛡️ Controles de seguridad implementados

- ✅ Ruta por defecto y NAT de salida a Internet.
- ✅ Política de firewall: Usuarios → WEB-Server (solo HTTPS/443).
- ✅ Política de firewall: bloqueo de Usuarios → DB-Server (TCP/3306).
- ✅ Restricción WEB-Server → DB-Server a únicamente TCP/3306.
- ✅ DPI / SSL Inspection sobre el tráfico HTTPS hacia WEB-Server.
- ✅ IPS con firmas de SQL Injection, acción de bloqueo + cuarentena (5 min).
- ✅ Filtrado de aplicaciones: bloqueo de descargas `.exe`.
- ✅ Política DoS (anomalías L3/L4) para mitigar floods/escaneos.
- ✅ VLAN 10 + DHCP para la red de Usuarios.
- ✅ Seguridad básica de switch: cifrado de contraseñas, SSH-only, BPDU Guard, CDP deshabilitado, port-security.

## ✅ Tabla resumen de requisitos

| Bloque | Requisitos | Estado |
|---|---|---|
| FortiGate | FGT-01 a FGT-15 (15 requisitos) | ✅ 15/15 implementados y verificados |
| Switch | SW-01, SW-02 | ✅ 2/2 implementados (1 con observación menor, ver nota) |
| Servidores | SRV-01 a SRV-04 | ✅ 4/4 implementados y verificados |
| Usuarios | USR-01 a USR-03 | ✅ 3/3 implementados y verificados |
| **Total** | **24 requisitos** | **✅ 24/24** |

> [!NOTE]
> "Implementado" significa que existe configuración, prueba activa y evidencia. Ver el detalle exacto, incluyendo la observación menor de `SW-02`, en la [Matriz de Trazabilidad](docs/08-trazabilidad/matriz-requisitos-evidencias.md).

## 🧭 Navegación de la documentación

### Introducción
- [Objetivo](docs/01-introduccion/objetivo.md) · [Alcance](docs/01-introduccion/alcance.md) · [Requisitos](docs/01-introduccion/requisitos.md) · [Arquitectura](docs/01-introduccion/arquitectura.md)

### Topología
- [Topología](docs/02-topologia/topologia.md) · [Diagramas de flujo](docs/02-topologia/diagrama-red.md) · [Direccionamiento](docs/02-topologia/direccionamiento.md) · [Segmentación](docs/02-topologia/segmentacion.md)

### FortiGate
- [Configuración general](docs/03-fortigate/configuracion.md) · [Ruta por defecto](docs/03-fortigate/ruta-default.md) · [NAT](docs/03-fortigate/nat.md) · [Política Usuarios→WEB](docs/03-fortigate/politica-usuarios-web.md) · [Política Usuarios→DB](docs/03-fortigate/politica-usuarios-db.md) · [DPI](docs/03-fortigate/dpi.md) · [SQL Injection](docs/03-fortigate/sql-injection.md) · [Cuarentena](docs/03-fortigate/cuarentena.md) · [Filtrado .exe](docs/03-fortigate/filtrado-exe.md) · [Rate limiting](docs/03-fortigate/rate-limiting.md)

### Switch
- [VLAN](docs/04-switch/vlan.md) · [Seguridad básica](docs/04-switch/seguridad.md)

### Servidores
- [WEB-Server](docs/05-servidores/web-server.md) · [DB-Server](docs/05-servidores/db-server.md) · [Comunicaciones WEB↔DB](docs/05-servidores/comunicaciones.md)

### Usuarios
- [VLAN 10](docs/06-usuarios/vlan10.md) · [DHCP](docs/06-usuarios/dhcp.md)

### Pruebas
- [Conectividad](docs/07-pruebas/pruebas-conectividad.md) · [Políticas](docs/07-pruebas/pruebas-politicas.md) · [SQL Injection](docs/07-pruebas/prueba-sql-injection.md) · [Filtrado .exe](docs/07-pruebas/prueba-filtrado-exe.md) · [Rate limit](docs/07-pruebas/prueba-rate-limit.md) · [Resultados](docs/07-pruebas/resultados.md)

### Trazabilidad
- [Matriz de Trazabilidad (Requisito→Evidencia)](docs/08-trazabilidad/matriz-requisitos-evidencias.md) · [Matriz de Evidencias](docs/08-trazabilidad/matriz-evidencias.md)

### Referencias
- [Referencias](docs/09-referencias/referencias.md)

### Otros directorios del repositorio
- [`evidence/`](evidence/) — todas las capturas y evidencias, organizadas por categoría.
- [`configs/`](configs/) — running-configs reales del FortiGate, switch y servidores.
- [`scripts/`](scripts/) — scripts de construcción de servidores y de pruebas.
- [`diagrams/`](diagrams/) — índice de diagramas (embebidos en Markdown/Mermaid).
- [`video/`](video/) — video demostrativo (pendiente).

## 📊 Resultados

Ver el resumen completo de todas las pruebas ejecutadas, con su resultado y evidencia, en [`docs/07-pruebas/resultados.md`](docs/07-pruebas/resultados.md).

## 🏁 Conclusiones

El laboratorio demuestra, con evidencia verificable, que una arquitectura de red segmentada y mediada íntegramente por un firewall de nueva generación puede:

1. Restringir el tráfico entre zonas de confianza a exactamente lo necesario (principio de mínimo privilegio) — verificado con pruebas activas de bloqueo y permiso en ambos sentidos.
2. Detectar y contener automáticamente un ataque de aplicación (SQL Injection) sin depender de que la aplicación web valide correctamente sus propias entradas, incluyendo la respuesta de cuarentena del atacante.
3. Prevenir la exfiltración de herramientas maliciosas mediante filtrado de contenido (`.exe`).
4. Mitigar patrones de tráfico anómalos característicos de un ataque de denegación de servicio, terminando activamente las sesiones ofensoras.
5. Aplicar controles de higiene básica también en la capa de switching (VLAN, port-security, hardening de gestión), reforzando la defensa en profundidad de extremo a extremo.

Todos los 24 requisitos de la asignación cuentan con configuración, prueba y evidencia documentadas y trazables (ver [Matriz de Trazabilidad](docs/08-trazabilidad/matriz-requisitos-evidencias.md)), con únicamente dos observaciones menores señaladas explícitamente donde el material no permitía una confirmación al 100% (ver [`docs/01-introduccion/alcance.md`](docs/01-introduccion/alcance.md) y [`docs/04-switch/seguridad.md`](docs/04-switch/seguridad.md)).

## 📚 Referencias

Ver [`docs/09-referencias/referencias.md`](docs/09-referencias/referencias.md).

---

## ✅ Checklist final de auditoría

- [x] Video al inicio del README (pendiente de enlace real, marcador presente).
- [x] Propósito documentado.
- [x] Alcance documentado.
- [x] Topología documentada.
- [x] FortiGate documentado (10 documentos, uno por funcionalidad).
- [x] Ruta por defecto documentada.
- [x] NAT documentado.
- [x] Política 1 documentada.
- [x] Política 2 documentada.
- [x] DPI documentado.
- [x] SQL Injection documentado.
- [x] Bloqueo documentado.
- [x] Cuarentena documentada.
- [x] Logs documentados.
- [x] Filtrado `.exe` documentado.
- [x] Rate limiting documentado.
- [x] Switch documentado.
- [x] VLAN documentada.
- [x] Seguridad básica documentada.
- [x] Servidores documentados.
- [x] Red `/28` documentada.
- [x] Red `/25` documentada.
- [x] VLAN 10 documentada.
- [x] DHCP documentado.
- [x] Pruebas documentadas.
- [x] Resultados documentados.
- [x] Running-configs incluidos.
- [x] Scripts incluidos y documentados.
- [x] Imágenes integradas en el punto exacto donde demuestran cada requisito (no al final).
- [x] Diagramas incluidos (Mermaid, embebidos en la documentación).
- [x] Matriz de trazabilidad completa (24/24 requisitos).
- [x] Matriz de evidencias completa (52 evidencias con ID único).
- [x] Referencias cruzadas entre documentos.

---

*Documentación generada a partir del material real del laboratorio, sin datos inventados. Cualquier dato o evidencia no disponible se señala explícitamente en el documento correspondiente.*
