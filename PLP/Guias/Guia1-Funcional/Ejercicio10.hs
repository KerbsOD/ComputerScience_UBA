-- ([a] -> Bool) predicado verdadero o falso. Dado una lista nos dice si se cumple el predicado. Si se cumple paramos y devolvemos la lista sin el ultimo elemento. 
-- ([a] -> a) a partir de la lista completa genera un elemento nuevo. 
-- [a] lista actual.
-- [a] lista resultado. 
-- Le pasas una funcion que dada una lista devuelva el siguiente elemento de la secuencia. 

generate :: ([a] -> Bool) -> ([a] -> a) -> [a] 
generate stop next = generateFrom stop next [] 

generateFrom :: ([a] -> Bool) -> ([a] -> a) -> [a] -> [a] 
generateFrom stop next xs | stop xs = init xs 
                          | otherwise = generateFrom stop next (xs ++ [next xs])

-- Dado un elemento (correspondiente al ultimo elemento de la lista) devuelva el siguiente elemeto de la secuencia.  
-- generateBase (\l->not (null l) && (last l > 256)) 1 (*2) es la lista las potencias de 2 menores o iguales que 256.
-- Si la lista no es vacia y el ultimo elemento es mayor a 256 entonces devolvemos la lista sin el ultimo elemento. 
generateBase :: ([a] -> Bool) -> a -> (a -> a) -> [a] 
generateBase stop e next = generate stop (\xs -> if null xs then e else next (last xs))

-- Si xs es vacio es porque  estamos en el caso base por lo que devolvemos e. Luego usamos next sobre el ultimo elemento de xs. 

-- stop = (\l->not (null l) && (last l > 256)) 
-- e = 1 
-- next = (*2) 


-- generateBase stop 1 (*2) = generate stop next' = (\xs -> if null xs then 1 else (*2) (last xs))
-- generate stop next' = generateFrom stop next' []
-- generate from | stop xs = init xs 
--               | otherwise = generateFrom stop next (xs ++ [next xs])
--
-- generate from | (\l->not (null l) && (last l > 256)) [] = init []
--               | otherwise = generateFrom stop=(\l->not (null l) && (last l > 256)) next=(\xs -> if null xs then 1 else (*2) (last xs)) ([] ++ [next' xs])

-- O sea le pasamos la funcion stop, la funcion next modificada y la lista vacia. la funcion next original multiplica por 2 un elemnto mientras que la modificada es la idea de que si la lista esta vacia entonces pone el caso base y si no esta vacia aplica la multiplicacion al ultimo elemento y devolvelo.

factoriales :: Int -> [Int] 
factoriales n = generate (\xs -> length xs > n) (\xs -> if null xs then 1 else last xs * length xs) 

iterateN :: Int -> (a->a) -> a -> [a] 
iterateN n f x = generateBase (\xs -> length xs > n) x (\e -> f e)

generateFrom2 :: ([a] -> Bool) -> ([a] -> a) -> [a] -> [a] 
generateFrom2 stop next = last . takeWhile (not . stop) . iterate (\ys -> ys ++ [next ys])

-- iterate toma una funcion de (a -> a), un a y devuelve una LISTA de tipo a. 
-- Como le estamos pasando una lista entonces es de tipo ([b] -> [b]), le pasamos la lista [b] (ys) y nos devuelve una lista de listas, por 
-- eso pedimos last. 
























