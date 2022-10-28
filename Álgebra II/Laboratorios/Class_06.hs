-- Longitud ------
longitud :: [Int] -> Int
longitud lista | lista == [] = 0
               | otherwise = 1 + longitud (tail lista)

-- Sumatoria ------
sumatoria :: [Int] -> Int
sumatoria lista | lista == [] = 0
                | otherwise = (head lista) + sumatoria (tail lista)


-- Pertenece ------
pertenece :: Int -> [Int] -> Bool
pertenece n lista | lista == [] = False
                  | n == (head lista) = True
                  | otherwise =  pertenece n (tail lista)


-- Ejercicio 1 ------
unoAlMCien :: [Int]
unoAlMCien = [1, 0..(-100)]


-- Ejercicio 2 ------
primerMultiplode45345 :: [Int] -> Int
primerMultiplode45345 lista | mod (head lista) 45345 == 0 = head lista
                            | otherwise = primerMultiplode45345 (tail lista)   
               

-- Sumatoria Pattern Matching ------
sumatoriaPM [] = 0
sumatoriaPM (elem:lista) = sumatoriaPM lista + elem


-- Longitud Pattern Matching ------
longitudPM :: [a] -> Int
longitudPM [] = 0
longitudPM (elem:lista) = 1 + longitudPM lista


-- Pertenece Pattern Matching ------                  
pertenecePM :: Int -> [Int] -> Bool
pertenecePM n [] = False
pertenecePM n (elem:lista) = n == elem || pertenecePM n lista
      

-- Ejercicio 3 -----
productoria :: [Int] -> Int
productoria lista | lista == [] = 1
                  | otherwise = (head lista) * productoria (tail lista)
                    
productoriaPM :: [Int] -> Int
productoriaPM [] = 1
productoriaPM (elem:lista) = elem * productoriaPM lista

------------------ operador nuevo ([3,4] ++ [9,10] = [3,4,9,10] -----------

-- Ejercicio 4 ------
sumarN :: Int -> [Int] -> [Int]
sumarN n lista | lista == [] = []
               | otherwise = (n + head lista) : (sumarN n (tail lista))
            
sumarNPM :: Int -> [Int] -> [Int]
sumarNPM n [] = []
sumarNPM n (elem:lista) = (n + elem) : (sumarNPM n lista)


-- Ejercicio 5 ------
sumarElPrimero :: [Int] -> [Int]
sumarElPrimero lista = sumarN (head lista) lista
                     
         


