a) #collect: 
| x |
x := OrderedCollection new add:1;add:2;add:3;add:4;yourself.
x collect: [ :aNumber | aNumber even ].

devuelve OrderedCollection(false, true, false, true). Devuelve una lista con un closure evaluado en cada elemento del arreglo.

b) #select:
| x |
x := OrderedCollection new add:1;add:2;add:3;add:4;yourself.
x select: [ :aNumber | aNumber even ].

devuelve OrderedCollection(2, 4). Devuelve una lista con los elementos que hacen verdadero el closure.

c) #inject: into:
| x |
x := OrderedCollection new add:1;add:2;add:3;add:4;yourself.
x inject: 0 into: [ :inicial :unNumero | inicial + unNumero ].

devuelve 10. Devuelve el proceso de ejecutar el closure para caada elemento de la lista usando como acumulaor la primera variable. Le asignamos un valor inicial con inject.

d) #reduce: (o #fold:)
| x y |
x := OrderedCollection new add:'A';add:'B';add:'C';add:'D';yourself.
y := x reduce: [ :a :b | b,a ].

devuelve DCBA. Agarra los primeros n elementos que especificamos en la primera parte del closure (en este caso de a 2) siendo a y b los 
primeros 2 elementos en la primera iteracion, luego en la segunda iteracion a se vuelve el acumulado de la primera iteracion entonces se
computa a = "BA" y b = "C. Luego en la tercera iteracion a = "CBA" y b = "D". 

e) #reduceRight:
| x y |
x := OrderedCollection new add:'A';add:'B';add:'C';add:'D';yourself.
y := x reduceRight: [ :a :b | b,a ].

lo mismo pero el acumulador empieza al final.
iter1 -> a = 'A' b = 'recursivo con (B,C,D)'
iter2 -> a = 'B' b = 'recursivo con (C,D)'
iter3 -> a = 'C' b = 'recursivo con (D)'

iter2 -> a = 'B' b = 'DC'
iter1 -> a = 'A' b = 'DCB'
-> 'DCBA'

f) #do:
| x y |
x := OrderedCollection new add:1;add:2;add:3;add:4;yourself.
y := x do: [ :aNumber| x add: aNumber*2].

devuelve OrderedCollection(1,2,3,4,2,4,6,8). Es un for each