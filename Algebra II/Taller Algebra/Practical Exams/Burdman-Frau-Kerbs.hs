--Determina, para un numero natural n, si la secuencia de Collatz converge a 1 en menos de m pasos  
satisfaceCollatz :: Integer -> Integer -> Bool
satisfaceCollatz 1 m = True
satisfaceCollatz n 0 = False
satisfaceCollatz n m | mod n 2 == 0 = satisfaceCollatz (div n 2) (m-1)
                     | otherwise = satisfaceCollatz (3*n + 1) (m-1)

--Determina, para todos los numeros naturales menores o iguales a n, si la secuencia de collatz converge a 1 en menos de m pasos
satisfaceCollatzHasta :: Integer -> Integer -> Bool
satisfaceCollatzHasta 1 m = True
satisfaceCollatzHasta n m | satisfaceCollatz n m = satisfaceCollatzHasta (n-1) m
                          | otherwise = False
                          
--Determina si la secuencia de Collatz es verdadera para un número n
cumpleCollatz :: Integer -> Bool
cumpleCollatz 1 = True
cumpleCollatz n | mod n 2 == 0 = cumpleCollatz (div n 2)
                | mod n 2 == 1 = cumpleCollatz (3*n + 1)
                | otherwise = False
 
--Determina si un rango de números entre 1 y n cumple con la secuencia de Collatz         
cumplenCollatz :: Integer -> Bool
cumplenCollatz 1 = True
cumplenCollatz n | cumpleCollatz n = cumplenCollatz (n-1)
                 | otherwise = False


   
--Evalua la cantidad de términos pares que aparecen en la secuencia de Collatz de un número natural n                         
cantidadTerminosPares :: Integer -> Integer
cantidadTerminosPares 1 = 0
cantidadTerminosPares n | cumpleCollatz n == False = undefined
                        | mod n 2 == 0 = 1 + cantidadTerminosPares (div n 2)
                        | otherwise = cantidadTerminosPares (3*n + 1)

--Evalua la cantidad total de términos que aparecen en la secuencia de Collatz de un número natural n
largoSecuencia :: Integer -> Integer
largoSecuencia 1 = 0
largoSecuencia n | cumpleCollatz n == False = undefined
                 | mod n 2 == 0 = 1 + largoSecuencia (div n 2)
                 | otherwise = 1 + largoSecuencia (3*n + 1)

--Determina cual es la secuencia más larga en el rango entre n y m (funnción auxiliar)     
secuenciaMasLargaEntre :: Integer -> Integer -> Integer
secuenciaMasLargaEntre n m | n == m = n
                           | largoSecuencia n >= largoSecuencia m = secuenciaMasLargaEntre n (m-1)
                           | otherwise = secuenciaMasLargaEntre (n+1) m

--Determina cual es la secuencia más larga en el rango entre 1 y n
secuenciaMasLargaHasta :: Integer -> Integer
secuenciaMasLargaHasta 1 = 1
secuenciaMasLargaHasta n | cumplenCollatz n == False = undefined-
                         | otherwise = secuenciaMasLargaEntre 1 n
