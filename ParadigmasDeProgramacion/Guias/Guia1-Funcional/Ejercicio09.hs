sumaMat :: [[Int]] -> [[Int]] -> [[Int]] 
sumaMat = foldr (\xs rec yss -> zipWith (+) xs (head yss) : rec (tail yss)) (const [])

trasponer :: [[Int]] -> [[Int]]
trasponer (xs:xss) = foldr (zipWith (:)) [[] | i <- [1.. (length xs)]] xss 

-- [[] | i <- [1..4]] genera una lista vacia por cada elemento en [1..4] -> [[], [], [], []]
-- [i | i <- [1..4]] genera una lista con cada elemento -> [1,2,3,4] 
-- [1 | i <- [1..4]] genera una lista con un 1 por cada elemento en [1..4] -> [1, 1, 1, 1]

-- zipWith (+) [1,2,3] [4,5,6] = [1+4, 2+5, 3+6] 
-- zipWith (:) [3,5,7] [[], [], []] = [3:[], 5:[], 7:[]] = [[3], [5], [7]] 

-- Entonces mediante [[] | i <- [1.. (length xs)]] creamos listas del mismo largo que la primer fila de la matriz. Luego concatenamos los elementos
-- del primer arreglo con las listas vacias del segundo arreglo. Al tener el mismo tamano, funciona.

