%Contamos con una representación de conjuntos desconocida, que permite enumerar un conjunto mediante el
%predicado pertenece(?Elemento, +Conjunto). 

natural(cero).
natural(suc(X)) :- natural(X).

pertenece(E, [E | _]).
pertenece(E, [_ | XS]) :- pertenece(E, XS).

conjuntoDeNaturales([]).
conjuntoDeNaturales(X) :- not( ( pertenece(E, X), not( natural(E)) )).

%% Funciona bien cuando los elementos de X son o natural(cero) o del tipo natural(suc(X)) con X siendo un natural.
%% ?- conjuntoDeNaturales([cero, suc(cero)]). true,
%% ?- conjuntoDeNaturales([cero, suc(cero), 2]). false.

%% conjuntoDeNaturalesMalo(X) :- not( (not(natural(E)), pertenece(E,X)) )
%% No funciona porque esta viendo que NO EXISTE UN E tal que sea instancia de natural lo cual es falso. Existe cero y
%% suc(X). Por eso primero queremos siempre instanciar E, para luego chequear que no existe un predicadoo que cumpla
%% algo con respecto a la variable.