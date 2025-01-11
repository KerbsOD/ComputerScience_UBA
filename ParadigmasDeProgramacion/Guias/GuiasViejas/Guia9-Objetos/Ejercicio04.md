a) [:x | x + 1] value: 2 -> 3.
b) [|x| x := 10. x + 12] value -> 22.
c) [:x :y | |z| z := x + y] value: 1 value: 2 -> 3
d) [:x :y | x + 1] value: 1 -> error, falta instanciar el y.
e) [:x | [:y | x + 1]] value: 2 -> [:y | 2 + 1]
f) [[:x | x + 1]] value -> [:x | x + 1]
g) [:x :y :z | x + y + z] valueWithArguments: #(1 2 3) -> 6
h) [ |z| z := 10. [:x | x + z]] value value: 10 -> 20

Cuál es la diferencia entre [|x y z| x + 1] y [:x :y :z| x + 1]?
En la primer Closure las variables se inicializan cuando se evalua con value mientras que en la segunda Closure las variables hay que
instanciarlas con value: para cada variable, si no no se ejecuta x + 1.