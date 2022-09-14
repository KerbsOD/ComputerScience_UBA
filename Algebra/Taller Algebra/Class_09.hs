--1
division :: Int -> Int -> (Int, Int)
division a d | a < d  = (0, a)  
             | otherwise = (fst (division (a-d) d) + 1, snd (division (a-d) d)) 
--2
divisionEnt :: Int -> Int -> (Int,Int)
divisionEnt a d | a >= d && 0 >= a = (0,a)
                | a < d = (fst (divisionEnt (a+d) d) - 1, snd (divisionEnt (a+d) d))
                | otherwise = division a d
                
--3
mcd :: Int -> Int -> Int
mcd a 0 = a
mcd a b | b > a = mcd b a
        | otherwise = mcd b (snd (division a b))
        
--4


--5
emcd :: Int -> Int -> (Int, Int, Int)
emcd a 0 = (a, 1, 0)
emcd a b = (g, t,s - q*t)
         where (g, s, t) = emcd b (mod a b)
               q = div a b

