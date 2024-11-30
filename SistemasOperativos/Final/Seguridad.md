## ¿Cuáles son las tres categorías principales de permiso frente a un archivo? (owner, group, universo, ACL, capability)
## Explicar cómo son las ACLs en UNIX.
## Explicar SETUID. Explicar otro método (distinto a setuid y setguid) para ejecutar con permisos de otro usuario.
## Explicar cómo funcionan los canarios.
## ¿Para qué sirve el bit NX (No eXecute) de la tabla de páginas?
## Explicar buffer overflow y mecanismos para prevenirlo. (canario, páginas no ejecutables, randomización de direcciones) ¿En qué parte de la memoria se buscan hacer los buffer overflow? (En el stack, pero también se puede hacer en el heap.
## ¿Cómo se genera el canario? ¿En tiempo de compilación o de ejecución?
## Explicar el ataque Return to libc.
## Dar un ejemplo de un error de seguridad ocasionado por race condition. (cambiar concurrentemente puntero de symbolic links)
## Explicar las diferencias entre MAC y DAC.
## ¿Qué es una firma digital? Explicar cómo es el mecanismo de autenticación.
## ¿Qué es una función de hash? ¿Cómo se usa en el log-in de un SO? ¿Qué problemas tiene usar un hash para autenticar usuarios? ¿Cómo se puede mejorar la seguridad? ¿Qué es un SALT? ¿Cómo podemos hacer que calcular la función de hash sea más costoso? ¿Qué otros usos tiene la función de hash en seguridad?
## ¿Qué es una clave pública/privada? ¿Cómo podemos distribuir una clave pública?
## ¿Por qué es más seguro utilizar un esquema de clave pública/privada para una conexión por ssh, comparado con usuario/contraseña?
## ¿Cómo podemos asegurarnos que un programa es confiable? ¿Qué pasa si nos modifican tanto el hash como el archivo? Explicar cómo podemos brindar de manera segura las actualizaciones de un software. (integridad, autenticación, canal seguro)
## Explicar las diferencias entre HTTP y HTTPS. Explicar cómo se podría realizar un ataque cuando se realiza una actualización de un programa por HTTP (suponiendo que la actualización está firmada digitalmente) pegándole a un endpoint http.
## ¿Se puede considerar Deadlock un problema de seguridad?
## ¿Qué problemas de seguridad hay asociados a los file descriptors? ¿Cómo lo resuelve SELinux?