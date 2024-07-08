### Intencion
Componer objetos en una estructura de arbol para representar jerarquias donde tenes *objetos* y *composiciones* de objetos pero todos los nodos son subclases de una misma clase abstracta. Teniendo asi el mismo protocolo. 
Nos deja tratar *objetos* y *composiciones* de la misma manera. 

![[Pasted image 20240524043940.png]]
**Graphics:** Clase abstracta que representa a las primitivas/objetos y composiciones/containers. Declara operaciones que todos los objetos comparten; como *Draw()* que es una operacion especifica de TODOS los objetos graficos y operaciones que solo las composiciones comparten; como *Add(Graphic)* que sirven para acceder o administrar objetos internos.

**Line, Rectangle, Text:** Clases que representan primitivas graficas. Implementan draw porque son graficas pero no tienen hijos del tipo *Graphics* por lo que no implementan *child-related operations*. 

**Picture:** Clase que define un *aggregate* de objetos graficos. Implementa *Draw()* para llamarlo en cada hijo e implementa operaciones relacionadas con tener nodos hijos. Como picture es una subclase de Graphics y tiene hijos Graphics entonces Picture puede estar compuesto de otros Pictures de manera recursiva.

> Aggregate: Objeto que esta compuesto por otros objetos.

![[Pasted image 20240524055034.png]]
# Usos conocidos
- View class en smalltalk.
- RTLExpression es una clase del sistema de compilacion de smalltalk que parsea arboles.
- Portfolios que agregan activos que pueden ser otros portfolios.