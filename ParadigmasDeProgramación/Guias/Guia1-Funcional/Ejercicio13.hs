data AB a = Nil | Bin (AB a) a (AB a) 

instance Eq a => Eq (AB a) where 
    Nil == Nil = True 
    Nil == (Bin izq r der) = False
    (Bin izq r der) == (Bin izq2 r2 der2) = (r == r2) && (izq == izq2) && (der == der2) 

instance Ord a => Ord (AB a) where 
    compare Nil Nil = EQ
    compare Nil (Bin _ _ _) = LT
    compare (Bin _ _ _) Nil = GT
    compare (Bin _ r _) (Bin _ r2 _) = compare r r2 

foldAB :: (a -> b -> b -> b) -> b -> AB a -> b 
foldAB _ z Nil  = z 
foldAB f z (Bin izq r der) = f r (foldAB f z izq) (foldAB f z der)

recAB :: b -> (a -> AB a -> AB a -> b -> b -> b) -> AB a -> b 
recAB z _ Nil = z
recAB z f (Bin izq r der) = f r izq der (recAB z f izq) (recAB z f der)

esNil :: AB a -> Bool 
esNil Nil = True 
esNil _ = False

altura :: AB a -> Int
altura = foldAB (\r recIzq recDer -> 1 + max recIzq recDer ) 0 

cantNodos :: AB a -> Int 
cantNodos = foldAB (\r recIzq recDer -> 1 + recIzq + recDer) 0 

mejorSegun2 :: (a -> a -> Bool) -> AB a -> a 
mejorSegun2 f (Bin izq r der) = foldAB (\r recIzq recDer -> if f r recIzq && f r recDer then r else if f recIzq recDer then recIzq else recDer) r (Bin izq r der)

-- Cuando recibimos un arbol Nil simlemente devolvemos el valor de su raiz. Hay que tener en cuenta una propiedad donde la mejor opcion entre r y r es r. 

esABB :: Ord a => AB a -> Bool 
esABB = recAB True (\r izq der recIzq recDer -> mayor izq r && menor der r && recIzq && recDer) 
    where mayor Nil _ = True 
          mayor (Bin _ x _) y = x <= y 
          menor Nil _ = True 
          menor (Bin _ x _) y = y <= x




