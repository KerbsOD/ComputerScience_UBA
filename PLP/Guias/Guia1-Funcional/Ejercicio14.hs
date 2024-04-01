data AB a = Nil | Bin (AB a) a (AB a) 

esNil :: AB a -> Bool 
esNil Nil = True 
esNil _ = False

foldAB :: (a -> b -> b -> b) -> b -> AB a -> b 
foldAB _ z Nil  = z 
foldAB f z (Bin izq r der) = f r (foldAB f z izq) (foldAB f z der)

recAB :: b -> (a -> AB a -> AB a -> b -> b -> b) -> AB a -> b 
recAB z _ Nil = z
recAB z f (Bin izq r der) = f r izq der (recAB z f izq) (recAB z f der)

ramas :: AB a -> [[a]]
ramas = foldAB (\r recIzq recDer -> if null recIzq && null recDer then [[r]] else map (r:) (recIzq++recDer)) [] 
-- Concatena las listas y agregales la raiz
-- ramas (Bin (Bin Nil 3 (Bin (Bin Nil 67 Nil) 5 (Bin Nil 19 Nil))) 4 (Bin Nil 84 Nil)) = [[4,3,5,67],[4,3,5,19],[4,84]] 

cantHojas :: AB a -> Int 
cantHojas = recAB 0 (\r izq der recIzq recDer -> if esNil izq && esNil der then 1 else recIzq + recDer) 

espejo :: AB a -> AB a 
espejo = foldAB (\r recIzq recDer -> Bin recDer r recIzq) Nil 


hijoIzquierdo :: AB a -> AB a 
hijoIzquierdo (Bin izq _ _) = izq

hijoDerecho :: AB a -> AB a 
hijoDerecho (Bin _ _ der) = der

mismaEstructura :: AB a -> AB b -> Bool 
mismaEstructura =  foldAB (\r recIzq recDer arbol -> not (esNil arbol) && recIzq (hijoIzquierdo arbol) && recDer (hijoDerecho arbol)) (\arbol -> esNil arbol)

-- La funcion espera AB b -> Bool. Para el caso borde donde el arbol que estamos recorriendo recursivamente es nil pero el que le pasamos como parametro TODAVIA NO ES NIL usamos la funcion (\arbol -> esNil arbol)).

