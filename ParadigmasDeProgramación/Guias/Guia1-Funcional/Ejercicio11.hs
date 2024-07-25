foldNat :: (Integer -> b -> b) -> b -> Integer -> b 
foldNat _ z 0 = z 
foldNat f z n = f n (foldNat f z (n-1))

potencia :: Integer -> Integer -> Integer 
potencia base = foldNat (\_ acc -> base * acc) 1  


