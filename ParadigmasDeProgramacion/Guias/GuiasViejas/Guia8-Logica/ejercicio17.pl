frutal(frutilla).
frutal(banana).
frutal(manzana).

cremoso(banana).
cremoso(americana).
cremoso(frutilla).
cremoso(dulceDeLeche).

leGusta(X) :- frutal(X), cremoso(X), !.

cucurucho(X,Y) :- leGusta(X), leGusta(Y).

% ?- cucurucho(X,Y)
% Se unifica con las variables de leGusta(X) y leGusta(Y).
% en leGusta(X), X unifica con la variable de frutal y la de cremoso
% X de frutal es instanciado como frutilla.
% X de cremoso es resolvente con cremoso(frutilla).
% X de leGusta se instancia como frutilla.
% X de cucurucho se instancia con frutilla,
% se puede instanciar lo mismo con Y.
% Se empieza a hacer backracking con respecto a Y, dejamos de instanciar la Y como frutilla e instaanciamos un nuevo
% frutal, el sigueinte es banana. Despues de banana , como es resolvente con cremoso(banana), se instancia en cucurucho.
% como no existe otro frutal que sea cremoso, se hace backtracking de y se prueba una nueva instanciacion de X.

% 2. 

% cucurucho(X,Y) :- leGusta(X), !, leGusta(Y).
% Si leGusta(X) encuentra alguna instancia para X entonces se sigue para adelante y no se buscan mas instancias.
% es como una pared que separa la instanciacion actual de mas instanciaciones.

% cucurucho(X,Y) :- leGusta(X), leGusta(Y), !.
% Si leGusta(X) encuentra alguna instancia para X y leGusta(Y) encuentra una para Y entonces listo, terminamos.

% leGusta(X) :- frutal(X), !, cremoso(X).
% despues de un frutal solo vemos si es cremoso.

% leGusta(X) :- frutal(X), cremoso(X), !.
% despues de un frutal y cremoso terminamos, solo queremos uno.