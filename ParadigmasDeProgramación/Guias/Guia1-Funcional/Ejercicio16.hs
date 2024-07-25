data Rosetree a = Rose a [Rosetree a]

foldRT :: (a -> [b] -> b) -> Rosetree a -> b 
foldRT f (Rose r hijos) = f r (map (foldRT f) hijos)

hojas :: Rosetree a -> [a]
hojas = foldRT (\r recHijos -> if null recHijos then [r] else concat recHijos) 

distancias :: Rosetree a -> [(a,Int)] 
distancias = foldRT (\r recHijos -> if null recHijos then [(r,0)] else map (\(tree, distance) -> (tree, distance + 1)) (concat recHijos))

altura :: Rosetree a -> Int 
altura = foldRT (\r recHijos -> if null recHijos then 0 else 1 + maximum recHijos)
