# Pila
![[Pasted image 20230824165450.png]]

> Notar que para abajo las direcciones son mayores y para arriba son menores. Se pushea para 'abajo' y se popea para 'arriba'

![[Pasted image 20230824171552.png]]

Los procesadores de intel organizan la memoria en bytes la pila **no**. 
Si estamos trabajando en intel 32bits entonces **el stack debe estar alineada a 32 bits**.
$\implies$ El bloque de memoria que constituye al stack (segmento) debe comenzar en un multiplo de 4 porque 32bits son 4 bytes.

> Porque los procesadores de 32 bits tienen buses de 32 bits. La operacion del stack al procesador involucra una transaccion de todo el bus de 32 bits. La idea es que la instruccion se realice en un ciclo. Evitando instrucciones adicionales para corregir datos. Ver Practica 2 correccion de dato desalineado.

Independientemente de si estamos pusheando 1 byte o poppeando 2 bytes se cumplen estas reglas *siempre:*
- Si trabajamos en 16 bits el stack se incrementa o decrementa de a 2 bytes.
- Si trabajamos en 32 bits el stack se incrementa o decrementa de a 4 bytes.
- Si trabajamos en 64 bits el stack se incrementa o decrementa de a 8 bytes.


