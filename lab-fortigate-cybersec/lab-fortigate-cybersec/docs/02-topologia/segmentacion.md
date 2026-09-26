# Segmentación de Red

[⬅ Volver al índice principal](../../README.md)

## Concepto

La segmentación consiste en dividir la red en zonas con distinto nivel de confianza, de manera que el tráfico entre zonas **siempre** deba atravesar el firewall y quedar sujeto a una política explícita, en lugar de fluir libremente como ocurriría en una red plana.

## Segmentos implementados

| Segmento | Red | Nivel de confianza | Justificación |
|---|---|---|---|
| Usuarios (VLAN 10) | 10.6.97.128/25 | Bajo/medio (equipos cliente) | Es el origen habitual de accesos legítimos, pero también el vector más probable de un usuario comprometido o de un atacante interno; requiere salida controlada a Internet y acceso restringido solo a WEB-Server. |
| WEB-Server | 10.6.97.0/28 | Medio (expuesto a Usuarios) | Recibe tráfico HTTPS desde Usuarios; por ser una aplicación web (con una página de prueba intencionalmente vulnerable a SQLi), es el segmento con mayor probabilidad de ataque y el que requiere DPI/IPS. |
| DB-Server | 10.6.97.16/28 | Alto (dato sensible) | Contiene la base de datos (`labdb`) con la información de la aplicación; solo debe ser alcanzable por el WEB-Server y únicamente por el puerto de servicio TCP/3306. |

## Por qué se separan Usuarios, WEB-Server y DB-Server

- **Usuarios vs. WEB-Server**: si Usuarios pudiera llegar directamente a la base de datos, un usuario comprometido podría intentar explotar el motor de base de datos directamente, sin pasar por la lógica de aplicación ni por la inspección DPI. La política `BLOQUEO-Usuarios-a-DB` (ver [`politica-usuarios-db.md`](../03-fortigate/politica-usuarios-db.md)) impide esto explícitamente.
- **WEB-Server vs. DB-Server**: el WEB-Server es el único componente autorizado a hablar con la base de datos, y solo por TCP/3306 (política `WEB-a-DB-3306`, ver [`comunicaciones.md`](../05-servidores/comunicaciones.md)). Esto limita el "blast radius" si el servidor web resultase comprometido (por ejemplo, vía la vulnerabilidad SQLi intencional de `search.php`).
- **Reverso WEB-Server → Usuarios**: la política `BLOQUEO-WEB-Todo-Demas` (ver [`f61c5704` / `EVID-FGT-011`](../../evidence/02-fortigate/EVID-FGT-011.png)) deniega explícitamente cualquier tráfico iniciado por el WEB-Server hacia `all` a través de `port2.10`, reforzando que el servidor web no debe iniciar conexiones hacia la red de Usuarios.

## Amenazas que se pretenden controlar

Con base estrictamente en los requisitos y controles implementados (sin agregar amenazas no solicitadas):

- Acceso no autorizado de Usuarios a la base de datos.
- Explotación de SQL Injection contra la aplicación web.
- Descarga de archivos ejecutables potencialmente maliciosos desde el servidor web.
- Ataques de denegación de servicio (escaneos de puertos, floods TCP/UDP) contra el servidor web.
- Acceso no controlado del servidor web a servicios del DB-Server distintos de MySQL/MariaDB (3306).
