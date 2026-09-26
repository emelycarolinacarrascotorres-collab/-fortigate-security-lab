# Scripts

Este directorio contiene todos los scripts utilizados en el laboratorio, organizados por sistema/función.

## `web-server/build-web-server.sh`

| Campo | Detalle |
|---|---|
| Propósito | Genera el `Dockerfile` y el script `start-network.sh` del WEB-Server, y construye la imagen Docker `web-server-lab` (Apache2 + PHP + HTTPS + página vulnerable `search.php` + archivo de prueba `test.exe`) |
| Sistema donde se ejecuta | GNS3 VM (host Docker), vía SSH |
| Dependencias | Docker, acceso a repositorios `apt` de Ubuntu 22.04 |
| Forma de ejecución | `bash build-web-server.sh` |
| Resultado esperado | Imagen `web-server-lab` construida y listada por `docker images` |
| Relación con el requisito | SRV-01 (servicio HTTPS), soporte de FGT-06/FGT-07 (página vulnerable a SQLi), FGT-14 (archivo `test.exe`) |

## `db-server/` — `db-server-dockerfile-y-start-script` (ver `configs/db-server/`)

El Dockerfile y el script `start-network.sh` del DB-Server se documentan como configuración en [`../configs/db-server/db-server-dockerfile-y-start-script.txt`](../configs/db-server/db-server-dockerfile-y-start-script.txt), ya que definen tanto la instalación del servicio (MariaDB) como el arranque de red del contenedor. Ver también [`../docs/05-servidores/db-server.md`](../docs/05-servidores/db-server.md).

## `testing/pruebas-conectividad-tcp.sh`

| Campo | Detalle |
|---|---|
| Propósito | Verificar mediante `nc` la apertura/cierre de puertos TCP específicos: 3306 hacia DB-Server (debe estar abierto), 443 hacia 8.8.8.8/Internet (debe estar cerrado) y 80 hacia la red de Usuarios (debe estar cerrado) |
| Sistema donde se ejecuta | WEB-Server (`web-server-lab-1`) |
| Dependencias | `netcat` (`nc`) |
| Forma de ejecución | `bash pruebas-conectividad-tcp.sh` (o cada comando de forma individual) |
| Resultado esperado | Ver salida de ✅/❌ impresa por el propio script |
| Relación con el requisito | FGT-12, FGT-13, SRV-02, SRV-04 |

Ver ejecución real de comandos equivalentes (con el mismo propósito) documentada en [`../docs/05-servidores/comunicaciones.md`](../docs/05-servidores/comunicaciones.md), con evidencia `EVID-DB-003` y `EVID-DB-004`.

## `utilities/`

Sin scripts adicionales provistos en el material disponible para esta subcarpeta. **Reservada para uso futuro.**
