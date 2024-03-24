import System.Console.Haskeline (fallbackCompletion)
import Data.Data (typeOf)

valorAbsoluto :: Float -> Float
valorAbsoluto = abs 

bisiesto :: Int -> Bool
bisiesto x = x `mod` 4 == 0

factorial :: Int -> Int
factorial 0 = 1 
factorial 1 = 1 
factorial n = n * factorial (n-1)

esPrimo :: Int -> Bool 
esPrimo 1 = False
esPrimo n = length (factores n) == 2 
    where factores n = [x | x <- [1..n], mod n x == 0]

cantDivisoresPrimos :: Int -> Int
cantDivisoresPrimos 0 = 0 
cantDivisoresPrimos x = length (filter esPrimo [y | y <- [1..x], mod x y == 0])

inverso :: Float -> Maybe Float 
inverso 0 = Nothing
inverso x = Just (1/x)

aEntero :: Either Int Bool -> Int
aEntero (Left num) = num
aEntero (Right True) = 1
aEntero (Right False) = 0

limpiar :: Eq a => [a] -> [a] -> [a] 
limpiar (x:xs) (y:ys) = [c | c <- y:ys, c `notElem` (x:xs)]  

difPromedio :: [Float] -> [Float]
difPromedio lista = map (\i -> i - promedio lista) lista
    where promedio lista =  sum lista / fromIntegral(length lista)

todosIguales :: [Int] -> Bool 
todosIguales (x:xs) = null (limpiar [x] (x:xs) ) 

data AB a = Nil | Nodo (AB a) a (AB a)

vacioAB :: AB a -> Bool 
vacioAB Nil = True 
vacioAB _ = False 

negacionAB :: AB Bool -> AB Bool 
negacionAB Nil = Nil 
negacionAB (Nodo left raiz right) = Nodo (negacionAB left) (not raiz) (negacionAB right) 

productoAB :: AB Int -> Int
productoAB Nil = 1
productoAB (Nodo left raiz right) = raiz * productoAB left * productoAB right

