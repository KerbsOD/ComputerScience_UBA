# Intencion 
Te da un placeholder para un objeto para controlar su acceso.
Controlamos el acceso a un objeto para postergar (defer) el costo de su creacion e inicializacion hasta que realmente lo necesitemos.

# Ejemplo
Supongamos un editor de documentos que se le pueden agregar objetos graficos. Algunos objetos graficos como imagenes pueden ser muy costosos de crear pero abrir el documento deberia ser rapido.
Debemos evitar crear todas las cosas costosas de una cuando el documento es abierto. 

Solucion, crear los objetos costosos a demanda. En este caso es cuando el objeto hay que hacerlo visible (poner la imagen en la pantalla). Usando un image proxy podemos hacer de placeholder para la imagen real. Actua como la imagen y se encarga de la inicializacion para esta cuando es necesario. 

![[Pasted image 20240524115217.png]]

La image proxy crea a la imagen real solo cuando el textDocument pide imprimirla en pantalla mediante Draw(). El proxy forwardea el mensaje a la imagen. El proxy debe tener una referencia a la imagen.

Tambien tiene algo llamado *extent* que seria el largo y alto de la imagen, esto le permite al proxy responder ciertas preguntas sobre el tamano de esta sin inicializarla. 

![[Pasted image 20240524115637.png]]

O sea. El imageProxy no puede responder a Draw() (tiene que inicializar la imagen) pero si puede responder a getExtent sin necesidad de inicializarla. Una vez la imagen esta inicializada todos los mensajes van al proxy y este los forwardea a la clase de la imagen.

# Usos conocidos 
- Los servidores crean proxies para objetos remotos cuando los clientes los requestean. 
- En smalltalk se usan para acceder a objetos remotos.