desde(X,X).
desde(X,Y) :- N is X+1, desde(N,Y).

nodos(nil,0).
nodos(bin(I,_,D),N) :- N > 0, N1 is N-1, between(0,N1,NI), ND is N1 - NI, nodos(I,NI), nodos(D,ND).

arbol(AB) :- desde(0,X), nodos(AB,X).

nodosEn(nil,_).
nodosEn(bin(I,R,D), L) :- member(R,L), nodosEn(I,L), nodosEn(D,L).

arbolAcotado(S,AB) :- between(0,S,N), nodos(AB,N).

sinRepEn(A,L) :- length(L,S), arbolAcotado(S,A), nodosEn(A,L), sinNodosRepetidos(L,A).

sinNodosRepetidos(L,A) :- not((member(X,L), repeticiones(X,A,N), N > 1)).

repeticiones(_,nil,0).
repeticiones(X, bin(I,X,D), N) :- repeticiones(X,I,NI), repeticiones(X,D,ND), N is 1+NI+ND.
repeticiones(X, bin(I,R,D), N) :- X \= R, repeticiones(X,I,NI), repeticiones(X,D,ND), N is NI+ND.

% bin(bin(nil, ka, bin(nil, chau, nil)), pow, nil) ;

