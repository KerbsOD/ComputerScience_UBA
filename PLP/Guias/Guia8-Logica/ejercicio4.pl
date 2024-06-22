% juntar(?Lista1,?Lista2,?Lista3)
juntar([], L2, L2).
juntar([X | XS], YS, [X | LS]) :- juntar(XS, YS, LS).
