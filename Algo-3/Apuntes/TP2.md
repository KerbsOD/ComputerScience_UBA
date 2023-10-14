
## Ejercicio 3

- Considere hacer busqueda binaria para encontrar el valor optimo de:
$$ 
C = \frac{D}{R}
$$
- De que forma se puede comprobar si existe un arbol $T$ tal que:
$$
\frac{\sum\limits_{e \in T}d_{e}}{\sum\limits_{e \in T}r_{e}} \geq C
$$
$$
\Longleftrightarrow \sum\limits_{e \in T}d_{e} \geq C*\sum\limits_{e \in T}r_{e} 
$$
$$
\Longleftrightarrow \sum\limits_{e \in T}d_{e} - C*\sum\limits_{e \in T}r_{e} \geq 0 
$$
$$
\Longleftrightarrow \sum\limits_{e \in T}d_{e} - \sum\limits_{e \in T}C*r_{e} \geq 0
$$
$$
\Longleftrightarrow \sum\limits_{e \in T}d_{e} - C*r_{e} \geq 0
$$

Propuesta:
- Establecer un $MIN_C = 0.00001$ y un $MAX_{C}= 1000000$ 
- Calculamos $\sum\limits_{e \in T}d_{e} - C*r_{e}$ usando $C = (MAX_{C}+ MIN_C)/2$.
- Si la cuenta es mayor a 0 entonces $MIN_{C}= C$.
- Si la cuenta es menor a 0 entonces $MAX_{C}= C$.
- Iteramos hasta tener un error de 0.00001.







































