%desde(+X, ?Y)
desde(X,X).
desde(X,Y) :- N is X+1, desde(N,Y).

% 1. desde(10,9) produce un error porque primero da false y luego se llama a desde(11, 9), luego desde(12,9). Como nunca 
% da error que 9 sea menor a X entonces se hacen llamadas inifnitas. Debe instanciarse con X = numero e Y puede ser una
% variable o un numero mayor a X.

% desde2(+X,?Y)
desde2(X,X).
desde2(X,Y) :- var(Y), N is X+1, desde2(N, Y).
desde2(X,Y) :- nonvar(Y), X < Y.