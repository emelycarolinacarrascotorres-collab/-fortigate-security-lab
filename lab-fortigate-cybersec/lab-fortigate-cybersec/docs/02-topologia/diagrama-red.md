# Diagramas de Flujo de Tráfico

[⬅ Volver al índice principal](../../README.md)

Estos diagramas se derivan directamente de las políticas de firewall documentadas en [`03-fortigate/`](../03-fortigate/) y de la evidencia de pruebas en [`07-pruebas/`](../07-pruebas/). No se añade ningún salto o control que no esté respaldado por una política o evidencia real.

## 1. Diagrama lógico de segmentación

```mermaid
flowchart TB
    INET((Internet / NAT1))
    subgraph FGT[FortiGate7.0.9-1]
        P1[Port1 - WAN]
        P2[Port2 / Port2.10 - VLAN10]
        P4[Port4 - Web-BD]
        P5[Port5 - Web-server]
    end
    subgraph USR[Red Usuarios 10.6.97.128/25 - VLAN10]
        WIN[windows10-1 - 10.6.97.130 DHCP]
    end
    subgraph WEBSEG[Red WEB-Server 10.6.97.0/28]
        WEB[web-server-lab-1 - 10.6.97.2]
    end
    subgraph DBSEG[Red DB-Server 10.6.97.16/28]
        DB[db-server-lab-1 - 10.6.97.18]
    end

    INET <--> P1
    P1 <--> P2
    P2 <--> USR
    P2 <--> P5
    P5 <--> WEBSEG
    P5 <--> P4
    P4 <--> DBSEG
```

## 2. Flujo Usuarios → WEB-Server (Política `USUARIOS-a-WEB`)

```mermaid
sequenceDiagram
    participant U as Usuario (10.6.97.130)
    participant FGT as FortiGate (port2.10 -> port5)
    participant W as WEB-Server (10.6.97.2:443)
    U->>FGT: HTTPS (TCP/443)
    FGT->>FGT: SSL Inspection (custom-deep-inspection)
    FGT->>FGT: IPS-Anti-SQLi + File Filter Bloqueo-EXE
    FGT->>W: Tráfico permitido (ACCEPT)
    W-->>U: Respuesta HTTPS
```
Evidencia de esta política: [`politica-usuarios-web.md`](../03-fortigate/politica-usuarios-web.md).

## 3. Flujo WEB-Server → DB-Server (Política `WEB-a-DB-3306`)

```mermaid
sequenceDiagram
    participant W as WEB-Server (10.6.97.2)
    participant FGT as FortiGate (port5 -> port4)
    participant D as DB-Server (10.6.97.18:3306)
    W->>FGT: TCP/3306 (MySQL)
    FGT->>D: ACCEPT (único servicio permitido)
    Note over W,D: Cualquier otro puerto/servicio de W hacia D no está permitido por esta política (ver comunicaciones.md)
```
Evidencia: [`comunicaciones.md`](../05-servidores/comunicaciones.md).

## 4. Flujo de ataque SQL Injection y bloqueo

```mermaid
flowchart LR
    A[Atacante / Cliente 10.6.97.130] -->|Payload SQLi vía HTTP/HTTPS| FGT[FortiGate]
    FGT -->|SSL Inspection descifra| INSP[Inspección de contenido]
    INSP -->|Firma IPS-Anti-SQLi coincide| DET[Detección SQL Injection]
    DET -->|Acción: Quarantine| BLK[Bloqueo de la sesión]
    BLK --> LOG[Registro en logs UTM/IPS]
    BLK --> QUAR[IP del atacante en cuarentena]
```
Evidencia: [`sql-injection.md`](../03-fortigate/sql-injection.md) y [`cuarentena.md`](../03-fortigate/cuarentena.md).

## 5. Flujo de bloqueo de descarga `.exe`

```mermaid
flowchart LR
    U[Usuario] -->|GET /prueba.exe HTTP| FGT[FortiGate - Política USUARIOS-a-WEB]
    FGT -->|Perfil File Filter Bloqueo-EXE| CHK{Extensión .exe?}
    CHK -->|Sí| BLOCK[Bloqueado - Attention page]
    CHK -->|No| PASS[Permitido]
```
Evidencia: [`filtrado-exe.md`](../03-fortigate/filtrado-exe.md).

> [!NOTE]
> No se incluyen diagramas adicionales (por ejemplo, un diagrama físico de racks o cableado) porque el material proporcionado no contiene esa información y no debe inventarse.
