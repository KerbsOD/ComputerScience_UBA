%Definir el predicado corteMásParejo(+L,-L1,-L2) que, dada una lista de números, realiza el corte más parejo
%posible con respecto a la suma de sus elementos (puede haber más de un resultado)
%%corteMásParejo([1,2,3,4,2],L1,L2). → L1 = [1, 2, 3], L2 = [4, 2] ; false.
%%corteMásParejo([1,2,1],L1,L2). → L1 = [1], L2 = [2, 1] ; L1 = [1, 2], L2 = [1] ; false.

%% corteMásParejo(+L,-L1,-L2)
corteMasParejo(L,L1,L2) :- append(L1, L2, L), sum_list(L1,S1), sum_list(L2,S2), D is abs(S1-S2),
    not((existeDiferenciaMenor(L, _, _, D3), D3 < D)).

existeDiferenciaMenor(L, L1, L2, D3) :- append(L1, L2, L), sum_list(L1, SA), sum_list(L2, SB), D3 is abs(SA-SB).


% Cuando hice el ejercicio lo escribi como: 

%corteMasParejo(L,L1,L2) :- 
%    append(L1, L2, L), 
%    sum_list(L1,S1), 
%    sum_list(L2,S2), 
%    D is abs(S1-S2),
%    not((existeDiferenciaMenor(L1, L2, D2), D2 < D)).

% existeDiferenciaMenor(L1, L2, D) :- sum_list(L1, S1), sum_list(L2, S2), D is abs(S1-S2).

% El problema de esta resolucion es que siempre estas usando las mismas L1 y L2 con las que calculaste D para calcular
% D2. Entonces como ambos son el mismo numero, "not((existeDiferenciaMenor(L1, L2, D2), D2 < D))" es true para todas 
% las listas. Porque al ser D2 = D, D2 < D es false, entonces el not devuelve true (no existe un D2 que sea menor a D porque
% siempre es igual).