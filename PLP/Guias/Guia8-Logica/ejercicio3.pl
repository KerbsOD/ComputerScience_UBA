natural(0).
natural(suc(X)) :- natural(X).

menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).
menorOIgual(X,X) :- natural(X).

% 1) menorOIgual(0,X').
% Se instancia X con 0 y X' con suc(Y). Luego se llama menorOIgual(0, Y). Ocurre nuevamente, se hacen llamadas 
% recursivas infinitamente.

% 2) Ocurre cuando una variablle no se instancia, si no que se unifica en el mismo lugar con una variable nueva en cada
% consulta.

menorOIgualDos(X, X) :- natural(X).
menorOIgualDos(X, suc(Y)) :- menorOIgualDos(X, Y).