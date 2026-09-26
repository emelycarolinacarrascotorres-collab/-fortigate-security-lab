# Prueba de Filtrado de Archivos `.exe`

[⬅ Volver al índice principal](../../README.md)

## Objetivo
Demostrar que el perfil File Filter `Bloqueo-EXE`, asignado a la política `USUARIOS-a-WEB`, bloquea efectivamente la descarga de archivos ejecutables desde el WEB-Server.

## Condiciones iniciales
- Perfil `Bloqueo-EXE` (regla `Bloquear.exe`, protocolo HTTP, acción `Block`, tipo `exe`) asignado a la política `USUARIOS-a-WEB` (ver [`../03-fortigate/filtrado-exe.md`](../03-fortigate/filtrado-exe.md)).
- Archivo `prueba.exe` disponible en la raíz web del WEB-Server.

## Procedimiento
Acceso desde el navegador del cliente de Usuarios a:
```
https://10.6.97.2/prueba.exe
```

## Resultado esperado
El archivo debe ser bloqueado y el usuario debe recibir una página de reemplazo indicando el bloqueo.

## Resultado observado
El navegador recibe la página: **"Attention — The file 'prueba.exe' has been blocked due to its file type and/or properties."** El log de File Filter registra el evento como `blocked`, tipo `HTTP`, con la URL exacta `http://10.6.97.2/prueba.exe`.

## Evidencia

| Evidencia | Descripción |
|---|---|
| [`EVID-WEB-003`](../../evidence/04-servidores/EVID-WEB-003.png) | Página de bloqueo mostrada al usuario |
| [`EVID-FGT-025`](../../evidence/07-logs/EVID-FGT-025.png) | Log de File Filter (`blocked`, `prueba.exe`) |
| [`EVID-FGT-022`](../../evidence/07-logs/EVID-FGT-022.png) | Detalle de la sesión asociada (destino `10.6.97.2:80`) |

## Conclusión de la prueba

**Éxito.** El requisito FGT-14 (filtrado de aplicaciones para bloquear descargas `.exe`) queda demostrado con evidencia de configuración, de bloqueo efectivo desde el navegador y de registro en logs.
