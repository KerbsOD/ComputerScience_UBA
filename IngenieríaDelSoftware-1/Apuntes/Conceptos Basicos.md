# Cohesion 
La cohesión nos indica el grado de relación existente entre los distintos elementos de una clase. Una clase tendrá una cohesión alta cuando todos sus métodos estén relacionados entre si, bien mediante llamadas entre ellos o bien mediante el uso de variables cuyo ámbito se encuentre a nivel de clase. Y esto suele ocurrir cuando una clase realiza una única tarea.

> Siempre vamos a querer una alta cohesion.

Ejemplo 1 - Expresion booleana: 
La clase expresion booleana que quiere responder cuantos 'or' hay en una expresion. No tiene sentido que toda la implementacion recursiva este dentro de la clase Expresion booleana. 
Para solucionarlo creamos un method object donde solo le pasamos los parametros y cuando llamamos 'cantOrs' que nos responda con la solucion.
![[Pasted image 20240524003742.png]]

# Acoplamiento
Grado de dependencia de la clase con respecto a otros elementos externos. Por lo tanto, diremos que una clase tiene un nivel de acoplamiento alto cuando hace uso en gran medida de otros componentes. 

> Siempre vamos a querer un bajo acoplamiento

Ejemplo 1 - Servicios: 
En este caso el servicio de facturacion esta ligado a 3 modulos para cumplir su trabajo. 
1. Valida la factura.
2. Paga la factura.
3. Envia la factura con el pago realizado.
Nuestra clase servicioFacturacion depende de otros servicios y por lo tanto cada cambio que realicemos en cualquiera de estas clases implica que el servicioFacturacion tambien se vera afectado.
![[Pasted image 20240524010050.png]]

# Encapsulamiento 
Se utiliza para restringir el acceso a los componentes internos de un objeto. Desde un punto de vista filosofico promueve que las clases tengan un comportamiento natural con respecto al dominio del problema y no simplemente expulsar data cruda. Una persona no se arranca el brazo y te lo da, si no que tiene la funcion de Saludarte() con su brazo. 

> La herencia se considera un tipo de rompimiento de encapsulamiento porque estamos accediendo a datos o implementaciones de otra "clase" (clase padre).

Ejemplo 1 - Mars Rover:
Una de las funcionalidades del MarsRover es moverse por lo que queremos chequear que se haya movido correctamente cuando testeamos. 
Para no romper encapsulamiento, en vez de un 'getter' que nos de la posicion del rover y compararla con la esperada podemos tener un mensaje que le pregunte al rover si esta en cierta posicion respondiendo true o false.

Ejemplo 2 - Areas:
El ejemplo más claro de encapsulación y polimorfismo sería un programa capaz de calcular las áreas de distintos polígonos, un cliente solo debería de conocer la existencia del método encargado de devolver el área, sin necesidad de preocuparse del proceso interno para calcular las mismas, puesto que el cálculo del área de un cono no se corresponde con la de un rectángulo. Será tarea del programador asegurar la encapsulación para que los métodos que devuelven el área de los distintos objetos de diferentes polígonos respondan de la misma manera, cada uno mediante su propia fórmula matemática de cálculo del área, logrando así el mencionado polimorfismo.

De esta forma además de que el usuario de la clase puede obviar la implementación de los métodos y propiedades para concentrarse solo en cómo usarlos, evita que el usuario pueda cambiar su estado de maneras imprevistas e incontroladas. 

# Abstraction Level
Esto no se da en la materia pero lo habia leido en uno de los papers y me gusto mucho. (el paper no lo da la catedra, lo encontre por error mientras buscaba el paper de ese dia).

> **Mantener todas las operaciones de un metodo en el mismo nivel de abstraccion** 

Se refiere a que si vamos a tener un composed method, todo el codigo sea del mismo nivel de abstraccion. Si tenemos un server que recibe y envia mensajes a la gente de la sala en el metodo Operate(), dentro del metodo las operaciones con respecto a recibir y enviar tienen que estar al mismo nivel

![[Drawing 2024-05-24 01.57.52.excalidraw]]

De esta forma estamos comunicando al lector que es lo que se esta haciendo y no como. Leer un metodo tiene que ser declarativo para que se pueda entender con mas facilidad y no perdernos en los detalles. Me gustaria llamar a los metodos como "send:" un tipo de *metodo primitivo* donde se encuentra la implementacion de la declaracion de su nombre.

# Clase Abstracta
Es una clase que no puede ser inicializada por si sola y esta disenada para ser la clase base de otras clases. 
Nos sirven para crear "moldes" para clases que se relacionan al concepto. Fuerzan implementacion de metodos en las subclases, reducen duplicacion de codigo y proveen una estructura clara para las clases derivadas.

Ejemplo 1 - MarsRover:
La clase heading no representa nada, es solo la base para tener las clases polimorficas headingNorth, headingEast, headingSouth y headingWest.

Ejemplo 2 - Portfolio:
En el portfolio 'Transaction' y 'Account' son clases abstractas porque no podemos inicializar una transaccion o una cuenta. Podemos inicializar un deposito, un retiro, una cuenta corriente o un portfolio.


# Conforms
Se usa mucho cuando hablamos de clases e interfaces.
Significa que una clase implementa los mensajes de una Superclase o una interfaz. O sea, es polimorfico.