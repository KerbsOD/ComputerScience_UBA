type Set a = [a] 

--Ejercicio 1
combinatorio :: Int -> Int -> Int
combinatorio n m | (m==0) || (n==m) = 1
combinatorio n m = combinatorio (n-1) m + combinatorio (n-1) (m-1)


--Ejercicio 2
agregarElementosAListas :: Set Int -> Set [Int] -> Set [Int]
agregarElementosAListas []     c = []  
agregarElementosAListas (x:xs) c = (agregarElementoAdelante x c) ++ (agregarElementosAListas xs c) 


agregarElementoAdelante :: Int -> Set [Int] -> Set [Int]
agregarElementoAdelante x [] = []
agregarElementoAdelante x (cs:css) = (x:cs) : (agregarElementoAdelante x css) 
--agregarElementoAdelante 4 {[4], [7]} -> (x:cs) = 4:[4] -> [4,4] 
--Despues con el paso recursivo, agrego el elemento nuevamente a las listas que me faltan (css),
--Asi se me unen todas las listas con mi elemento x
--escribo (cs:css) porque es un conjunto de listas, lo que quiero es agregar x a cada lista del conjunto generico c.


variaciones :: Set Int -> Int -> Set [Int]
variaciones c 0 = [[]]                                                -- c es un conjunto generico
variaciones c n = agregarElementosAListas c (variaciones c (n-1))


--Ejercicio 3
insertarEn :: [Int] -> Int -> Int -> [Int]
insertarEn xs n i | i == 1 = n:xs
                  | otherwise = (head xs) : (insertarEn (tail xs) n (i-1))

                  --[1,2,3,4,5] 6 3
                  --1 : insertarEn [2,3,4,5] 6 2
                  --2 : insertarEn [3,4,5] 6 1 como i = 1, va a meter al 6 antes del 3


--Ejercicio 4
insertarEnCadaPosicion :: [Int] -> Int -> Int -> Set [Int]
insertarEnCadaPosicion xs n 1 = (insertarEn xs n 1) : []
insertarEnCadaPosicion xs n i = (insertarEn xs n i) : (insertarEnCadaPosicion xs n (i-1))
--[1,2] 3 3 => [1,2,3] : [] => [[1,2,3]]
--[1,2] 3 2 => [1,3,2] : [[1,2,3]] => [[1,2,3], [1,3,2]] etc.


insertarEnCadaPosicionDeTodasLasListas :: Set [Int] -> Int -> Set [Int]
insertarEnCadaPosicionDeTodasLasListas [] n = []
insertarEnCadaPosicionDeTodasLasListas (xs:xss) n = (insertarEnCadaPosicion xs n (length xs + 1)) ++ 
                                                    (insertarEnCadaPosicion xss n)

permutaciones :: Set Int -> Set [Int]
permutaciones [] = [[]]
permutaciones (c:cs) = insertarEnCadaPosicionDeTodasLasListas (permutaciones cs) c














































