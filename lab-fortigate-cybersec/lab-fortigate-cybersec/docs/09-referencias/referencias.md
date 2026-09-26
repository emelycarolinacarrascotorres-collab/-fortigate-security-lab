# Referencias

[⬅ Volver al índice principal](../../README.md)

## Documentación oficial de Fortinet

- FortiGate — Firewall Policies: <https://docs.fortinet.com/document/fortigate/latest/administration-guide/954478/firewall-policies>
- FortiGate — SSL/SSH Inspection: <https://docs.fortinet.com/document/fortigate/latest/administration-guide/779239/ssl-ssh-inspection>
- FortiGate — Intrusion Prevention (IPS): <https://docs.fortinet.com/document/fortigate/latest/administration-guide/691966/intrusion-prevention>
- FortiGate — DoS Policy: <https://docs.fortinet.com/document/fortigate/latest/administration-guide/954945/dos-policy>
- FortiGuard IPS Signature Database (Attack ID 15621 — HTTP.URI.SQL.Injection): <http://www.fortinet.com/ids/VID15621>
- FortiGuard IPS Signature Database (Attack ID 100663402 — tcp_src_session): <http://www.fortinet.com/ids/VID100663402>

## Documentación de Cisco IOS

- Configuring VLANs: <https://www.cisco.com/c/en/us/td/docs/switches/lan/catalyst3750/software/release/12-2_55_se/configuration/guide/scg3750/swvlan.html>
- Configuring Port Security: <https://www.cisco.com/c/en/us/td/docs/switches/lan/catalyst3750/software/release/12-2_55_se/configuration/guide/scg3750/swtrafc.html>
- Configuring Spanning Tree PortFast / BPDU Guard: <https://www.cisco.com/c/en/us/support/docs/lan-switching/spanning-tree-protocol/10556-16.html>

## Herramientas y software de laboratorio

- GNS3 (plataforma de simulación de red): <https://www.gns3.com/>
- Docker: <https://docs.docker.com/>
- Apache HTTP Server: <https://httpd.apache.org/docs/>
- MariaDB Server: <https://mariadb.com/kb/en/documentation/>
- PHP `mysqli`: <https://www.php.net/manual/en/book.mysqli.php>

## Referencias sobre las vulnerabilidades demostradas

- OWASP — SQL Injection: <https://owasp.org/www-community/attacks/SQL_Injection>
- OWASP — Denial of Service: <https://owasp.org/www-community/attacks/Denial_of_Service>

## Material propio del laboratorio (fuente de este repositorio)

Todo el contenido técnico de este repositorio proviene directamente del material entregado por el autor del laboratorio: capturas de pantalla de la GUI de FortiGate, salidas de consola de Windows/Linux/Cisco IOS, y los siguientes archivos de configuración/script:

- [`configs/fortigate/interfaces-cli-fortigate.txt`](../../configs/fortigate/interfaces-cli-fortigate.txt)
- [`configs/switch/running-config-switch.txt`](../../configs/switch/running-config-switch.txt)
- [`configs/db-server/db-server-dockerfile-y-start-script.txt`](../../configs/db-server/db-server-dockerfile-y-start-script.txt)
- [`scripts/web-server/build-web-server.sh`](../../scripts/web-server/build-web-server.sh)
- [`scripts/testing/pruebas-conectividad-tcp.sh`](../../scripts/testing/pruebas-conectividad-tcp.sh)

No se utilizó ninguna fuente externa para completar datos técnicos del laboratorio (direcciones IP, políticas, resultados de pruebas); donde el material no cubría un dato, se indicó explícitamente como no proporcionado (ver [`../01-introduccion/alcance.md`](../01-introduccion/alcance.md)).
