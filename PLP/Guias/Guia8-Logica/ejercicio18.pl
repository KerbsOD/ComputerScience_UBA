%i. Sean los predicados P(?X) y Q(?X), ¿qué significa la respuesta a la siguiente consulta? ?- P(Y), not(Q(Y)).
% Quiero ver un instancia de Y donde existe instanciacion en P pero no existe en Q. Primero se busca una en P y luego
% vemos que en Q no es resolvente.

caliente(tacos).
caliente(salsa).
fresco(ensalada).
fresco(agua).

% ?- fresco(Y), not(caliente(Y)).

%ii. ¿Qué pasaría si se invirtiera el orden de los literales en la consulta anterior?
% Si consultamos "not(caliente(Y)), fresco(Y)" prolog vaa a ver si NO EXISTE instanciacion de Y que haga verdadero
% a caliente. Como Y = tacos es resolvente entonces se encontro una instanciacion de Y, por ende not(caliente(Y)) es false
% y no se llega  consultar fresco(Y).

% Si eliminamos las entradas de caliente(tacos) y caliente(salsa) entonces prolog falla porque no existen en la base
% de conocimientos.

%iii. Sea el predicado P(?X), ¿Cómo se puede usar el not para determinar si existe una única Y tal que P(?Y)
%es verdadero?

planeta(tierra).

unico(X) :- planeta(X), not( unicoAux(X) ).

unicoAux(X) :- planeta(Y), Y \= X.

% Instanicamos X = Tierra, luego chequeamos si existe otro planeta tal que x sea diferente. Tuve que hacerlo en una
% regla aparte porque el not no permite clausulas.

% Corrigiendo luego dde hacer el 19.

auto(lexus).

unico2(X) :- auto(X), not((auto(Y), Y \= X)).

