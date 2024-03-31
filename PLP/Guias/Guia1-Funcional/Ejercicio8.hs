mapPares :: (a -> b -> c) -> [(a, b)] -> [c]
mapPares f = foldr (\x rec -> uncurry f x : rec) [] 

armarPares :: [a] -> [b] -> [(a,b)] 
armarPares = foldr (\x rec ys -> if null ys then [] else (x, head ys) : rec (tail ys)) (const [])

mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c] 
mapDoble f xs ys = mapPares f (armarPares xs ys)
