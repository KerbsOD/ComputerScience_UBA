% vecino(+X, +Y, -Ls)
vecino(X, Y, [_ | Ls]) :- vecino(X,Y,Ls).
vecino(X, Y, [X | [Y | _]]).

% vecino(5, Y, [5,6,5,3]).

% Los resultados son los mismos pero en diferente orden. Primero se instancia X con 5, Y se unifica con Y, se ignora 
% el primer 5 y se salta a buscar vecino(5, Y, [6,5,3]). Como es SLD, se hace resolucion con el resovente del goal actual.
% nuevamente se salta a la primera regla, etc, etc hasta llegar al arreglo con 1 elemento que no es 5. 
% Se vuelve para atras (backtracking) y si el elemento actualmente en la lista es un 5 y NO es el ultimo elemento entonces
% matchea con vecino y el elemento a la derecha sera la instanciacion de Y.

