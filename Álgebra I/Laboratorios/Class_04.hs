
f1:: Int -> Int
f1 0 = 0
f1 n = 2^n + f1(n - 1)

f2:: Int -> Float -> Float
f2 1 q = q
f2 n q = q^n + f2 (n-1) q

f3:: Int -> Float -> Float
f3 0 q = 0
f3 n q = q^n + f3(2*n - 1) q

f4:: Int -> Float -> Float
f4 0 q = 1

fact :: Integer -> Float
fact 0 = 1
fact n = (fromIntegral n) * fact (n - 1)

eAprox :: Integer -> Float 
eAprox 0 = 1
eAprox n = eAprox(n-1) + 1 /(fact n) 

e :: Float
e = eAprox 10

f :: Int -> Int -> Float
f 0 m = 0
f n m = f2 m (fromIntegral n) + f (n-1) m

a :: Int -> Int
a 0 = 1
a n = a(n-1)

sumaPotencias:: Int -> Int -> Int -> Int
sumaPotencias 0 n m = 1
sumaPotencias q n m = q^(a(n) + a(m)) + (q - 1)


sumaRacionales :: Float -> Float -> Float
sumaRacionales 0 m = 0
sumaRacionales n 0 = 0
sumaRacionales n m = n / m + sumaRacionales n (m-1) 
-- 3 2


 
