%%esNodo(+G, ?X)
esNodo(grafo(V,_), X) :- ground(V), member(X, V).

%%esArista(+G,?X,?Y)
esArista(grafo(_,E), X, Y) :- member(arista(X,Y), E).
esArista(grafo(_,E), Y, X) :- nonvar(X), nonvar(Y), member(arista(X,Y), E). 
% solo preguntamos la inversa cuando nos dan la arista, caso contrario se va a instanciar en X y en Y ambos lados. 

%%caminoSimple(+G,+D,+H,?L)
caminoSimple(G, D, H, L) :- 
    ground(G),
    append([D],_,L),
    append(_,[H],L).    

%% Ejemplos.
grafoGen(0, grafo([], [])).
grafoGen(1, grafo([1,2,3], [])).
grafoGen(2, grafo([1,2,3], [arista(1,2), arista(2,3)])).


