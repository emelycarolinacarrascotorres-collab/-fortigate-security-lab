# Configuraciones (Running-configs)

Este directorio contiene las configuraciones reales de cada dispositivo, tal como fueron entregadas.

| Archivo | Dispositivo | Contenido |
|---|---|---|
| [`fortigate/interfaces-cli-fortigate.txt`](fortigate/interfaces-cli-fortigate.txt) | FortiGate7.0.9-1 | Fragmento CLI de configuración de interfaces `port2` (static) y `port2.10` (VLAN 10) |
| [`switch/running-config-switch.txt`](switch/running-config-switch.txt) | CiscoIOSvL215.2 (Switch) | Running-config completo: VLAN, trunk, port-security, hardening (SSH-only, banner, no cdp, BPDU guard) |
| [`web-server/`](web-server/) | web-server-lab-1 | *(el script generador del Dockerfile se documenta en `scripts/web-server/build-web-server.sh`, ya que es un script ejecutable, no un running-config estático)* |
| [`db-server/db-server-dockerfile-y-start-script.txt`](db-server/db-server-dockerfile-y-start-script.txt) | db-server-lab-1 | Dockerfile + `start-network.sh` (instalación de MariaDB, creación de `labdb`, usuario `webuser`, asignación de IP) |

> [!NOTE]
> No se recibió un `show full-configuration` exportado del FortiGate. La configuración del FortiGate se documenta a partir de: (a) el fragmento CLI entregado en `fortigate/interfaces-cli-fortigate.txt`, y (b) capturas de pantalla exhaustivas de cada sección relevante de la GUI (ver [`../docs/03-fortigate/`](../docs/03-fortigate/) y [`../evidence/02-fortigate/`](../evidence/02-fortigate/)).
