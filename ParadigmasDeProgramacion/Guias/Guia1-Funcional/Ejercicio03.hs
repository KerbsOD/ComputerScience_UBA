import qualified Control.Concurrent as LISTAS
sum2 :: [Int] -> Int 
sum2 = foldr (+) 0  

elem2 :: Eq a => a -> [a] -> Bool 
elem2 e = foldr (\x rec -> x == e || rec) False  

concat20 :: [a] -> [a] -> [a] 
concat20 = flip(foldr (:))
-- concat20 xs ys = folder (:) ys xs 
-- (1) Usamos el parentesis pero con la funcion ya definida para que SOLO SE FLIPEEN LAS LISTAS 
-- (2) Automaticamente haskell sabe con la funcion (:) que quiero concatenar el primer elemento de xs. 
-- (3) Quiero flipear porque foldr toma el caso base primero y despues el array a recorrer. 

filter2 :: (a->Bool) -> [a] -> [a] 
filter2 f = foldr (\x rec -> if f x then x : rec else rec) []  

map2 :: (a -> a) -> [a] -> [a]
map2 f = foldr (\x rec -> f x : rec) []

mejorSegun :: (a-> a -> Bool) -> [a] -> a 
mejorSegun f = foldr1 (\x rec -> if f x rec then x else rec)

sumasParciales :: Num a => [a] -> [a] 
sumasParciales = foldl (\acc x -> acc ++ (if null acc then [x] else [x + last acc])) []

sumaAlt :: Num a => [a] -> a 
sumaAlt = foldr1 (-)

sumaAlt2 :: Num a => [a] -> a 
sumaAlt2 = foldl1 (flip (-)) 

-- 1 - (2 - (3 - (4 - 5)))
-- 5 - (4 - (3 - (2 - 1)))
-- 5 - (4 - (3 - 1))
-- 5 - (4 - 2)
-- 5 - (2) = 3 
-- 1 - (2 - (3 - (4 - 5))) 
--
--
