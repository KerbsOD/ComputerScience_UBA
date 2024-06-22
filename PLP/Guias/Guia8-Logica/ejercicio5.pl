%last(?L, ?U)
last(L, U) :- append(_, [U], L).

%reverse(+L, -L1)
reverse([], []).
reverse([X | XS], L) :- reverse(XS, L1), append(L1, [X], L).

%prefijo(?P, +L)
prefijo(P, L) :- append(P, _, L).

%sufijo(?S, +L)
sufijo(S, L) :- append(_, S, L).

%sublista(?S, +L) % S = [c, d]. L = [a, b, c, d, e]. 
sublista([], _).
sublista(S, L) :- prefijo(P, L), sufijo(S, P).

%pertenece(?X, +L)
pertenece(X, L) :- sublista([X], L).
