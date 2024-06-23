%esArbol(+AB)
esArbol(nil).
esArbol(bin(Izq, _, Der)) :- esArbol(Izq), esArbol(Der).

%inorder(+AB,-Lista)
inorder(nil, []).
inorder(bin(Izq, V, Der), L) :- inorder(Izq, LI), inorder(Der, LD), append(LI, [V | LD], L).

%arbolConInorder(+Lista,-AB)
arbolConInorder([], nil).
arbolConInorder(L, bin(Izq, V, Der)) :- append(LI, [V | LD], L), arbolConInorder(LI, Izq), arbolConInorder(LD, Der).

%raiz(+AB, ?V)
raiz(bin(_, V, _), V).

%aBB(+T)
aBB(nil).
aBB(bin(nil, _, nil)).
aBB(bin(Izq, V, nil)) :- raiz(Izq, RI), RI < V, aBB(Izq). 
aBB(bin(nil, V, Der)) :- raiz(Der, RD), V < RD, aBB(Der).
aBB(bin(Izq, V, Der)) :- raiz(Izq, RI), raiz(Der, RD), RI < V, V < RD, aBB(Izq), aBB(Der).

%aBBInsertar(+X, +T1, -T2)
aBBInsertar(X, nil, bin(nil, X, nil)).
aBBInsertar(X, bin(Izq, X, Der), bin(Izq, X, Der)).
aBBInsertar(X, bin(Izq, V, Der), bin(T, V, Der)) :- X < V, aBBInsertar(X, Izq, T).
aBBInsertar(X, bin(Izq, V, Der), bin(Izq, V, T)) :- V < X, aBBInsertar(X, Der, T).

% No es reversible con respecto a X porque el < es una operacion del motor extralogico. Se podria hacer algo tipo
% "desde", donde si es una variable, le instanciamos algun valor (por ejemplo V + 1 para la derecha y V-1 para la 
% izquierda) hasta llegar a 0, el tema es que tenes problemas con respecto a la raiz y se llena el subarbol. (nodos
% repetidos pero en diferentes subarboles.)
% T1 no es reversivle porque la raiz es un numero, mismo problema con el "<".
% T2 es reversible, se puede consultar si t1 agregandole X es t2.