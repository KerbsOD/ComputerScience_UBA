type Set a = [a] --"Set" es el nombre que le pusimos, equivale a "Conjunto"

--Funciones de Tutorial
vacio :: Set Int
vacio = [] 

agregar :: Int -> Set Int -> Set Int --Si X esta en C (c = Conjunto), entonces no hagamos nada. Otherwise, agregalo
agregar x c | elem x c = c
            | otherwise = x:c

--Ej 1
incluido :: Set Int -> Set Int -> Bool
incluido [] c = True
incluido (elemento:lista) c = elem elemento c && incluido lista c --"(elemento:lista)" te da el primer elemento de lista y lo saca de esta
                                                                   -- Como que primero te da el head y le hace tails a eso.
                                                                   -- (elem:[2,3,4,5]) te da el 2 y la lista queda en [3,4,5]

--Ej 2
iguales :: Set Int -> Set Int -> Bool
iguales lista c = incluido lista c && incluido lista c

--Ej 3
partes :: Int -> Set (Set Int)
partes 1 = [[],[1]]
partes n = partes (n-1) ++ agregarATodos n (partes(n-1))

agregarATodos :: Int -> Set(Set Int) -> Set(Set Int)
agregarATodos n [] = []
agregarATodos n (elem:lista) = (n:elem) : (agregarATodos n lista)

--Ej 4
productoCartesianoX :: Set Int -> Set Int -> Set (Int, Int)
productoCartesianoX [] ys = []
productoCartesianoX xs [] = [] 
productoCartesianoX xs ys = [(head xs,head ys)] ++ productoCartesianoX xs (tail ys) 

productoCartesiano :: Set Int -> Set Int -> Set (Int, Int)
productoCartesiano [] ys = []
productoCartesiano xs ys = productoCartesianoX xs ys ++ productoCartesiano (tail xs) ys

