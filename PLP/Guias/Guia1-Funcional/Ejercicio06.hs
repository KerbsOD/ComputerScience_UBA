recr :: (a -> [a] -> b -> b) -> b -> [a] -> b 
recr _ z [] = z 
recr f z (x : xs) = f x xs (recr f z xs)


sacarUna :: Eq a => a -> [a] -> [a] 
sacarUna e = recr (\x xs rec -> if x==e then xs else x : rec) []

-- Porque no tenemos acceso al arreglo. En este caso necesitamos devolver el arreglo entero. Si lo hicieramos con foldr entonces el algoritmo
-- no sabria diferenciar entre la primera aparicion y otra aparicion del arreglo. 
-- sacarUna e = foldr (\x rec -> if x==e then rec else x : rec).
-- Necesitamos xs para devolverlo luego de sacar la primera aparicion. 

insertarOrdenado :: Ord a => a -> [a] -> [a] 
insertarOrdenado e = recr (\x xs rec -> if null xs then x:e:rec else if e < head xs then x:e:xs else x : rec) [] 


 


