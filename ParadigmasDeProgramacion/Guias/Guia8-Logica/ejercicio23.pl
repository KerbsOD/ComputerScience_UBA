%%esNodo(+G, ?X)
esNodo(grafo(V,_), X) :- ground(V), member(X, V).

%%esArista(+G,?X,?Y)
esArista(grafo(V,E), X, Y) :- ground(E), ground(V), nonvar(X), member(arista(X,Y), E).  % Dame en Y los nodos que instancian arista con X.
esArista(grafo(V,E), Y, X) :- ground(E), ground(V), nonvar(Y), member(arista(X,Y), E).  % Dame en X los nodos que instancian arista con Y.
esArista(grafo(V,E), X, Y) :- ground(E), ground(V), var(X), var(Y), member(arista(X,Y), E). % Dame todas las aristas del grafo sin repetidos. O aparece (X,Y) o aparece (Y,X).

%%caminoSimple(+G,+D,+H,?L)
caminoSimple(Grafo,Inicio,Fin,Camino) :- esNodo(Grafo,Inicio), esNodo(Grafo,Fin), Inicio \= Fin, caminoConHistorial(Grafo,Inicio,Fin,Camino,[]).
    
caminoConHistorial(_,Fin,Fin,[Fin],Historial) :- not(member(Fin,Historial)).
caminoConHistorial(Grafo,Actual,Fin,[Actual|XS],Historial) :- 
    Actual \= Fin,
    esArista(Grafo,Actual,Siguiente),
    not(member(Siguiente,Historial)),
    caminoConHistorial(Grafo,Siguiente,Fin,XS,[Actual|Historial]).

% caminoHamiltoniano(+G,?L) - Existe un camino L tal que no existe otro camino que tenga una longitud mayor.
caminoHamiltoniano(Grafo,L) :- caminoSimple(Grafo,_,_,L), length(L,N), not((caminoSimple(Grafo,_,_,L2), length(L2,N2), N2 > N)).

%esConexo(+G) - No existe un par de nodos tal que no haya camino entre ellos
esConexo(G) :- not((esNodo(G,X), esNodo(G,Y), X \= Y, not( caminoSimple(G,X,Y,_) ))).

%esEstrella(+G) - Para toda arista, hay un nodo en comun. No existe una arista tal que ambos de sus nodos sean diferentes al resto de aristas.
esEstrella(G) :- esConexo(G), not((esArista(G,X,Y), esArista(G,Z,W), X \= Z, Y \= W, X \= W, Y \= Z)).

%% Ejemplos.
grafoGen(0, grafo([], [])).
grafoGen(1, grafo([1,2,3], [])).
grafoGen(2, grafo([1,2,3], [arista(1,2), arista(2,3)])).
grafoGen(conexo, 
    grafo(
        [1, 2, 3, 4, 5],
        [arista(1, 2), arista(2, 3), arista(2, 4), arista(3, 5),arista(4, 5)]
    )
).
grafoGen(disconexo, 
    grafo(
        [1, 2, 3, 4, 5, 6, 7],
        [arista(1, 2), arista(2, 3), arista(2, 4), arista(3, 5),arista(4, 5), arista(6,7)]
    )
).

grafoGen(estrella, 
    grafo(
        [1, 2, 3, 4, 5, 6, 7],
        [arista(1, 2), arista(1, 3), arista(1, 4), arista(1, 5),arista(1, 6), arista(1,7)]
    )
).