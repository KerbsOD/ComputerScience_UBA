%Dado un predicado unario P sobre números naturales, definir un predicado que determine el mínimo X que
%satisfaga P(X).
desde(X,X).
desde(X,Y) :- var(Y), N is X+1, desde(N,Y).
desde(X,Y) :- nonvar(Y), X < Y.

par(X) :- mod(X, 2) =:= 0.

minimo(P, X) :- desde(1, X), call(P, X), !.

%% consultamos con minimo(par, X).