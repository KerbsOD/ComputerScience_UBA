{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Avoid lambda" #-}
import Control.Arrow (Arrow (first))
import Data.ByteString (elemIndex)
import Prelude hiding (filter, subtract, sum, (++))

-- Ejercicio 1 ---------------------------------------------------------------------------------------------------------------------------------------------

max2 :: (Float, Float) -> Float
max2 (x, y)
  | x >= y = x
  | otherwise = y

normaVectorial :: (Float, Float) -> Float
normaVectorial (x, y) = sqrt (x ^ 2 + y ^ 2)

subtract :: Float -> Float -> Float
subtract = flip (-)

subtract2 :: (Float, Float) -> Float
subtract2 (x, y) = (-) y x

predecesor :: Float -> Float
predecesor = subtract 1

predecesor2 :: (Float, a) -> Float
predecesor2 = predecesor . fst

evaluarEnCero :: (Float -> Float) -> Float
evaluarEnCero f = f 0

evaluarEnCero2 :: (Float -> Float, a) -> Float
evaluarEnCero2 = evaluarEnCero . fst

dosVeces :: (Float -> Float) -> Float -> Float
dosVeces f = f . f

dosVeces2 :: (Float -> Float, Float) -> Float
dosVeces2 (g, x) = dosVeces g x

flipAll :: [Float -> Float -> Float] -> [Float -> Float -> Float]
flipAll = map flip

flipAll2 :: ([Float -> Float -> Float], a) -> [Float -> Float -> Float]
flipAll2 = map flip . fst

flipRaro :: Float -> (Float -> Float -> Float) -> Float -> Float
flipRaro = flip flip

flipRaro2 :: (Float, Float -> Float -> Float, Float) -> Float
flipRaro2 (x, f, y) = flipRaro x f y

-- Ejercicio 2 ---------------------------------------------------------------------------------------------------------------------------------------------

curry2 :: ((a, b) -> c) -> (a -> b -> c)
curry2 f a b = f (a, b)

uncurry2 :: (a -> b -> c) -> ((a, b) -> c)
uncurry2 f (a, b) = f a b

-- Creo que no se puede definir curryN porque los tipos no pueden ser dinamicos. Haria falta reflections o algo similar. (metaprogramacion?)

-- Ejercicio 3 ---------------------------------------------------------------------------------------------------------------------------------------------

sum :: (Num a) => [a] -> a
sum = foldr (+) 0

elem :: (Eq a) => [a] -> a -> Bool
elem xs e = foldr (\x rec -> x == e || rec) False xs

(++) :: [a] -> [a] -> [a]
(++) xs ys = foldr (:) ys xs

filter :: (a -> Bool) -> [a] -> [a]
filter f = foldr (\x rec -> if f x then x : rec else rec) []

map2 :: (a -> b) -> [a] -> [b]
map2 = map

mejorSegun :: (a -> a -> Bool) -> [a] -> a
mejorSegun f = foldr1 (\x rec -> if f x rec then x else rec)

sumasParciales :: (Num a) => [a] -> [a]
sumasParciales = foldl (\ac x -> if null ac then [x] else ac ++ [last ac + x]) []

sumaAlt :: (Num a) => [a] -> a
sumaAlt = foldr (-) 0

sumaAlt2 :: (Num a) => [a] -> a
sumaAlt2 = foldl1 (flip (-))

-- Ejercicio 4 ---------------------------------------------------------------------------------------------------------------------------------------------

permutaciones :: [a] -> [[a]]
permutaciones =
  foldr
    (\x rec -> concatMap (\xs -> map (f x xs) [0 .. length xs]) rec)
    [[]]
  where
    f x xs index = drop index xs ++ [x] ++ take index xs

partes :: [a] -> [[a]]
partes = foldr (\x rec -> rec ++ map (x :) rec) [[]]

prefijos :: [a] -> [[a]]
prefijos = foldl (\ac x -> ac ++ [last ac ++ [x]]) [[]]

-- Ejercicio 5 ---------------------------------------------------------------------------------------------------------------------------------------------

entrelazar :: [a] -> [a] -> [a]
entrelazar = foldr f (const [])
  where
    f x acc yys = if null yys then x : acc [] else x : head yys : acc (tail yys)

-- Ejercicio 6 ---------------------------------------------------------------------------------------------------------------------------------------------

recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z [] = z
recr f z (x : xs) = f x xs (recr f z xs)

sacarUna :: (Eq a) => a -> [a] -> [a]
sacarUna e = recr (\x xs rec -> if x == e then xs else x : rec) []

insertarOrdenado :: (Ord a) => a -> [a] -> [a]
insertarOrdenado e = recr (\x xs rec -> if null xs then x : e : rec else if e < head xs then x : e : xs else x : rec) []

-- Ejercicio 7 ---------------------------------------------------------------------------------------------------------------------------------------------

genLista :: a -> (a -> a) -> Integer -> [a]
genLista startElement incrementFunction size = foldl (\acc x -> if null acc then [startElement] else acc ++ [incrementFunction (last acc)]) [] [1 .. size]

desdeHasta :: Integer -> Integer -> [Integer]
desdeHasta inicio fin = genLista inicio (+ 1) (fin - inicio) ++ [fin]

-- Ejercicio 8 ---------------------------------------------------------------------------------------------------------------------------------------------

mapPares :: (a -> b -> c) -> [(a, b)] -> [c]
mapPares f = map (uncurry f)

armarPares :: [a] -> [b] -> [(a, b)]
armarPares = foldr (\x rec ys -> if null ys then [] else (x, head ys) : rec (tail ys)) (const [])

mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f xs ys = mapPares f (armarPares xs ys)

-- Ejercicio 9 ---------------------------------------------------------------------------------------------------------------------------------------------

sumaMat :: [[Int]] -> [[Int]] -> [[Int]]
sumaMat = foldr (\xs rec yss -> zipWith (+) xs (head yss) : rec (tail yss)) (const [])

trasponer :: [[Int]] -> [[Int]]
trasponer (xs : xss) = foldr (zipWith (:)) [[] | i <- [1 .. (length xs)]] xss

-- Ejercicio 10 ---------------------------------------------------------------------------------------------------------------------------------------------

foldNat :: (Integer -> b -> b) -> b -> Integer -> b
foldNat _ z 0 = z
foldNat f z n = f n (foldNat f z (n - 1))

potencia :: Integer -> Integer -> Integer
potencia base = foldNat (\_ acc -> base * acc) 1

-- Ejercicio 11 ---------------------------------------------------------------------------------------------------------------------------------------------

data Polinomio a
  = X
  | Cte a
  | Suma (Polinomio a) (Polinomio a)
  | Prod (Polinomio a) (Polinomio a)

foldPoli :: b -> (a -> b) -> (b -> b -> b) -> (b -> b -> b) -> Polinomio a -> b
foldPoli casoX casoCte casoSuma casoProd polinomio =
  case polinomio of
    X -> casoX
    Cte n -> casoCte n
    Suma p q -> casoSuma (acc p) (acc q)
    Prod p q -> casoProd (acc p) (acc q)
  where
    acc = foldPoli casoX casoCte casoSuma casoProd

evaluar :: (Num a) => a -> Polinomio a -> a
evaluar n = foldPoli n id (+) (*)

-- Ejercicio l2 ---------------------------------------------------------------------------------------------------------------------------------------------

data AB a = Nil | Bin (AB a) a (AB a)

instance (Eq a) => Eq (AB a) where
  Nil == Nil = True
  Nil == (Bin izq r der) = False
  (Bin izq r der) == (Bin izq2 r2 der2) = r == r2 && izq == izq2 && der == der2

instance (Ord a) => Ord (AB a) where
  compare Nil Nil = EQ
  compare Nil (Bin {}) = LT
  compare (Bin {}) Nil = GT
  compare (Bin _ r _) (Bin _ r2 _) = compare r r2

foldAB :: (a -> b -> b -> b) -> b -> AB a -> b
foldAB _ z Nil = z
foldAB f z (Bin izq r der) = f r (foldAB f z izq) (foldAB f z der)

recAB :: b -> (a -> AB a -> AB a -> b -> b -> b) -> AB a -> b
recAB z _ Nil = z
recAB z f (Bin izq r der) = f r izq der (recAB z f izq) (recAB z f der)

esNil :: AB a -> Bool
esNil Nil = True
esNil _ = False

alturaAB :: AB a -> Int
alturaAB = foldAB (\r recIzq recDer -> 1 + max recIzq recDer) 0

cantNodosAB :: AB a -> Int
cantNodosAB = foldAB (\r recIzq recDer -> 1 + recIzq + recDer) 0

mejorSegun2 :: (a -> a -> Bool) -> AB a -> a
mejorSegun2 f (Bin izq r der) = foldAB (\r recIzq recDer -> if f r recIzq && f r recDer then r else if f recIzq recDer then recIzq else recDer) r (Bin izq r der)

esABB :: (Ord a) => AB a -> Bool
esABB = recAB True (\r izq der recIzq recDer -> mayor izq r && menor der r && recIzq && recDer)
  where
    mayor Nil _ = True
    mayor (Bin _ x _) y = x <= y
    menor Nil _ = True
    menor (Bin _ x _) y = y <= x

-- Ejercicio 13 ---------------------------------------------------------------------------------------------------------------------------------------------

ramas :: AB a -> [[a]]
ramas = foldAB (\r recIzq recDer -> if null recIzq && null recDer then [[r]] else map (r :) (recIzq ++ recDer)) []

mismaEstructura :: AB a -> AB b -> Bool
mismaEstructura = foldAB (\r recIzq recDer arbol -> not (esNil arbol) && recIzq (hijoIzquierdo arbol) && recDer (hijoDerecho arbol)) (\arbol -> esNil arbol)

hijoIzquierdo :: AB a -> AB a
hijoIzquierdo (Bin izq _ _) = izq

hijoDerecho :: AB a -> AB a
hijoDerecho (Bin _ _ der) = der

-- Ejercicio 14 ---------------------------------------------------------------------------------------------------------------------------------------------

data AIH a = Hoja a | BinAIH (AIH a) (AIH a)

foldAIH :: (b -> b -> b) -> (a -> b) -> AIH a -> b
foldAIH _ z (Hoja r) = z r
foldAIH f z (BinAIH izq der) = f (foldAIH f z izq) (foldAIH f z der)

alturaAIH :: AIH a -> Integer
alturaAIH = foldAIH (\recIzq recDer -> 1 + max recIzq recDer) (const 0)

tamano :: AIH a -> Integer
tamano = foldAIH (+) (const 1)

-- Ejercicio 15 ---------------------------------------------------------------------------------------------------------------------------------------------

data Rosetree a = Rose a [Rosetree a]

foldRT :: (a -> [b] -> b) -> Rosetree a -> b
foldRT f (Rose r hijos) = f r (map (foldRT f) hijos)

hojasRT :: Rosetree a -> [a]
hojasRT = foldRT (\r recHijos -> if null recHijos then [r] else concat recHijos)

distanciasRT :: Rosetree a -> [(a, Int)]
distanciasRT = foldRT (\r recHijos -> if null recHijos then [(r, 0)] else map (\(tree, distance) -> (tree, distance + 1)) (concat recHijos))

alturaRT :: Rosetree a -> Int
alturaRT = foldRT (\r recHijos -> if null recHijos then 0 else 1 + maximum recHijos)

-- Ejercicio 16 ---------------------------------------------------------------------------------------------------------------------------------------------

-- Ejercicio 17 ---------------------------------------------------------------------------------------------------------------------------------------------

-- Ejercicio 18 ---------------------------------------------------------------------------------------------------------------------------------------------

-- Ejercicio 19 ---------------------------------------------------------------------------------------------------------------------------------------------

-- Ejercicio 20 ---------------------------------------------------------------------------------------------------------------------------------------------
listasQueSuman :: Int -> [[Int]]
-- Ejercicio 21 ---------------------------------------------------------------------------------------------------------------------------------------------

enterosInfinitos :: [[Int]]
enterosInfinitos = map (\n -> [1 .. n]) [1 ..]

-- Ejercicio 22 ---------------------------------------------------------------------------------------------------------------------------------------------

listasInfinitasAIH :: [AIH ()]
listasInfinitasAIH = genAIH (Hoja ())

genAIH :: AIH () -> [AIH ()]
genAIH arbol = arbol : concatMap (\x -> genAIH (BinAIH x x)) (genAIH (Hoja ()))