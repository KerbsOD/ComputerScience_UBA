%%esNodo(+G, ?X)
esNodo(grafo(V,_), X) :- ground(V), member(X, V).

%%esArista(+G,?X,?Y)
esArista(grafo(V,E), X, Y) :- ground(E), ground(V), member(arista(X,Y), E).
esArista(grafo(V,E), Y, X) :- ground(E), ground(V), nonvar(X), nonvar(Y), member(arista(X,Y), E). 
% solo preguntamos la inversa cuando nos dan la arista, caso contrario se va a instanciar en X y en Y ambos lados. 

%%caminoSimple(+G,+D,+H,?L)
caminoSimple(G, D, H, L) :- 
    ground(G),
    append([D],_,L),
    append(_,[H],L),
    caminoDeAristas(G, L).


caminoDeAristas(_,[]).
caminoDeAristas(_,[_ | []]).
caminoDeAristas(G, [X |[Y | LS]]) :- esNodo(G,X), esNodo(G,Y), esArista(G,X,Y), caminoDeAristas(G,[Y|LS]). 

% Como aristas se comporta diferente para instanciar que para preguntar, si X e Y no estan instanciadas
% (en este caso las instanciamos con esNodo), entonces se van a tratar de instanciar EN UN SOLO SENTIDO.
% Porque asi lo definimos, si queremos instanciar se hace en un sentido arbitrario. Si queremos consultar
% funciona en ambos sentidos. El problema es que si instanciamos en un solo sentido, existen caminos que la
% consulta no tiene en cuenta.

%% Ejemplos.
grafoGen(0, grafo([], [])).
grafoGen(1, grafo([1,2,3], [])).
grafoGen(2, grafo([1,2,3], [arista(1,2), arista(2,3)])).


