doble x = 2 * x
suma x y = x + y


normaVectorial a b = sqrt(a^2 + b^2)

c _ = 8

f n | n >= 3 = 5
    | n == 0 = -1
    | otherwise = 6

-- Signo Normal    
signo n | n > 0 = 1
        | n == 0 = 0
        | n < 0 = -1
        
-- Signo PM
sign1 0 = 0
sign1 n | n > 0 = 1
        | otherwise = -1
        
-- Comparación
maximo x y | x < y = y
           | otherwise = x
           
-- Si ponemos de parametro n = 1.3, nos tira error. Si ponemos 3.4 nos da 5. (f2)
f2 n | n >= 3 = 5
     | n <= 1 = 8 

-- Cuadrática
cuad b c | b^2 - 4 * c > 0 = 2
         | b^2 - 4 * c == 0 = 1
         | otherwise = 0

-- EsPAr 2 formas de definirlo
esPar :: Int -> Bool
esPar n | mod n 2 == 0 = True
        | otherwise = False
        
esPar2 :: Int -> Bool
esPar2 n = mod n 2 == 0

-- Funcion Rara
funcionRara :: Float -> Float -> Bool -> Bool
funcionRara x y z = (x >= y) || z -- FALSO O VERDADERO = VERDADERO. VERDADERO O VERDADERO = VERDADERO. FALSO O FALSO = FALSO

funcionRara2 :: Float -> Float -> Bool -> Bool
funcionRara2 x y True = True
funcionRara2 x y False = x >= y




-- EJERCICIOS ------------------------------

absoluto :: Int -> Int
absoluto n | n > 0 = n
           | otherwise = n * (-1)

maximoAbsoluto :: Int -> Int -> Int
maximoAbsoluto x y | absoluto(x) > absoluto(y) = absoluto(x)
                   | otherwise = absoluto(y)
                   
maximo3 :: Int -> Int -> Int -> Int
maximo3 x y z | x > y && x > z = x
              | y > x && y > z = y
              | otherwise = z
              
algunoEs0 :: Float -> Float -> Bool
algunoEs0 x y | x == 0 || y == 0 = True
              | otherwise = False

algunoEs02 :: Float -> Float -> Bool
algunoEs02 0 _ = True
algunoEs02 _ 0 = True
algunoEs02 _ _ = False

ambosSon0 :: Float -> Float -> Bool
ambosSon0 x y | x == 0 && y == 0 = True
              | otherwise = False
              
ambosSon02 :: Float -> Float -> Bool      
ambosSon02 0 0 = True
ambosSon02 0 y = False
ambosSon02 x 0 = False

esMultiploDe :: Int -> Int -> Bool
esMultiploDe x y | mod x y == 0 = True
                 | otherwise = False
                 
digitoUnidades :: Int -> Int
digitoUnidades x = mod x 10

digitoDecenas :: Int -> Int
digitoDecenas x = div((mod x 100) - digitoUnidades(x)) 10





