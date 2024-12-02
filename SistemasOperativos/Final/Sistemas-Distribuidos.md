Conjunto de procesos conectados por una red que no comparten memoria ni clock.
![[Pasted image 20241201162629.png]]

**UMA**: *Uniform Memory Access*. Todos los procesadores tienen el mismo acceso a memoria en la misma cantidad de tiempo.

**NUMA**: *Non-Uniform Memory Access*. El tiempo de acceso a memoria depende de donde se ubica en relacion al procesador que la quiere acceder.

## ¿Cómo podemos mantener una base de datos distribuida sincronizada?



## ¿Qué es un sistema distribuido? ¿Qué significa que un sistema sea completamente distribuido? ¿Qué beneficios ofrecen? ¿Qué problemas nos puede traer?

Es un conjunto de procesadores que no comparten memoria ni clock. Cada nodo tiene sus propios recursos. Estos nodos se comunican mediante redes de alta velocidad.

Un sistema es completamente distribuido cuando:
1. No existe un nodo central de control. 
2. Las responsabilidades estan repartidas entro todos los nodos. 
3. Los nodos pueden tomar decisiones locales.
4. Si un nodo o varios fallan. El sistema sigue funcionando sin interrupciones significativas.

Mas rendimiento, disponibilidad a fallos, mejora latencia si distribuimos a traves de diferentes zonas, mejor rendimiento si dividimos el trabajo en diferentes nodos o delegar trabajo a nodos especializados en problemas a resolver (como un nodo especifico para procesar imagen, desde nuetra compu le mandamos el trabajo y que nos devuelva el resultado).

Los mayores problemas son los relacionados a la sincronizacion porque requiere algoritmos avanzados para resolver cosas que en un ssoo se resuelve con variablesa atomicas.
La coherencia tambien es dificil, es muy dificil garantizar que todos los nodos vean los mismos datos. **Teorema de CAP / Conjetura de Brewer**: En un entorno distribuido no se puede tener a la vez consistencia, disponibilidad y tolerancia a fallas.
Problemas de latencia. Pueden variar dependiendo de la distancia de los nodos y la calidad de las redes de comunicacion entre ellos. 

## Explicar los distintos algoritmos de commits que se utilizan para actualizar una copia del archivo que está en varios nodos (2PC y 3PC). ¿Cuál es la diferencia entre 2PC y 3PC? Explicar la diferencia entre weak/strong termination.

**2PC**: Es un tipo de sistema de transacciones atomico que se divide en dos fases. Hay un nodo coordinador que comienza la votacion y todo el resto de nodos son participantes.
1. **Fase de votacion**: Un proceso coordinador prepara a todos los proceso participantes para commitear o abortar una transaccion. Los procesos responden si o no.
2. **Fase de commiteo**:  Todos los procesos votaron que si se commitea y si alguno vota que no se aborta. Se notifica el resultado a todos los procesos y proceden con las acciones necesarias para sus transacciones locales.

Si alguno responde que no envia un rollback para que los participantes deshagan la transaccion.

*2PC* es bloqueante. Si el coordinador falla constantemente, algunos participantes nunca van a resolver sus transacciones.

**Los participantes se bloquean hasta que un mensaje de commit o rollback sea enviado por el coordinador.**

Si el coordiandor falla y los participantes no reciben el mensaje de confirmacion entonces no se confirma la transaccion.

Si el coordinador falla y un participante tambien es posible que el participante que fallo haya sido el primero en recibir la notificacion y que haya realizado la confirmacion. Auqnue se selecione un nuevo coordinador no se puede proceder con confianza hasta que haya recibido la confirmacion de todos los participantes. y por lo tanto se bloquea hasta que todos los participantes respondan.

// En las diapos de mi cursada no existe 3pc

## ¿Qué hace un nodo si se cae después de que todos digan _sí_ al coordinador en 2PC?

Si un participante *se cae* despues de enviar un *si* al coordinador debe buscar una manera de actualizar el estado de la transaccion.

Consulta al coordinador para saber el estado de la transaccion. SI el coordinador ya decicio que Si entonces commitea los cambios. Caso contrario hace rollback.

Si el nodo no puede comunicarse con el coordinador entonces busca a otros nodos participantes para preguntarles sobre el estado de la transaccion. Si alguno sabe la decision final lo aplica. 

El problema es que se bloquean los recursos asociados a la transaccion mientras el nodo esta en estado de incertidumbre. No puede actuar por si solo!

**3CP** Agrega una fase adicional donde los participantes pueden tomar decisiones de manera autonoma en ciertos escenarios.

## Explicar el problema bizantino.

Diferentes nodos tienen que decidir si hacer una accion o no (en general, commitear una transaccion). Se decide que si si todos los nodos responden que si. Se decido que no si al menos uno responde que no.
Los medios de comunicacion entre nodos pueden fallar.

## Explicar token ring ¿Qué problemas tiene? ¿Qué se hace en caso de que se pierda el token? ¿Cómo podemos mejorarlo?

La idea es circular un token por un anillo logico de procesos. Solo el nodo que tiene el token puede acceder a secciones criticas lo que evita race conditions distribuidas.

Si el token se pierde por algun fallo de red en algun nodo entonces se paraliza todo el sistema porque ningun nodo puede transmitir. Tambien hay mucha latencia extra porque el token viaja a traves de una red. 
\+ nodos -> \+ latencia

## Explicar la diferencia entre grid y cluster.

**Cluster**: Conjunto de computadoras conectadas por una red de alta velocidad con un scheduler de trabajos comun.

**Grids**: Conjunto de clusters con dominions administrativos distintos.