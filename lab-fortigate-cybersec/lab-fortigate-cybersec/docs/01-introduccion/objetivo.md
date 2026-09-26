# Objetivo del Laboratorio

[⬅ Volver al índice principal](../../README.md)

## Objetivo general

Implementar y validar, en un entorno de laboratorio virtualizado sobre **GNS3**, una arquitectura de red segmentada y protegida por un firewall de nueva generación **FortiGate**, que permita:

- Segmentar la red en zonas de confianza diferenciadas (Usuarios, WEB-Server, DB-Server).
- Controlar el acceso entre segmentos mediante políticas de firewall explícitas.
- Inspeccionar el tráfico en profundidad (DPI/SSL Inspection) para detectar y bloquear ataques de aplicación, específicamente **SQL Injection**.
- Poner en cuarentena automáticamente a un atacante detectado por el sistema de prevención de intrusos (IPS).
- Restringir la comunicación entre el servidor web y el servidor de base de datos exclusivamente al puerto de servicio de la base de datos (TCP/3306).
- Filtrar la descarga de archivos ejecutables (`.exe`) desde el servidor web.
- Mitigar ataques de denegación de servicio (DoS) mediante políticas de control de anomalías.
- Aplicar controles de seguridad básicos a nivel de switch (VLAN, port-security).

Todo esto se documenta con **trazabilidad completa**: cada requisito de la asignación queda vinculado a su configuración, su prueba de verificación y su evidencia (ver [Matriz de Trazabilidad](../08-trazabilidad/matriz-requisitos-evidencias.md)).

## Objetivos específicos

1. Configurar el FortiGate como firewall perimetral e interno, administrado íntegramente por **GUI**.
2. Establecer una ruta por defecto y NAT hacia Internet para la red de Usuarios.
3. Crear políticas de firewall que:
   - Permitan tráfico HTTPS (443) desde Usuarios hacia WEB-Server.
   - Bloqueen el tráfico hacia DB-Server (3306) desde Usuarios.
   - Permitan únicamente TCP/3306 entre WEB-Server y DB-Server.
4. Activar inspección profunda de paquetes (DPI) y SSL/SSH Inspection sobre el tráfico HTTPS hacia WEB-Server.
5. Configurar un perfil IPS con firmas de SQL Injection, con acción de cuarentena.
6. Generar tráfico de prueba (payloads SQLi) para demostrar la detección, el bloqueo y el registro (logging) del evento.
7. Configurar un perfil de filtrado de archivos que bloquee la descarga de `.exe`.
8. Configurar una política de protección DoS (anomalías L3/L4) para mitigar escaneos y floods.
9. Configurar VLAN 10 y DHCP para la red de Usuarios en el switch y en el FortiGate.
10. Aplicar seguridad básica en el switch (port-security, banner, cifrado de contraseñas, deshabilitar CDP, BPDU Guard).
