%desde(+X,-Y)
desde(X, X).
desde(X, Y) :- N is X+1, desde(N, Y).

%generate(?X, ?Y)
generate(X, Y) :- desde(0,Suma), between(0,Suma,X), Y is Suma-X.

%coprimos(-X,-Y)
coprimos(X, Y) :- generate(X, Y), gcd(X,Y) =:= 1.