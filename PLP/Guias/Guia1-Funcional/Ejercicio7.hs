recr :: (a -> [a] -> b -> b) -> b -> [a] -> b 
recr _ z [] = z 
recr f z (x : xs) = f x xs (recr f z xs)

genLista :: a -> (a -> a) -> Integer -> [a] 
genLista startElement incrementFunction size = foldl (\acc x -> if null acc then [startElement] else acc ++ [incrementFunction (last acc)]) [] [1..size]

desdeHasta :: Integer -> Integer -> [Integer]
desdeHasta inicio fin = genLista inicio (+1) (fin - inicio) ++ [fin]
