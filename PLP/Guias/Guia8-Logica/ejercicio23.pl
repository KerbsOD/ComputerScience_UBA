%%esNodo(+G, ?X)
esNodo(grafo([V | _],_), V).
esNodo(grafo([_ | VS],_), X) :- esNodo(grafo(VS,_),X).

%%esArista(+G,?X,?Y)
esArista(grafo(_, [arista(E1,E2) | _]), X, Y) :- var(X), var(Y), X = E1, Y = E2.
esArista(grafo(_, [arista(E1,E2) | _]), X, Y) :- nonvar(X), nonvar(Y), X is E1, Y is E2.
esArista(grafo(_, [arista(E1,E2) | _]), Y, X) :- nonvar(X), nonvar(Y), X is E1, Y is E2.
esArista(grafo(V, [_ | ES]), X, Y) :- esNodo(grafo(V, _), X), esNodo(grafo(V, _), Y), esArista(grafo(V,ES),X,Y).

