% desde(+X, ?Y)
desde(X,X).
desde(X, Y) :- nonvar(Y), Y > X.
desde(X, Y) :- var(Y), N is X+1, desde(N, Y).

par(X) :- X mod 2 =:= 0.

% pmq(+X, -Y)
pmq(X, X) :- par(X).
pmq(X, Y) :- N is X-1, N >= 0, pmq(N, Y).

armarPares(X, Y) :- desde(1, X), between(0, X, Y).



