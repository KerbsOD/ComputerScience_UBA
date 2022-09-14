
-- Suma Divisores
sumaDivisoresHasta :: Int -> Int -> Int
sumaDivisoresHasta n k | n == 0 = 1
                       | mod n k == 0 = k + sumaDivisoresHasta n (k-1)
                       | otherwise = sumaDivisoresHasta n (k-1)

sumaDivisores :: Int -> Int 
sumaDivisores n = sumaDivisoresHasta n n 


-- Menor Divisor
rango :: Int -> Int -> Int
rango n k | mod n k == 0 = k
          | otherwise = rango n (k+1)
        
menorDivisor :: Int -> Int 
menorDivisor n = rango n 2


-- Es Primo
esPrimo :: Int -> Bool  
esPrimo 1 = False
esPrimo n | menorDivisor n == n = True
          | otherwise = False 
       
       fafsa
          
-- nEsimo Primo
sigPrimo :: Int -> Int 
sigPrimo n | esPrimo (n+1) = n + 1
           | otherwise = sigPrimo (n+1)

nEsimoPrimo :: Int -> Int
nEsimoPrimo 1 = 2
nEsimoPrimo n = sigPrimo(nEsimoPrimo (n-1))
         

-- MenorFactDesde
fact :: Int -> Int
fact n | n == 1 = n
       | otherwise = n * fact(n-1)

factRecur :: Int -> Int -> Int
factRecur m k | fact k >= m = fact k
              | otherwise = factRecur m (k + 1)
             
menorFactDesde :: Int -> Int 
menorFactDesde m = factRecur m 1


-- MayorFactHasta
mayorFactMenorM :: Int -> Int ->Int
mayorFactMenorM m k | fact k > m  = fact (k-1)
                    | otherwise = mayorFactMenorM m (k+1)


mayorFactHasta :: Int -> Int
mayorFactHasta m = mayorFactMenorM m 1

--esFact
esFact :: Int -> Bool 
esFact n = menorFactDesde n == n 


-- esFibonacci
fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

fibonacciHasta :: Int -> Int -> Bool
fibonacciHasta n k | n == fib(k) = True
                   | n < fib(k) = False
                   | otherwise = fibonacciHasta n (k + 1)

esFibonacci :: Int -> Bool
esFibonacci n = fibonacciHasta n 1 

















