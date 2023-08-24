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

![[Pasted image 20230824175602.png]]
Como podemos notar a la izquierda estamos en un modo de 64 bits pues se aumenta de a 8 bytes.
0x0 $\implies$ 0x8 $\implies$ 0x10 $\implies$ 0x18 $\implies$ 0x20
> Recordar que en hexa 8 + 8 = 16 pero hexa solo llega hasta 15 asi que 8+8 es 1-0.

- **RSP:** Stack pointer de 64 bits.
- **RBP:**: Base pointer de 64 bits. Trabaja por default con el segmento de pila. Podemos utilizarlo para desplazarnos por la pila.

* **Call Near**: Subrutina que esta en el mismo segmento.
* **Call Far**: Subrutina que esta en otro segmento.

## Call Near

![[Pasted image 20230824181429.png]]
El instruction pointer esta en 0x0007C221. 

La instruccion *call* ocupa 1 byte. La etiqueta *setmask* apunta a una direccion de memoria donde se ubica la subrutina. Si estamos en 32 bits, entonces la direccion de *setmask* ocupa 4 bytes (32 bits). Por lo tanto *call + setmask = 5 byts y 0x0007C221 + 5 = 0x0007C226*

> 0x0007C226 es la **direccion de retorno** luego de atender la subrutina

Tenemos que pushear 0x0007C226 a el stack. Porque es nuestra direccion de retorno cuando termine la subrutina setmask.
![[Pasted image 20230824182314.png]]

- Recordar que el stack pushea y popea en un tamaño fijo, en este caso son 32 bits.
Una vez que llegamos al ret de *setmask*, el stack *poppea* (suma 4 bytes al *stack pointer*) y pone al *instruction pointer* en la posicion que acaba de ser *poppeada*.

## Call Far
![[Pasted image 20230824185212.png]]

Ahora no solo tengo que guardar el Instruction Pointer sino tambien la seccion.
En este caso debo guardar *code1* (porque salto a *code2*).

Como podemos ver el instruction pointer vale 0x0007C228 a diferencia de antes que eran 0x0007C226. Esto es porque ahora se especifica el segmento (code2) y ocupa 2 bytes mas en la instruccion.

```asm
call code2:setmask // call + code2 + setmask = 1b + 2b + 4b = 7b
```

Luego 7bytes  + 0x0007C226 = *0x0007C226*
![[Pasted image 20230824185345.png]]

Cuando llamamos a la subrutina AHORA deberemos no solo guardar el return point sino tambien el segmento.
![[Pasted image 20230824190323.png]]

> Recordar que en intel el stack crece y decrece de a bytes fijos. No importa que code1 ocupe 2 bytes. Como estamos en 32 bits, nos vamos a mover 4 bytes!

**CS:** Code segment.

Ahora, dentro de la subrutina estamos en el segmento code2 y el instruction pointer empieza en la posicion 0x00000000 del code2. Osea, un offset del segmento.
![[Pasted image 20230824191242.png]]

Pero que pasa en la subrutina setmask?

```asm
section code2
setmask:
    and    ax, mask
    retf
```

Tenemos un return far. Este dato recupera el *CS* y el *IP*.

Entonces por ultimo se guarda el top del stack en el *instruction pointer*. Se popea.
Se guarda en el *code segment* el codigo de segmento code1. Se popea. Y ahora el IP sigue con la siguiente instruccion terminando asi con el salto a una subrutina de otro segmento.
![[Pasted image 20230824191707.png]]

## Interrupciones
Las interrupciones son parecidas a los **Call Far**. La diferencia es que en las interrupciones guardamos los flags pues estas son aleatorias e impredecibles.
Supongamos que tenemos una suma y saltamos a la etiqueta *fin* si y solo si hay carry pero "ohh" entre el add y el jc hubo una interrupcion random que hizo sus cosas y nos cambio los flags. Cuando el procesador vuelva y ejecute jc se perdió la información de si hubo o no carry porque la interrupción pude alterar mis datos. Por esta razón guardamos los flags en el stack pointer cuando hay una interrupción.
Por que se guarda el segmento? no puede ser parecid a un **Call Near**? No.
Las interrupciones las manejan los sistemas operativos y estos tienen sus propios segmentos.
```asm
add REX, 576
jc fin
```
![[Pasted image 20230824192117.png]]

Que pasa en la subrutina de la interrupcion?
```asm
section kernel
handler_int:
	in al,port // lee port de E/S
	iret
```

El iret es el *interrupt return*. Cuando llamamos al iret carga la direccion guardada en el stack en el *instruction pointer* y poppea. Carga el segmento en el *code segment* y poppea. Carga los flags y poppea.
![[Pasted image 20230824193849.png]]