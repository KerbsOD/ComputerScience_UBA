%aplanar(+Xs, -Ys)
aplanar([], []).
aplanar([ZS | XS], YS) :- aplanar(ZS, AS), aplanar(XS, RS), append(AS, RS, YS). 
aplanar([X | XS], [X | YS])  :- not( aplanar(X, _) ), aplanar(XS, YS).