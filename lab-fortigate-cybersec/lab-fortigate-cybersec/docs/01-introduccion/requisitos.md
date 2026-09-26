# Requisitos de la Asignación

[⬅ Volver al índice principal](../../README.md)

Este documento lista **todos** los requisitos originales de la asignación, sin omitir ni agrupar ninguno, tal como fueron proporcionados. Cada uno tiene un identificador único que se utiliza en toda la documentación y en la [Matriz de Trazabilidad](../08-trazabilidad/matriz-requisitos-evidencias.md).

## FortiGate (GUI)

| ID | Requisito |
|----|-----------|
| FGT-01 | Configurar ruta por defecto. |
| FGT-02 | Configurar NAT. |
| FGT-03 | Política 1: permitir tráfico de Usuarios hacia WEB-Server por HTTPS/443. |
| FGT-04 | Política 2: bloquear tráfico de Usuarios hacia DB-Server por TCP/3306. |
| FGT-05 | Activar DPI (Deep Packet Inspection). |
| FGT-06 | Crear una regla para detectar intentos de SQL Injection contra WEB-Server. |
| FGT-07 | Bloquear los intentos de SQL Injection. |
| FGT-08 | Colocar al atacante en cuarentena. |
| FGT-09 | Generar tráfico/payloads de prueba para demostrar el bloqueo. |
| FGT-10 | Demostrar que FortiGate bloquea los intentos. |
| FGT-11 | Demostrar que FortiGate genera logs de los eventos. |
| FGT-12 | WEB-Server únicamente puede comunicarse con DB-Server mediante TCP/3306. |
| FGT-13 | WEB-Server no debe tener comunicación con otros servicios del DB-Server. |
| FGT-14 | Implementar filtrado de aplicaciones para bloquear descargas de archivos `.exe` desde la web. |
| FGT-15 | Implementar rate limiting para mitigar/evitar DoS. |

## Switch

| ID | Requisito |
|----|-----------|
| SW-01 | Configurar VLAN. |
| SW-02 | Configurar seguridad básica de redes. |

## Servidores (red `/28`)

| ID | Requisito |
|----|-----------|
| SRV-01 | WEB-Server: servicio HTTPS. |
| SRV-02 | WEB-Server: debe comunicarse con DB-Server únicamente mediante TCP/3306. |
| SRV-03 | DB-Server: servidor de base de datos. |
| SRV-04 | DB-Server: puerto involucrado en la política es TCP/3306. |

## Usuarios (red `/25`)

| ID | Requisito |
|----|-----------|
| USR-01 | Red de Usuarios en `/25`. |
| USR-02 | VLAN 10 para Usuarios. |
| USR-03 | DHCP para Usuarios. |

> [!NOTE]
> Ningún requisito fue simplificado, eliminado por parecer repetido, ni agrupado con otro. Cada ID aparece de forma explícita en su documento correspondiente y en la matriz de trazabilidad.
