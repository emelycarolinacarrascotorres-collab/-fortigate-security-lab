# Arquitectura General

[⬅ Volver al índice principal](../../README.md)

## Concepto

La arquitectura sigue un modelo de **defensa en profundidad** con segmentación de red de tres zonas (Usuarios, WEB-Server, DB-Server), todas mediadas por un firewall FortiGate que actúa como único punto de control entre segmentos y hacia Internet.

```
                         ┌───────────────┐
                         │     NAT1      │  (nube de Internet / GNS3)
                         └───────┬───────┘
                                 │ port1 (WAN) 192.168.42.206/24
                         ┌───────┴───────┐
                         │  FortiGate    │
                         │ 7.0.9-1       │
                         │               │
        Port4 (10.6.97.17/28) ──┬── Port5 (10.6.97.1/28) ──┬── Port2 (VLAN trunk)
                                 │                          │
                        ┌────────┴────────┐        ┌────────┴────────┐
                        │   DB-Server     │        │   WEB-Server    │
                        │ 10.6.97.18/28   │        │ 10.6.97.2/28    │
                        └─────────────────┘        └─────────────────┘
                                                             │
                                                     ┌───────┴────────┐
                                                     │  Switch Cisco  │
                                                     │  Gi0/0 trunk   │
                                                     └───────┬────────┘
                                                             │ Gi0/1 access VLAN10
                                                     ┌───────┴────────┐
                                                     │  windows10-1   │
                                                     │ 10.6.97.130/25 │
                                                     │  (DHCP)        │
                                                     └────────────────┘
```

Ver el diagrama detallado (capturas de GNS3) en [`docs/02-topologia/topologia.md`](../02-topologia/topologia.md).

## Componentes

| Componente | Rol | Referencia |
|---|---|---|
| **FortiGate7.0.9-1** | Firewall central: enrutamiento, NAT, políticas, IPS, SSL Inspection, File Filter, DoS Policy | [`03-fortigate/configuracion.md`](../03-fortigate/configuracion.md) |
| **CiscoIOSvL215.2** (Switch) | Conmutación de capa 2, VLAN 10, trunk hacia FortiGate, port-security hacia el cliente | [`04-switch/vlan.md`](../04-switch/vlan.md) |
| **web-server-lab-1** | Contenedor Ubuntu 22.04 + Apache2 + PHP + mysqli, HTTPS habilitado, página vulnerable `search.php` para pruebas de SQLi | [`05-servidores/web-server.md`](../05-servidores/web-server.md) |
| **db-server-lab-1** | Contenedor Ubuntu 22.04 + MariaDB, base `labdb`, usuario `webuser` | [`05-servidores/db-server.md`](../05-servidores/db-server.md) |
| **windows10-1** | Cliente de la red de Usuarios (VLAN 10), obtiene IP por DHCP | [`06-usuarios/dhcp.md`](../06-usuarios/dhcp.md) |
| **NAT1** | Nube de salida a Internet de GNS3, conectada a port1 del FortiGate | [`03-fortigate/nat.md`](../03-fortigate/nat.md) |

## Por qué este diseño

- **Segmentación**: separar Usuarios, WEB-Server y DB-Server en subredes distintas conectadas a interfaces físicas/lógicas distintas del FortiGate permite aplicar políticas de firewall independientes por segmento, en lugar de depender únicamente de reglas en los propios servidores.
- **FortiGate como único punto de control**: todo el tráfico entre segmentos atraviesa el FortiGate, lo que permite inspección (DPI/IPS/SSL Inspection) y registro centralizado (logs) de cualquier intento de acceso no autorizado.
- **VLAN 10 para Usuarios**: aísla el tráfico de los equipos cliente a nivel de capa 2 desde el switch, entregando ese tráfico al FortiGate a través de un enlace troncal (802.1Q) hacia la subinterfaz `port2.10`.
- **Restricción WEB → DB a solo 3306**: el servidor web es el componente con mayor superficie de exposición (recibe tráfico externo/de Usuarios); limitar su salida hacia la base de datos a un único puerto reduce el impacto de un compromiso del WEB-Server sobre el DB-Server.
