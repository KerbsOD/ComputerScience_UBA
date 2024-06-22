%last(?L, ?U)
last(L, U) :- append(_, [U], L).

%reverse(+L, -L1)
reverse([X | XS], L) :- append([XS], [X], L)