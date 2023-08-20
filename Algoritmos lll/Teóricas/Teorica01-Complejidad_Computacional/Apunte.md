# Maquina RAM
![[Pasted image 20230820042111.png]]
> Los puntos en "Entrada", "Salida" y "Memoria" implican que estos arreglos de celdas **no** tienen fin. "Programa" si tiene fin. Pues un algoritmo es una serie finita de instrucciones.

# Complejidad Computacional
Una operacion es **elemental** si su tiempo de ejecucion puede ser acotado por una constante independientemente de los operandos sobre las cuales se esté aplicando.
![[Pasted image 20230820044419.png]]
No es realista asumir que *resu* va a estar siempre acotado por una constante y que la operacion *resu $\texttimes$ i* va a ser *elemental*. 
> Tengamos en cuenta que 10! = 3.628.800. Mientras resu siga creciendo va a costar mas hacer la multiplicacion de resu por i. Hay que tener en cuenta estas complejidades.

**Modelo Uniforme:** Apropiado cuando los operandos entran en una palabra, o sea, podemos asumir que siempre estan acotados.
**Modelo Logaritmico:** Apropiado cuando los operandos de las operaciones pueden crecer **mucho**. (Ej: resu). Ideal cuando queremos *modelar la realidad*.

#### Complejidad en el peor caso
Para todas las instancias de tamaño $n$ tomo la que insume **más** tiempo. Esto nos da la complejidad de peor caso del algoritmo $A$ para mi instancia de tamaño $n$.
 $T_{A}(n) = max_{I:|I|=n}t_{A}(I)$  
 > Cualquier funcion exponencial es *peor* que cualquier funcion polinomial.

Si en 1 hora resolvia un problema de tamaño N$i$ y ahora tengo una maquina que funciona 1000 veces mas rapido que la anterior. Cuanto puede crecer mi entrada N$i$ para resolver el mismo problema tambien en 1 hora???
- Tardo 1 hora en resolver un problema con complejidad $log \ n$ y tamaño N1. Si ahora tengo una maquina 1000 veces mas rapida, voy a tardar 1 hora en resolver **el mismo problema** pero ahora de tamaño N1$^{1000}$.
- Tardo 1 hora en resolver un problema con complejidad $n$ y tamaño N2. Si ahora tengo una maquina 1000 veces mas rapida, voy a tardar 1 hora en resolver **el mismo problema** pero ahora de tamaño N2$\texttimes 1000$.
- ...
- ...
- Tardo 1 hora en resolver un problema con complejidad $2^{n}$ y tamaño N6. Si ahora tengo una maquina 1000 veces mas rapida, voy a tardar 1 hora en resolver **el mismo problema** pero ahora de tamaño N6 + 9.97.
> Que queremos sacar de todo esto? No importa que tan buena sea la maquina, la complejidad exponencial es HORRIBLE. Una maquina 1000 veces mas rapida nos resuelve el **mismo problema** y un poco mas. Comparar con el lineal o cuadratico donde podemos resolver problemas con entradas mas grandes en la misma cantidad de tiempo.

![[Pasted image 20230820054507.png]]
Polinomial = "Bueno"
Exponencial = "Malo"
> En algunos libros a la complejidad *factorial* se la considera del grupo de las exponenciales, o sea, mala!