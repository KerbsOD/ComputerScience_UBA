# Intencion
Permitir que un objeto altere el comportamiento del otro cuando el estado interno del otro cambia. La idea es cambiar la clase del otro objeto. (o sea cambiarlo de una subcalisificacion a otra).

# Ejemplo
TCPConnection. Puede estar en 3 estados (tiene 3 subclasificaciones): TCPEstablished, TCPListening y TCPClosed. 
El patron state describe como TCPConnection puede mostrar diferente comportamiento dependiendo de cada estado. 

Introducimos una clase abstracta TCPState para representar los estdos de TCPConnection. Declara un protocolo polimorfico con respecto a las operaciones de los estados. Las subclases de TCPState implementan comportamiento especifico de esa subclase.

![[Pasted image 20240525075757.png]]
TCPConnection tiene guardado un state object (una instancia de algunos de los 3 estados) que representa el estado actual de la conexion.
Entonces cada vez que hay que responder un mensaje con respecto a algo relacionado al state simplemente le decimos a state que lo responda. 
Si la conexion cambia su estado, entonces TCPConnection tiene que cambiar su state object. 

# Usos conocidos
- TCP connection protocols.
- Whiteboards usan state para el puntero. Cambia el estado dependiendo si queres dibujar lineas, seleccionar, etc. El whiteboard mantiene una "currentTool" y delega los requests al estado. El objeto (lapicera o lapiz o pincel o goma o seleccionar o dibujar cuadrados) cambia cuando el usuario elige una herramienta diferente.
  ![[Pasted image 20240525081015.png]]
  
