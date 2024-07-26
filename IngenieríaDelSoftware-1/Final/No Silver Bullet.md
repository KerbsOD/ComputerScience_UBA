Preguntas frecuentes:

- changeability, invisibility, complexity, conformity.
- que dice el paper de brooks en general.
- Algo de la materia que ataque los problemas escenciales.
- Con que se relaciona TDD.
- Relaciones con el paper de naur.

# Abstract
La construccion de software involucra **tareas escenciales** como el modelado del problema y **tareas accidentales** como la representacion de estas entidades en lenguajes de programacion.

La mayoria de las mejoras en productividad se deben a la reduccion de **tareas accidentales** (limites de hardware, lenguajes de programacion complicados, etc). 

Debemos concentrarnos en las **tareas escenciales** del desarrollo de software: *Modelado abstracto de conceptos estructurales de alta complejidad*.
- Evitar construir lo que se puede comprar.
- Prototipado rapido al establecer requerimientos de software.
- Software que crece de manera natural, agregando funcionamiento a sistemas mientras son usados y testeados. 
- Desarrollar a los disenadores de la siguiente generacion.

# Problema
Los proyectos de software pasan de *inocente* y *familiar* a un problema de presupuestos, fechas mal estimadas y productos fallidos. 

# Solucion estimada
**Una bala de plata** para bajar rapidamente los costos como lo fue el boom del hardware.

# Conclusiones
No existe un desarrollo en tecnologia o administracion que prometa mejoras en productivadad, eficiencia o simplicidad.

# Paper
Se analiza el por que no existe un avance en el desarrollo de software y que propiedades tienen las balas propuestas.

# Avance de Hardware
No podemos concluir que el avance en software es lento si no que el avance en hardware es muy rapido en comparacion.

# La escencia de una entidad de software
- Conjuntos de datos.
- Relaciones entre datos.
- Algoritmos.
- Invocacion de funciones.

# La parte dificil de construir software
Especificacion, diseno y testeo de los conceptos construidos, **no** el trabajo de representarlo y testear la afinidad de la representacion.

La dificultad reside en modelar el problema, no implementarlo. Podes testear muy bien el codigo y aun asi estar mal el concepto general.

Los errores de sintaxis son nada en comparaciones a los errores conceptuales en los sistemas.

# Propiedades de la escencia de los sistemas modernos
- Complexity
- Conformity
- Changeability
- Invisibility

# Complexity
Las entidades de software son muy complejas en cuanto a tamano porque ninguna parte es igual. Las computadoras digitales tienen una cantidad combinatoria de estados y el software tiene todavia mas ordenes de magnitud en estados.

Extender el software incrementa el numero de diferentes estados y las colaboraciones aumentan de manera no lineal.

La complejidad en software es una **propiedad escencial** por lo tanto el software que abstrae su complejidad, abstrae su escencia.

Las matematicas y fisicas pudieron simplificar por 3 siglos los modelos de fenomenos complejos, derivando propiedades de estos, porque la complejidad ignorada no era escencial de las propiedades del fenomono.

Debido a la complejidad escencial creciente del desarrollo de software se derivan problemas clasicos:
- Comunicacion entre miembros del equipo.
- Fallas del producto.
- Aumento de costos.
- Malas estimaciones.
- Incapacidad de listar los estados del programa.
- Dificultad para invocar funciones.
- Programas dificiles de usar.
- Programas dificiles de extender.
- Se pierde la integridad conceptual del sistema, la semantica de lo que se quiere representar. Las cosas pierden significado.

>La complejidad es una propiedad escencial del software debido a la cantidad de estados. Extenderlo solo genera mas estados aumentando las colaboraciones de manera no lineal. Esta complejidad deriva problemas con los equipos, problemas con el sistema, problemas con el proyecto.
>Es inevitable.

# Conformity

Los fisicos trabajan con sistemas altamente complejos, a pesar de esta complejidad estos creen que existe principios unificadores que pueden simplificar la comprension de la naturaleza. Porque dios no es caprichoso ni arbitrario.

La mayoria de la complejidad que enfrentan los ingenieros de software se debe a la necesidad de que el software se ajuste a sistemas ya existentes. Lo cual anade una capa de complejdiad. El software nuevo tiene la obligacion de integrarse a los sistemas antiguos.

> La complejidad que enfrentan los ingenieros de software se debe a la necesidad de conformidad con otros sistemas y no puede ser eliminado con redisenos.

# Changeability

Siempre esta la presion del cambio.

Todos los productos pueden sufrir cambios pero lo hacen de manera no frecuente o en nuevos modelos, casi nunca se modifica el producto orignal. 

En ese sentido el software esta constantemente sujeto a cambios. Porque puede ser cambiado mas facilmente. Infinitamente maleable.

> El software de un sistema es su funcion y su funcion es la parte que mas siente las presiones del cambio.

Todo el software exitoso es cambiado. Cuando un producto resulta util para las personas, estas tratan de darle mas usos hasta fuera del scope.

El software sobrevive el ciclo de vida del hardware para el que fue disenado por lo que se tiene que ir cambiando para adaptarse a nuevos sistemas fisicos.

> El entorno del software cambia por lo que obliga a este a cambiar.

# Invisibility

El software es invisible. Las abstracciones son una herramienta poderosa para el ser humano. Pero el software no puede representarse como la tierra en los mapas o las paredes en un plano. A la hora de diagramar un sistema de software nos encontraremos con varios grafos dirigidos superpuestos que representan el flujo de datos, de control, de colaboraciones, dependencias, etc. 

> La escencia invisible del software le quita a la mente su herramienta mas podersa, la abstraccion y semantica. 

Impide el entendimiento de los conceptos de uno mismo y dificulta la comunicacion con otros.

# Lenguajes de alto nivel
Los lenguajes de alto nivel tuvieron un alto impacto en la productivad y simplicidad.
Libera a los programas de detalles implementativos. Elimina todo un nivel de complejidad que no tiene nada que ver con el programa en si. El desarrollo de lenguajes se acerca mas y mas al nivel de los usuarios.
La elaboracion de estos se convierte en un incremetno de la tarea intelectual.

# Time Sharing
Se refiere al concepto de un switcher de tasks como vimos en Orga2. El hecho de tener un flujo constante del programa nos permite concentrarnos en la complejidad. No nos corta el flujo de trabajo o pensamiento.

Se pierde el flujo de concentracion cuando compilamos y ejecutamos. La interrupcion de la conciencia es cara en tiempo.

> Principal efecto: Acortar el tiempo de respuesta del sistema.

# Unified programming enviroments
Atacan **tareas accidentales** al usar programas en conjunto. Dandonos librerias integradas.

# Technical developments -> potential silver bullets
- Que problemas resuelven?
- Son **essential tasks** o son **accidental tasks**?
- Ofrecen avances revolucionarios o incrementales?

# Ada
Va a hacer una gran diferencia pero no por las features del lenguaje o por su ambiente de desarrollo. Si no porque fomenta a los programadores a entrenar tecnicas de diseno modernas.

# OOP
Los beneficios de los tipos abstractos de datos y los tipos jeriarquicos son la eliminacion de **tareas accidentales** y permiten mejores expresiones de diseno. 
La complejidad es escencial y eso no se puede cambiar. 

# Artificial Intelligence
Hay 2 tipos de IAs:
- Las que resuelven problemas que solo podian ser resueltas por humanos.
- El uso de heuristicas para resolver problemas como lo resuelven los humanos.

# Expert systems
Un tipo de inteligencia artificail que tiene un motor de inferencia. Toma un input y una serie de verdades y explora las consecuencias logicas mediante inferencia derivable (Como pdp).
El prerequisito escencial para construir un expert system es tener un experto.

> El valor de un expert system es ponerlo al servicio del programador inexperto, de esta manera puede aprovechar la experiencia y sabiduria acumulada de los mejores programadores. Contrasta un poco con lo que hace GithubCopilot donde el codigo sugerido no es de expertos si no del promedio de repo de github.

# Graphics programming
El software es muy dificil de visualizar

# Avances
No existe algun descubrimiento que prometa avances magicos como son tan comunes en el hardware pero existen algunos trabajos interesantes.

# Buy versus build
Cualquier producto es mas barato comprarlo que construirlo desde cero. Un programa de $100.000 cuessta lo mismo que el salario anual de un ingeniero y la entrega es inmediata!

El costo del software se debe al desarrollo, no 


