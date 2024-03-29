-- Genera una lista de pares tales que z va de 0 a infinito y x de 0 a z.
-- Lazy evaluation means that exxpresions are only evaluated when their results are needed. 
-- Genera los pares uno por uno. Aunque en el caso (1, 543) solo va a generar ese par. Creo que implementativamente solo chequea
-- que los parametros que les pasamos cumplen con lo pedido. 
pares = [(x,z-x) | z<-[0..], x<-[0..z]]

foldr2 :: (a -> b -> b) -> b -> [a] -> b
foldr2 _ z [] = z
foldr2 f z (x:xs) = f x (foldr2 f z xs)

zip2 :: [a] -> [b] -> [(a,b)]  
zip2 = foldr f (const []) 
    where f = \x xs ys -> if null ys then [] else (x, head ys) : xs (tail ys) 

-- zip2 [1,2] [3,4] = [(1,3), (2,4)]
-- zip2 [1,2] [3,4] 
-- ~> foldr f (const []) [1,2] [3,4] 
-- ~> f 1 (foldr f (const []) [2]) [3,4]
-- ~> f 1 (f 2 (foldr f (const []) [])) [3,4]
-- ~> f 1 (f 2 (const [])) [3,4] 
-- ~> (\ys -> if null ys then [] else (1, head ys) : (f 2 (const[])) (tail ys)) [3,4] 
-- ~> (\ys -> if null ys then [] else (1, head ys) : if null (tail ys) then [] else (2, head (tail ys)) : (const []) (tail (tail ys)) ) [3,4]
-- ~> (if null [3,4] then [] else (1, head [3,4]) : if null (tail [3,4]) then [] else (2, head (tail [3,4])) : (const []) (tail (tail [3,4])) ) [3,4] 
-- ~> (if null [3,4] then [] else (1, 3) : if null [4] then [] else (2, head [4]) : (const []) (tail [4]) ) [3,4] 
-- ~> (if null [3,4] then [] else (1, 3) : if null [4] then [] else (2, 4) : (const[]) [] ) [3,4]
-- ~> (1,3) : (2,4) : (const[])
-- ~> [(1,3),(2,4)]







































