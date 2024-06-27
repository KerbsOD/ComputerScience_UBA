desde(X,X).
desde(X,Y) :- N is X+1, desde(N,Y).

nodos(nil,0).
nodos(bin(I,_,D),N) :- N > 0, N1 is N-1, between(0,N1,NI), ND is N1 - NI, nodos(I,NI), nodos(D,ND).

arbol(AB) :- desde(0,X), nodos(AB,X).
