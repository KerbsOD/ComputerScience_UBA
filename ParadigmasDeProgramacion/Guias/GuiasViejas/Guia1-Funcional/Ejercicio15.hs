data AIH a = Hoja a | Bin (AIH a) (AIH a)

foldAIH :: (b -> b -> b) -> (a -> b) -> AIH a -> b
foldAIH _ z (Hoja r) =  z r 
foldAIH f z (Bin izq der) = f (foldAIH f z izq) (foldAIH f z der)

altura :: AIH a -> Integer 
altura = foldAIH (\recIzq recDer -> 1 + max recIzq recDer) (const 0) 

tamano :: AIH a -> Integer 
tamano = foldAIH (+) (const 1)
-- foldAIH (\recIzq recDer -> recIzq + recDer)

genAIH :: AIH () -> [AIH ()]
genAIH arbol = arbol : concatMap (\x -> genAIH (Bin x x)) (genAIH (Hoja ()))

listasInfinitasAIH :: [AIH ()]
listasInfinitasAIH = genAIH (Hoja ()) 

