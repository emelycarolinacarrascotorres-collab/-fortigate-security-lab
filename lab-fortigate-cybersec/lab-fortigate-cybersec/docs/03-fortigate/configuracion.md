# FortiGate — Configuración General

[⬅ Volver al índice principal](../../README.md)

Toda la configuración y demostración del FortiGate se realizó mediante **GUI**, tal como exige la asignación. Este documento es el índice de la sección FortiGate; cada funcionalidad tiene su propio documento detallado.

## Índice de esta sección

| Funcionalidad | Requisito | Documento |
|---|---|---|
| Ruta por defecto | FGT-01 | [`ruta-default.md`](ruta-default.md) |
| NAT | FGT-02 | [`nat.md`](nat.md) |
| Política Usuarios → WEB-Server | FGT-03 | [`politica-usuarios-web.md`](politica-usuarios-web.md) |
| Política Usuarios → DB-Server (bloqueo) | FGT-04 | [`politica-usuarios-db.md`](politica-usuarios-db.md) |
| DPI / SSL Inspection | FGT-05 | [`dpi.md`](dpi.md) |
| Detección y bloqueo de SQL Injection | FGT-06, FGT-07, FGT-09, FGT-10, FGT-11 | [`sql-injection.md`](sql-injection.md) |
| Cuarentena del atacante | FGT-08 | [`cuarentena.md`](cuarentena.md) |
| Filtrado de archivos `.exe` | FGT-14 | [`filtrado-exe.md`](filtrado-exe.md) |
| Rate limiting / mitigación DoS | FGT-15 | [`rate-limiting.md`](rate-limiting.md) |

La comunicación restringida WEB-Server ↔ DB-Server (FGT-12, FGT-13) se documenta en [`../05-servidores/comunicaciones.md`](../05-servidores/comunicaciones.md), ya que involucra tanto la configuración del FortiGate como la de ambos servidores.

## Objetos de dirección (Firewall Address) configurados

| Objeto | Rango/Subred | Evidencia |
|---|---|---|
| `WEB-Server` | 10.6.97.2/32 | [`EVID-FGT-008`](../../evidence/02-fortigate/EVID-FGT-008.png) |
| `DB-Server` | 10.6.97.18/32 | [`EVID-FGT-009`](../../evidence/02-fortigate/EVID-FGT-009.png) |
| `RED-Usuarios` | 10.6.97.128/25 | [`EVID-FGT-010`](../../evidence/02-fortigate/EVID-FGT-010.png) |

![EVID-FGT-008 - Objeto de dirección WEB-Server](../../evidence/02-fortigate/EVID-FGT-008.png)

*EVID-FGT-008: objeto de dirección `WEB-Server` definido como host único `10.6.97.2/32`, usado como destino en la política `USUARIOS-a-WEB` y como origen en `WEB-a-DB-3306`.*

![EVID-FGT-009 - Objeto de dirección DB-Server](../../evidence/02-fortigate/EVID-FGT-009.png)

*EVID-FGT-009: objeto de dirección `DB-Server` definido como host único `10.6.97.18/32`, usado como destino en `BLOQUEO-Usuarios-a-DB` y en `WEB-a-DB-3306`.*

![EVID-FGT-010 - Objeto de dirección RED-Usuarios](../../evidence/02-fortigate/EVID-FGT-010.png)

*EVID-FGT-010: objeto de dirección `RED-Usuarios` definido como subred `10.6.97.128/25`, asociado a la interfaz `port2.10`, usado como origen en todas las políticas que involucran a la red de Usuarios.*

## Tabla completa de políticas de firewall (Policy & Objects)

![EVID-FGT-011 - Tabla de políticas de firewall](../../evidence/02-fortigate/EVID-FGT-011.png)

*EVID-FGT-011 es la vista consolidada de políticas del FortiGate, agrupadas por par de interfaces. Se leen, en orden:*

| # | Nombre | Entrada → Salida | Origen | Destino | Servicio | Acción | NAT | Perfiles | Bytes |
|---|---|---|---|---|---|---|---|---|---|
| 1 | `BLOQUEO-Usuarios-a-DB` | port2.10 → Web-BD (port4) | RED-Usuarios | DB-Server | MySQL-3306 | **DENY** | — | — | 0 B |
| 2 | `USUARIOS-a-WEB` | port2.10 → Web-server (port5) | RED-Usuarios | WEB-Server | HTTPS-443 | **ACCEPT** | Disabled | APP:default, IPS:IPS-Anti-SQLi, SSL:custom-deep-inspection, FF:Bloqueo-EXE | 59.33 kB |
| 3 | `BLOQUEO-WEB-Todo-Demas` | Web-server (port5) → port2.10 | WEB-Server | all | ALL | **DENY** | — | — | 0 B |
| 4 | `WEB-a-DB-3306` | Web-server (port5) → Web-BD (port4) | WEB-Server | DB-Server | MySQL-3306 | **ACCEPT** | Disabled | SSL:no-inspection | 4.62 kB |

Adicionalmente, la política `Usuarios-a-Internet` (port2.10 → port1) y la política `DoS-Protection` (port2.10, tipo *DoS IPv4*) se documentan en [`nat.md`](nat.md) y [`rate-limiting.md`](rate-limiting.md) respectivamente.

> [!NOTE]
> El campo **NAT** en `USUARIOS-a-WEB` y `WEB-a-DB-3306` aparece como *Disabled* porque se trata de tráfico interno entre subredes directamente conectadas al FortiGate; el NAT solo se habilita en la política de salida a Internet (`Usuarios-a-Internet`).
