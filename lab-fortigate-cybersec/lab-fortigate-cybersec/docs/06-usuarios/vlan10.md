# Usuarios — VLAN 10 (USR-01, USR-02)

[⬅ Volver al índice principal](../../README.md)

## Red de Usuarios (`/25`) — USR-01

| Campo | Valor |
|---|---|
| Red | 10.6.97.128/25 |
| Máscara | 255.255.255.128 |
| Rango de host | 10.6.97.129 – 10.6.97.254 |
| Gateway | 10.6.97.129 (`port2.10` del FortiGate) |

![EVID-FGT-010 - Objeto de dirección RED-Usuarios](../../evidence/02-fortigate/EVID-FGT-010.png)

*EVID-FGT-010: objeto de dirección `RED-Usuarios` definido como `10.6.97.128/25`, asociado a la interfaz `port2.10`.*

## VLAN 10 — USR-02

| Campo | Valor |
|---|---|
| VLAN ID | 10 |
| Nombre (switch) | `Usuarios` |
| Interfaz FortiGate | `port2.10` (subinterfaz VLAN sobre `port2`) |
| IP de la subinterfaz | 10.6.97.129/255.255.255.128 |

![EVID-FGT-006 - Interfaz port2.10 (VLAN 10)](../../evidence/02-fortigate/EVID-FGT-006.png)

*EVID-FGT-006: la interfaz `port2.10`, de tipo `VLAN`, tiene la IP `10.6.97.129/255.255.255.128`, con accesos administrativos `PING`, `HTTPS`, `SSH` habilitados y `HTTP` deshabilitado, y un rango DHCP asociado de `10.6.97.130` a `10.6.97.254`.*

### Configuración CLI complementaria (FortiGate)

```
config system interface
    edit "port2.10"
        set vdom "root"
        set ip 10.6.97.129 255.255.255.128
        set allowaccess ping https http ssh
        set type vlan
        set vlanid 10
        set interface "port2"
    next
end
```
(Ver [`../../configs/fortigate/interfaces-cli-fortigate.txt`](../../configs/fortigate/interfaces-cli-fortigate.txt).)

> [!NOTE]
> El fragmento CLI provisto indica `set allowaccess ping https http ssh` (HTTP incluido), mientras que la captura de GUI (EVID-FGT-006) muestra HTTP deshabilitado (en rojo) en el momento de la verificación. Esto sugiere que el acceso HTTP fue deshabilitado posteriormente por el administrador tras la configuración inicial por CLI. Se documenta el estado mostrado en la evidencia visual (GUI) como el estado final verificado.

### Configuración VLAN en el switch

Ver [`../04-switch/vlan.md`](../04-switch/vlan.md) para la configuración completa de VLAN 10 en el switch Cisco IOS (`vlan 10`, `name Usuarios`, puertos `Gi0/0` trunk y `Gi0/1` access VLAN 10).

## Evidencia de funcionamiento

![EVID-USR-001 - ipconfig del cliente en VLAN 10](../../evidence/05-usuarios/EVID-USR-001.png)

*EVID-USR-001: el cliente `windows10-1`, conectado al puerto de acceso VLAN 10 del switch, obtiene la IP `10.6.97.130/255.255.255.128` con gateway `10.6.97.129`, confirmando el funcionamiento correcto de VLAN 10 de extremo a extremo.*

## Referencias cruzadas

- Requisitos: **USR-01, USR-02**.
- [`dhcp.md`](dhcp.md), [`../04-switch/vlan.md`](../04-switch/vlan.md).
