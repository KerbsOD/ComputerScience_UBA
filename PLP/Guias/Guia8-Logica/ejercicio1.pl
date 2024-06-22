padre(juan, carlos).
padre(juan, luis).

padre(carlos, daniel).
padre(carlos, diego).

padre(luis, pablo).
padre(luis, manuel).
padre(luis, ramiro).

abuelo(X,Y) :- padre(X,Z), padre(Z,Y).

% 1. Luis.

% 2.
hijo(X, Y) :- padre(Y, X).

hermano(X, Y) :- padre(Z, X), padre(Z, Y), X \= Y.

descendiente(X,Y) :- hijo(X, Y).
descendiente(X,Y) :- hijo(X, Z), descendiente(Z,Y).

% 4. nietos de juan -> abuelo(juan, X).

% 5. hermano(pablo, X)

% 6
% ancestro(X, X).
% ancestro(X, Y) :- ancestro(Z, Y), padre(X, Z).

% 7. ancestro(juan, A)
% Se instancia A = Juan porque X instancia con juan y X unifica con A. Luego se pasa a la segunda regla.
% Se instanica X con juan y se unifica Z con Y por la primer regla (luego del paso recursivo). En padre se buscan a 
% todos los hijos de juan, como Z esta unificado con Y, luego el Y de ancestro se instancia como los hijos de juan.
% Como ya se resolvio padre(X,Z) se vuelve a ancestro(Z,Y) pero a la segunda regla (en la primera regla habiamos
% unificado Z con Y). Al entrar en la segunda regla se entra con X = algun hijo de juan y se empieza nuevamente a buscar
% a sus descendientes. El problema es que cuando llego a ramiro, se vuelve a ancestro(Z, Y) donde Z e Y son Ramiro.
% Luego en la segunda regla se buscan a los descendientes de ramiro recursivamente hasta el inifinito

% 8.
ancestro(X, Y) :- padre(X, Y).
ancestro(X, Y) :- padre(Z, Y), ancestro(X, Z).


