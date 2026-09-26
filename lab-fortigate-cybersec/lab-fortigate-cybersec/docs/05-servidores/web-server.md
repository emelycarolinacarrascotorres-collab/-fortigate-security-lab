# WEB-Server (SRV-01, SRV-02)

[⬅ Volver al índice principal](../../README.md)

## Identificación

| Campo | Valor | Evidencia |
|---|---|---|
| Nombre GNS3 | `web-server-lab-1` | [`EVID-TOPO-003`](../../evidence/01-topologia/EVID-TOPO-003.png) |
| IP | 10.6.97.2/28 | [`EVID-WEB-001`](../../evidence/04-servidores/EVID-WEB-001.png) |
| Red | 10.6.97.0/28 | [`EVID-TOPO-001`](../../evidence/01-topologia/EVID-TOPO-001.png) |
| Gateway | 10.6.97.1 (interfaz `Web-server`/port5 del FortiGate) | [`EVID-FGT-004`](../../evidence/02-fortigate/EVID-FGT-004.png) |
| Sistema base | Ubuntu 22.04 (contenedor Docker) | [`configs/db-server/`](../../configs/db-server/), [`scripts/web-server/build-web-server.sh`](../../scripts/web-server/build-web-server.sh) |

## Servicio HTTPS (SRV-01)

El servidor ejecuta **Apache2 + PHP** con el módulo SSL habilitado, sirviendo tanto HTTP como HTTPS. La configuración se genera mediante el script [`scripts/web-server/build-web-server.sh`](../../scripts/web-server/build-web-server.sh), que construye una imagen Docker con:

```dockerfile
RUN apt update && apt install -y \
    apache2 php libapache2-mod-php php-mysqli \
    openssl iproute2 net-tools iputils-ping \
 && apt clean

# Certificado autofirmado para HTTPS (requerido para DPI/SSL inspection en FortiGate)
RUN mkdir -p /etc/ssl/lab && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/lab/web.key -out /etc/ssl/lab/web.crt \
    -subj "/C=DO/O=Lab/CN=web.lab.local"

RUN a2enmod ssl && \
    sed -i 's#/etc/ssl/certs/ssl-cert-snakeoil.pem#/etc/ssl/lab/web.crt#; ...' /etc/apache2/sites-available/default-ssl.conf && \
    a2ensite default-ssl
```

Se utiliza un **certificado autofirmado** (`CN=web.lab.local`) específicamente para habilitar HTTPS y permitir que el FortiGate realice SSL Inspection (ver [`../03-fortigate/dpi.md`](../03-fortigate/dpi.md)).

### Evidencia de conectividad

![EVID-WEB-001 - ip addr en WEB-Server](../../evidence/04-servidores/EVID-WEB-001.png)

*EVID-WEB-001: `ip addr` dentro del contenedor confirma `eth0` con `inet 10.6.97.2/28 scope global`.*

![EVID-TEST-001 - Test-NetConnection puerto 443 exitoso](../../evidence/06-pruebas/EVID-TEST-001.png)

*EVID-TEST-001: conectividad HTTPS (443) verificada exitosamente desde el cliente de Usuarios (ver detalle en [`../03-fortigate/politica-usuarios-web.md`](../03-fortigate/politica-usuarios-web.md)).*

## Aplicación vulnerable de prueba (`search.php`)

Para poder demostrar la detección de SQL Injection por parte del FortiGate (ver [`../03-fortigate/sql-injection.md`](../03-fortigate/sql-injection.md)), se desplegó intencionalmente una página vulnerable:

```php
<?php
$db_host = getenv('DB_IP') ?: '10.6.97.18';
$c = new mysqli($db_host,"webuser","Lab#2026","labdb");
$id = $_GET['id'] ?? 1;
$r = $c->query("SELECT id,name FROM users WHERE id=$id");
while($row=$r->fetch_assoc()) echo $row['id']." - ".$row['name']."<br>";
```

Este script concatena directamente el parámetro `id` de la URL en la consulta SQL, sin sanitización ni *prepared statements*, permitiendo inyección de código SQL arbitrario si no existiera un control externo (el FortiGate).

## Archivo de prueba `.exe`

```dockerfile
# Archivo de prueba para el File Filter (.exe)
RUN cp /bin/ls /var/www/html/test.exe
```

Un binario (`/bin/ls` renombrado a `test.exe`) se coloca en la raíz web para poder probar el filtrado de descargas ejecutables (ver [`../03-fortigate/filtrado-exe.md`](../03-fortigate/filtrado-exe.md)).

## Comunicación permitida hacia DB-Server (SRV-02)

El WEB-Server se conecta a la base de datos usando la variable de entorno `DB_IP` (por defecto `10.6.97.18`) y el usuario `webuser` sobre el puerto estándar de MySQL/MariaDB (3306). Esta comunicación es la única permitida hacia `DB-Server` por política de firewall (ver detalle completo, incluyendo pruebas de puertos adicionales bloqueados, en [`comunicaciones.md`](comunicaciones.md)).

### Evidencia de conexión aplicativa exitosa

![EVID-WEB-002 - Ejecución de db-test.php con conexión exitosa](../../evidence/04-servidores/EVID-WEB-002.webp)

*EVID-WEB-002: ejecución de `php /var/www/html/db-test.php` dentro del contenedor `web-server-lab-1`, mostrando la salida `Conexion MariaDB exitosa` junto con una tabla HTML de 3 registros (`Ibelka.luna`, `bianka.lua`, `Emely.carrasco`), confirmando que la aplicación PHP del WEB-Server puede consultar exitosamente la base de datos en `DB-Server`.*

## Referencias cruzadas

- Requisitos: **SRV-01, SRV-02**.
- Script de construcción: [`../../scripts/web-server/build-web-server.sh`](../../scripts/web-server/build-web-server.sh).
- Comunicaciones con DB: [`comunicaciones.md`](comunicaciones.md).
- SQL Injection: [`../03-fortigate/sql-injection.md`](../03-fortigate/sql-injection.md).
- Filtrado `.exe`: [`../03-fortigate/filtrado-exe.md`](../03-fortigate/filtrado-exe.md).
