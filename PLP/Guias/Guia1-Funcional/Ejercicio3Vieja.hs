import Distribution.Simple (languageToFlags)
-- [ x | x <- [1..3], y <- [x..3], (x + y) `mod' 3 == 0 ] 
-- Es la lista de los x tal que x esta entre 1 y 3, y esta entre x y 3 y la 
-- suma de estos da un multiplo de 3. 
-- [1+1, 1+2, 1+3, 2+2, 2+3, 3+3] = [2,3,4,4,4,5,6] 
-- [1, 3] o sea cuando x es igual a 1 y a 3

