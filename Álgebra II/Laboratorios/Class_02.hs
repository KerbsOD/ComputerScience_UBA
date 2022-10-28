--Identidad
identidad :: t -> t
identidad x = x

--Primero
primero :: tx -> ty -> tx
primero x y = x

--Segundo
segundo :: tx -> ty -> ty
segundo x y = y

--Constante
constante5 :: tx -> ty -> tz -> Int
constante5 x y z = 5

--Mismo Tipo
mismoTipo :: t -> t -> Bool
mismoTipo x y = True

--Triple
triple x = 3 * x

--Maximo
maximo x y | x >= y = x
           | otherwise = y
           
--Distintos
distintos x y | x == y = True
              | otherwise = False

--Cuando pregunto el tipo de una funcion, esta puede pertenecer a una clase. 
--Solo puedo definir con variables de tipo cuando es una funcion definida.

triple2 :: (Num t ) => t -> t
triple2 x = 3*x

maximo2 :: ( Ord t ) => t -> t -> t
maximo2 x y | x >= y = x
            | otherwise = y
           
distintos2 :: (Eq t) => t -> t -> Bool
distintos2 x y = x /= y

cantidadDeSoluciones :: (Num t, Ord t) => t -> t -> Int
cantidadDeSoluciones b c | d > 0 = 2
                         | d == 0 = 1
                         | otherwise = 0
    where d = b*b - 4* c
    
pepe :: (Floating t, Eq t, Num u, Eq u) => t -> t -> u -> Bool
pepe x y z = sqrt(x + y) == x && 3*z == 0
    
    
--Ejercitación Conjunta

f1 x y z = x**y + z <= x+y**z
    
f2 x y = (sqrt x) / (sqrt y)

f3 x y = div (sqrt x) (sqrt y)

f4 x y z | x == y = z
         | x ** y == y = x
         | otherwise = y
         
f5 x y z | x == y = z
         | x ** y == y = z
         | otherwise = z

--Tuplas (Aplicación de ejemplo: Vectores.)
suma :: (Float, Float) -> (Float, Float) -> (Float, Float) 
suma v w = ((fst v) + (fst w), (snd v) + (snd w))

--PM
--suma2 (vx, vy) (wx, wy) = (vx +wx. vy + wy)

--Angulo
esAngulo45 :: (Float, Float) -> Bool
esAngulo45 (x, y) = x == y 

--Ejercicios-----------------------------------------------------------------

--A
estanRelacionados :: Float -> Float -> Bool
estanRelacionados a b | a <= 3 && b <= 3 = True
                      | (a > 3 && a <= 7) && (b > 3 && b <= 7) = True  
                      | a > 7 && b > 7 = True
                      | otherwise = False

estanRelacionados2 :: Float -> Float -> Bool
estanRelacionados2 a b = (a <= 3 && b <= 3) || ((a > 3 && a <= 7) && (b > 3 && b <= 7)) || (a > 7 && b > 7)

--B---------------------
prodInt :: (Int, Int) -> (Int, Int) -> Int
prodInt (x, y) (c, d) = x * c + y * d


--C---------------------
todoMenor :: (Int, Int) -> (Int, Int) -> Bool
todoMenor (x, y) (c, d) | (x < c && y < d) = True
                        | otherwise = False

                        
--D---------------------
distanciaPuntos :: (Float, Float) -> (Float, Float) -> Float
distanciaPuntos (x, y) (c, d) = sqrt((c - x)**2 + (d - y)**2)


--E---------------------
sumaTerna :: (Int, Int, Int) -> Int
sumaTerna (a, b, c) = a + b + c 


--F---------------------
posicPrimerPar :: (Int, Int, Int) -> Int
posicPrimerPar (a, b, c) | mod a 2 == 0 = 0
                         | mod b 2 == 0 = 1
                         | mod c 2 == 0 = 2 
                         | otherwise = 4

                         
--G---------------------
crearPar :: a -> b -> (a,b)
crearPar a b = (a, b)


--H---------------------
invertir :: (a,b) -> (b,a)
invertir (a, b) = (b, a)



























    
    
    
    
    
    
