%desde(+X,-Y)
desde(X, X).
desde(X, Y) :- N is X+1, desde(N, Y).

%%%%%%%%%%%%%%%  1  %%%%%%%%%%%%%%%%%%%%

%cuadradoSemiLatino(+N, ?XSS)
cuadradoSemiLatino(N, XSS):- length(XSS, N), desde(0, S), cuadradoSemiLatinoAux(N, N, XSS, S).

%cuadradoSemiLatinoAux(+M, +N, ?XSS, +S)
cuadradoSemiLatinoAux(_, 0, [], _).
cuadradoSemiLatinoAux(M, N, [XS | XSS], S) :- N2 is N-1, listasQueSuman(XS, S, M), cuadradoSemiLatinoAux(M, N2, XSS, S).

%listasQueSuman(?L, ?S, +N)
listasQueSuman([], 0, 0).
listasQueSuman([X | XS], S, N) :- between(0, S, X), S2 is S-X, N2 is N-1, length(XS, N2), listasQueSuman(XS, S2, N2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%  2  %%%%%%%%%%%%%%%%%%%%

%iesimo(?I, +L, -X)
iesimo(0, [X | _], X).
iesimo(I, [_ | XS], X) :- iesimo(I2, XS, X), I is I2 + 1.

%cuadradoMagico(+N, -XS)
cuadradoMagico(N, XSS) :- cuadradoSemiLatino(N, XSS), columnasSumanLoMismo(XSS).

%columnasSumanLoMismo(+XSS)
columnasSumanLoMismo(XSS) :- length(XSS, Y), Y2 is Y-1, sumarColumna(0, XSS, Acc), between(1, Y2, I), sumarColumna(I, XSS, Acc).

%sumarColumna(+I, +XSS, ?Acc)
sumarColumna(_, [], 0).
sumarColumna(I, [XS | XSS], Acc) :- iesimo(I, XS, X), sumarColumna(I, XSS, Acc2), Acc is Acc2 + X.





