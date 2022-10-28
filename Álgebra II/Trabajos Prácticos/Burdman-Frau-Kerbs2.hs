type Polinomio = [Float]
type Monomio = (Float, Int)



--A partir de una lista de numeros reales, genera el polinomio borrando todos los coeficientes nulos iniciales.
crearPolinomio :: [Float] -> Polinomio
crearPolinomio [] = [] --Caso base : Todos los coeficientes son nulos. Devuelve 0
crearPolinomio (x:xs) | x /= 0 = (x:xs) --Caso base : se encuentra el primer coeficiente no nulo de la lista. Devuelve la lista a partir de este coeficiente
                      | otherwise = crearPolinomio xs --Paso inductivo: El coeficiente evaluado es 0 : Crea un polinomio con el tail de la lista.
                      


--Devuelve el grado de un polinomio. Usada como auxiliar para los siguientes ejercicios.
grado :: Polinomio -> Int
grado [] = undefined --Caso base 1 : El polinomio es vacio. Devuelve undefined
grado (x:xs) | xs == [] = 0 --Caso base 2 : El último indice de una lista no vacia. Devuelve 0
             | otherwise = 1 + grado xs --Paso inductivo : no estamos en el ultimo indice de la lista. Devuelve el grado del tail de la lista y suma 1



--Evalua el valor de un polinomio para un a real dado
evaluar :: Polinomio -> Float -> Float
evaluar [] _ = 0 --Excepción: evalúa un valor real a en un polinomio vacio: devuelve 0
evaluar (x:xs) a | xs == [] = x --Caso base : se evalua un polinomio de grado 0, es decir, una constante
                 | otherwise = x*(a^grado(x:xs)) + evaluar xs a --Paso inductivo : evalua a en un monomio y lo suma a la evaluación del polinomio restante



--Función Auxiliar. Crea una lista de n ceros. 
agregarCeros :: Int -> [Float]
agregarCeros 0 = [] --Caso base: no hay mas ceros para agregar. Devuelve lista vacía.
agregarCeros n = 0 : agregarCeros (n-1) --Paso inductivo: agrega un cero a la lista y resta 1 a n



--Evalua el producto de un monomio por un polinomio
productoPorMonomio :: Monomio -> Polinomio -> Polinomio
productoPorMonomio (a,n) [] = [] --Excepción: Se multiplica el monomio por un polinomio vacio. Devuelve el polinomio vacío
productoPorMonomio (a,n) (x:xs) | xs == [] = a*x : agregarCeros n --Caso Base: ya multiplicamos todos los terminos excepto uno del polinomio por el coeficiente del monomio. Falta tener en cuenta la suma de potencias, por lo que agrego n ceros al final de la lista 
                                | otherwise = a*x : productoPorMonomio (a,n) xs --Paso inductivo : Multiplica el monomio por un termino del polinomio 



--Multiplica 2 polinomios
producto :: Polinomio -> Polinomio -> Polinomio
producto p q | p == [] || q == [] = [] 
             | tail p == [] = productoPorMonomio (head p,0) q 
             | otherwise = sumaPolinomios (productoPorMonomio (head p,g) q, producto (tail p) q) 
             where g = grado p

--Suma dos polinomios. Función auxiliar para "producto"
sumaPolinomios :: (Polinomio,Polinomio) -> Polinomio
sumaPolinomios (p,q) | p == [] || q == [] = [] 
sumaPolinomios (p,q) | grado p < grado q = head q : sumaPolinomios (p,tail q) 
                     | grado p > grado q = head p : sumaPolinomios (tail p,q)
                     | otherwise = (head p + head q) : sumaPolinomios (tail p, tail q) 



--Evalua la longitud de una lista comenzando en 0                   
longitudMenosUno :: [Float] -> Int
longitudMenosUno (x:xs) | xs == [] = 0
                        | otherwise = 1 + longitudMenosUno xs
                


--Es complicado. Leer el enunciado.                
evaluacionMultiple :: [Float] -> Polinomio -> Polinomio -> [Float]
evaluacionMultiple [] p q = [] --Caso base: Si no quedan más elementos en la lista, devuelve la lista vacia
evaluacionMultiple (x:xs) p q | mod l 2 == 0 = evaluar p x : evaluacionMultiple xs p q --Paso inductivo 1: si la posicion l de la lista es "par", evalúa el valor en p y lo anexa al resto de la lista
                              | otherwise = evaluar q x : evaluacionMultiple xs p q --Paso inductivo 2: si la posición l de la lista es "impar", evalúa el valor en q y lo anexa al resto de la lista
                              where l = longitudMenosUno (x:xs)
                              
                              
                              
                              
