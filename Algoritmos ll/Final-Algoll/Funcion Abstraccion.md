*Abs: genero_de_representacion g  ->  genero_del_tipo_representado        {Rep(g)}*

Tiene por *dominio* al conjunto de instancias que son la imagen abstracta del tipo de representacion y que verifican el invariante de representacion, y devuelve una imagen abstracta de la instancia del tipo representado (aquella instancia que estamos pretendiendo representar). 
Recordar que "gener_de_representacion" y "genero_del_tipo_representado" tienen el sombrerito por lo que son "instancias abstractas del tipo". La secuencia "[1,2,3]" es igual a "1 $\bullet$ 2 $\bullet$ 3 $\bullet$ <>" .  

> Diremos que T representa a A si Abs(T) =obs A.

![[Pasted image 20230716034146.png]]
- No es necesariamente inyectiva. Dos estructuras son observacionalmente iguales a la misma instancia del tipo.
- No necesariamente es suryectiva sobre el conjunto de terminos de un TAD. Por la forma en la que Abs es construida no es posible diferenciar entre instancias de un TAD que son observacionalmente iguales y por lo tanto no es posible garantizar que todo termino del TAD es imagen de Abs para alguna estructura de representacion. En este caso el termino Ag(1,Ag(1,Ag(2,Ag(3, /)))) nunca va a ser imagen pues el rep pide que no haya repetidos en la secuencia de entrada.
- Debe ser sobreyectiva sobre las clases de equivalencia definidas por la igualdad observacional, al menos con respecto al universo que nos ha restringido nuestro contexto de uso. 

*Camilo*: Repasando álgebra, una clase de equivalencia parte un conjunto en subconjuntos disjuntos (ej, los Nat si se los clasifica según el mínimo primo de su factorización). La ABS tiene por dominio las instancias posibles de la estructura de representación y codominio las instancias posibles del tad. Si al codominio lo dividimos en subconjuntos usando la =obs sabemos que dentro del universo definido por nuestro contexto de uso hay un elemento de cada subconjunto que es imagen de la abs pero no necesariamente todos. De hecho, como en la ABS usamos igualdad observacional, ni siquiera podemos decir cuál elemento de cada subconjunto es imagen pq por definición de =obs es incapaz de distinguir elementos observacionalmente iguales.