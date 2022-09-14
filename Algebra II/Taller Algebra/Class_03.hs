--Factorial--
factorial :: Int-> Int
factorial n | n == 0 = 1
            | n > 0 = n * factorial (n-1)
            
factorial2 :: Int -> Int
factorial2 0 = 1
factorial2 n = n * factorial2 (n-1)

--Par--
esPar :: Int -> Bool
esPar n | n == 0 = True
        | n == 1 = False
        | otherwise =  (esPar (n-2))

--Ejercicio 1--
fibonacci :: Int -> Int
fibonacci n | n == 0 = 0
            | n == 1 = 1
            | otherwise = fibonacci(n-1) + fibonacci(n-2)
            
--Ejercicio 2--
parteEntera :: Float -> Int
parteEntera n | n < 1 && n > 0 = 0
              | otherwise = parteEntera(n - 1) + 1

--Ejercicio 3--
multi :: Int -> Bool
multi n | n == 0 = True
        | n == 1 || n == 2 = False
        | otherwise = multi(n-3) 
        
--Ejercicio 4--
sumaImpares :: Int -> Int
sumaImpares n | n == 1 = 1
              | otherwise = sumaImpares(n - 1) + (2 * n) - 1
              
--Ejercicio 5--
medioFact :: Int -> Int
medioFact n | n == 0 = 1
            | n > 0 = n * medioFact (n - 2)  
            
--Ejercicio 6--
digitos :: Int -> Int
digitos n | n <= 0 = 0
          | otherwise = digitos(div n 10) + mod n 10 

--Ejercicio 7--   
ultimoDigito :: Int -> Int
ultimoDigito n | n <= 0 = undefined
               | otherwise = mod n 10

decena :: Int -> Int 
decena n | n <= 0 = undefined
         | otherwise = mod (div n 10) 10

iguales :: Int -> Bool
iguales n | n < 10 = True
          | otherwise = iguales (div n 10) && ultimoDigito n == decena n