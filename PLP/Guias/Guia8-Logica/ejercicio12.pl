%vacío(?AB)
vacio(nil).

%raiz(+AB, ?V)
raiz(bin(_, V, _), V).

%altura(+AB, ?A)
altura(bin(nil, _, nil), 0).
altura(bin(Izq, _, nil), A) :- altura(Izq, AI), A is 1+AI.
altura(bin(nil, _, Der), A) :- altura(Der, AD), A is 1+AD.
altura(bin(Izq, _, Der), A) :- altura(Izq, AI), altura(Der, AD), A is 1 + max(AI, AD).

%cantidadDeNodos(+AB, C)
cantidadDeNodos(nil, 0).
cantidadDeNodos(bin(Izq, _, Der), C) :- cantidadDeNodos(Izq, CI), cantidadDeNodos(Der, CD), C is 1 + CI + CD.