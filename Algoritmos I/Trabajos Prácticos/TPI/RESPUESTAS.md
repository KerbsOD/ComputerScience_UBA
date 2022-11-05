% Contesten aquí la pregunta sobre complejidad

### Jugadas del tipo nXn:
Seria como un tablero pero con las posiciones jugadas y no jugadas. 
En el tablero ya sabemos donde se ubica cada bomba, en jugadas no.

### JugarPlus: 
"JugarPlus" es de complejidad O(n^2).
En "jugarPlus" usamos la estructura "Jugadas", para buscar una 
jugada en esta con la función "perteneceAJugadas()" que es de complejidad O(n) en caso de que la jugada esté en la posoción n del vector, 
ademas de que pueden haber infinitas posiciones libres por lo que al final del primer while, se agregarian mas posiciones para revisar.
Si "Jugadas" fuera una matriz, deberíamos buscar por fila
y por columna (nxn) en un 'tablero' cuadrado. Tenemos entonces una complejidad
O(n^3) (por ejemplo si la jugada que buscamos está en la posición Jugadas[n][n].
Siendo n = Jugadas.size())

### sugerirAutomatico121: 
SugerirAutomatico121 es O(n^3), 
pues busca (itera) en "tablero"(O(n^2)) una posicion que no esté en "banderitas"(O(n)) o "Jugadas"(O(n)). En caso de que
"Jugadas" sea una matriz nxn (n = jugadas.size()), entonces mi función "sugerirAutomatico121()" pasa 
a ser de complejidad O(n^4). Tengo 2 casos donde se itera 
por "Jugadas", en la función "esAdyacente121()" y en "esPosicionSinJugarYSinBanderita()"
pero estas ya estan contenidas dentro de la iteracion por la matriz "tablero" en "hayPosicionSugerible()",
Como mi nueva "Jugadas" contiene todas las posiciones (<pos, minas> en caso de casillero
descubierto ó <pos, (-1)> en caso de casillero no descubierto) entonces la matriz "Jugadas" tiene la
longitud (en largo y ancho) de "tablero". 
Conclusión, la iteración por tablero es de O(n^2) y en cada iteración tengo dentro
otra iteración de "EnJugadas()" de O(n^2), como n = tablero.size() = jugadas.size() queda entonces que en el peor caso
que es cuando nuestra posicion sugerida esta en Jugadas[n-1][n-1], esto implica que "jugadas" es del tipo O(n^2) y por lo tanto
la complejidad en el peor caso de "sugerirAutomatico121" es de O(n^2*O(n^2)) = O(n^4).


