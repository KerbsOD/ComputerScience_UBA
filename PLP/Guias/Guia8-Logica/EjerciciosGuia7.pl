natural(cero).
natural(suc(X)) :- natural(X).
mayorOIgual(X,X) :- natural(X).
mayorOIgual(suc(X),Y) :- mayorOIgual(X, Y).



