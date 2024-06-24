%palíndromo(+L, ?L1). 
palíndromo(L, L1) :- reverse(L, L2), append(L, L2, L1).

%iesimo(?I, +L, -X)
iesimo(0, [X | _], X).
iesimo(I, [_ | XS], X) :- iesimo(I2, XS, X), I is I2 + 1.