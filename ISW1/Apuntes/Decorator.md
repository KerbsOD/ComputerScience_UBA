# Intencion
Agregarle responsabilidades a un objeto de manera dinamica. Son una alternativa a la subclasificacion para extender funcionalidad.
AKA: Wrapper. 

# Ejemplo
Un ejemplo seria agregarle bordes a una pieza de UI. Si heredamos el borde desde otra clase le estamos poniendo un borde a todas las instancias de la subclase UI. Es inflexible y no le estamos dando la opcion al cliente de decidir cuando puede agregarle un borde al componente de UI.

Solucion mas flexible, decorator. Encerramos al componente en un objeto que "agrega" el borde. 

El decorator es polimorfico con respecto al componente que decora por lo que es indistinguible para el cliente. 

![[Pasted image 20240524093110.png]]

El decorator **forwardea** los mensajes al componente que decora y tal vez tiene funcionalidad extra.
Si decoramos la pieza de UI lo que estamos haciendo es como meter el componente en el Decorator; cuando le llegan mensajes al decorator los forwardea al componente, porque como especificamos antes son polimorficos, y le dibuja el marco.

![[Pasted image 20240524091801.png]]
Como los decorators son indistinguibles del componente en si, podemos nestearlos recursiva e infinitamente.

![[Pasted image 20240524092000.png]]

Tal vez no siempre queremos bordes negros o la scrollbar, por eso no esta implementado por default y lo metemos en un decorator.

> Consecuencia: Perdida del self para aTextView. Como el aTextView se vuelve un componente de aScrollDecorator y aScrollDecorator se vuelve un componente de aBorderDecorator entonces no podemos usar nada del estilo self sobre aTextView.

Supongamos que existe el mensaje view() que sirve para displayear el texto, con el diagrama de arriba nosotros hicimos que el texto que queremos mostrar tenga bordes negros y una scrollbar. 
El cliente que envia el mensaje view() NO LO SABE, solo sabe que le esta enviando un mensaje a un texto para mostrarlo.

1. El mensaje *view()* es enviado a aBorderDecorator que agrega el borde negro y forwardea el mensaje *view()* a su componente (decoratee). 
2. El componente resulta ser aScrollDecorator que recibe el mensaje *view()* por lo que agrega el scrollbar al componente y forwardea el mensaje *view()* a su componente (decoratee). 
3. El componente resulta ser aTextView que recibe el mensaje view y muestra el texto con todos los agregados.

# Usos conocidos 
- Se usa en interfaces graficas para agregarle "adornos" a componentes graficos.
- Adornar streams de data como compresion o encriptacion.
  ![[Pasted image 20240524100903.png]]
  Notar que compressingStream comprime la data y luego forwardea el mensaje.
