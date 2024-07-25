# Intencion
Proporciona un sustituto para otro objeto que comparta el mismo protocolo pero no haga nada. Encapsula el como "no hacer nada" y oculta los detalles de los colaboradores.

A veces una clase necesita un colaborador que no haga nada pero quiere tratarlo como cualquier otro colaborador que si tiene comportamiento.
Queremos que a los ojos del *cliente* el colaborador que hace algo y el que no hace nada sean indistinguibles. Es un diseno mas elegante.

![[Pasted image 20240524062110.png]]
En Null Object Pattern tenemos una *clase abstracta* que define un protocolo polimorfico. El Null Object es implementado como una subclase de esta clase abstracta. Como es polimorfico con respecto a la clase abstracta padre entonces puede ser usado en cualquier lado que este tipo de objeto sea necesario.

# Usos Conocidos

#### NoController
El que se ve en el diagrama, es una clase en la jerarquia de controles.

### NullDragMode
Representa el intento de modificar un componente visual que no puede ser modificado (tipo window resize en los OS cuando acercamos la ventana al borde superior). La subclase CornerDragMode que implementa exitosamente el resize envia un bloque de codigo para controlar como se hace el drageo. En NullDragMode envia un bloque vacio.

### NullScope
Es una subclase de la NameScope hierarchy. NameScope representa el scope de un conjunto de variables; dependiendo del tipo de variables (global, de clase, de metodo) le define que tipo de NameScope tiene.
- StaticScope: Se le asigna a las variables globales y a las de clase.
- LocalScope: Se le asigna a las variables de metodo o temporales. 

Todas tienen un OuterScope para marcar desde donde hasta donde abarcan y avisarle al programador si esta declarando una variable con el mismo nombre que una ya declarada en ese rango.
Se forma un Arbol! Las variables globales estan en la raiz, las de clase son nodos internos que tienen ramas a las variables de metodos. 

Cual es el *Outer scope* de las globales? Como se fijan si tienen una variable con su mismo nombre "arriba de ellas" si ya estan arriba de todo? (abarcan todo el scope) -> NullScope! Arriba de las globales hay un NullScope sin variables. 

Cada vez que una variable busca una declaracion ya hecha con el mismo nombre va subiendo en el arbol hasta que la encuentra o llega al NullScope. 

