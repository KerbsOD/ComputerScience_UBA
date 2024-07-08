# Intencion
Convertir el protocolo de una clase a otro protocolo que el cliente espera usar. Permite la colaboracion entre clases que de otra manera no funcionarian por la incompatibilidad entre los protocolos.

# Ejemplo 
Un whiteboard que nos deja dibujar diagramas e imagenes mediante lineas, poligonos, texto, etc. El whiteboard usa una clase abstracta *Graphical Object*
vista en [[Composite]]. 

El protocolo para graficos del whiteboard es una clase abstracta llamada **Shape**. Se define una subclase de Shape para cada tipo de objeto grafico:
Lineshape class para lineas, PolygonShape class para poligonos, etc.

El problema viene con TextShape class porque manejar y editar texto es mas dificil que lineas o poligonos. Nos gustaria usar TextView de *Graphical Object* para implementar TextShape. Pero TextView no se diseno con shapes en mente.

Solucion. Definir **TextShape** para que adapte el protocolo de **TextView**. 
![[Pasted image 20240524112235.png]]
TextShape forwardea el mensaje GetExtent() para ser respondido por TextVIew. El usuario tamien deberia ser capaz de arrastrar cualquier ShapeObject pero TextView no tiene esa funcionalidad. 
TextShape puede agregar esa funcionalidad implementando CreateManipulation() pues es parte del protocolo polimorfico y esta en el dominio del problema. Extendiendo asi el adapted (TextView). No solo solucionamos el problema de textview si no que encima completamos el protocolo.

![[Drawing 2024-06-12 12.46.31.excalidraw]]

# Usos conocidos
- Table Adapter de smalltalk. Adapta una secuencia de objetos a una presentacion en tabla, esta tabla muestra un objeto por fila. El cliente parametriza TableAdaptor con un conjunto de mensajes que una tabla puede usar para obtener los valores de un objeto.
- Marriage of Convenience. FixedStack que adapta la implementacion de un Array al protocolo de un Stack. El resultado es un stack que tiene un numero fijo de entradas.