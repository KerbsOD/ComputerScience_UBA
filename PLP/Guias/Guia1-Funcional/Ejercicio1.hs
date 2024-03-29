max2 :: (Float, Float) -> Float
max2 (x, y) | x >= y = x                    
            | otherwise = y

max22 :: Float -> Float -> Float 
max22 x y = max2 (x, y)

normaVectorial :: (Float, Float) -> Float
normaVectorial (x, y) = sqrt (x^2 + y^2)

normaVectorial2 :: Float -> Float -> Float
normaVectorial2 x y = normaVectorial (x,y)

-- subtract2 :: float -> float -> float  
subtract2 = flip (-)

-- predecesor2 :: float -> float  
predecesor2 = subtract 1

-- evaluarEnCero :: (float -> float) -> float  
evaluarEnCero f = f 0

--dosVeces :: (float -> float) -> float -> float 
dosVeces f = f.f

-- flipAll :: [(float -> float -> float)] -> [(float -> float -> float)]    
flipAll = map flip

-- flip :: (a->b->c) -> b -> a -> c 
-- Si le aplicamos flip a una funcion flip que tiene ese tipo entonces le vamos a invertir el orden de sus parametros. Implicando que primero toma b y luego (a->b->c) 
-- flipRaro :: b -> (a->b->c) -> a -> c 
flipRaro = flip flip

