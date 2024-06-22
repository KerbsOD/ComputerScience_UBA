%intersección(+L1, +L2, -L3)
interseccion([], _, []).
interseccion([X | XS], L2, L3) :- not(member(X, L2)), interseccion(XS, L2, L3).
interseccion([X | XS], L2, [X | L3]) :- member(X, L2), borrar(X, XS, L), interseccion(L, L2, L3).

%partir(?N, ?L, ?L1, ?L2)
partir(0, L, [], L).
partir(N, [X | L], [X | L1], L2) :- partir(N2, L, L1, L2), N is N2+1. 

%borrar(+ListaOriginal, +X, -ListaSinXs)
borrar([], _, []).
borrar([X | XS], X, YS) :- borrar(XS, X, YS).
borrar([Y | XS], X, [Y | YS]) :- Y \= X, borrar(XS, X, YS).

%sacarDuplicados(+L1, -L2)
sacarDuplicados([], []).
sacarDuplicados([X | L1], [X | L2]) :- borrar(L1, X, L3), sacarDuplicados(L3, L2).

%permutación(+L1, ?L2)
permutacion([], []).
permutacion()
