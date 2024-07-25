-- elementosEnPosicionesPares es recursion Global porque accedemos a los resultados de recursiones anteriores. 

entrelazar :: [a] -> [a] -> [a] 
entrelazar = foldr f (const [])
    where f = \x acc yys -> if null yys then x : acc [] else x : head yys : acc (tail yys)


