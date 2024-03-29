-- Currificar es la accion de tomar una funcion que usa un vector y convertirlo 
-- en una funcion que toma los parametros por separado. De esta manera podemos 
-- tenes aplicacion parcial para una futura evaluacion.

curry :: ((a,b) -> c) -> a -> b -> c 
curry f a b = f (a, b)

uncurry :: (a -> b -> c) -> (a,b) -> c 
uncurry f (a,b) = f a b 

suma8 :: (Int,Int,Int,Int,Int,Int,Int,Int) -> Int
suma8 (a,b,c,d,e,f,g,h) = a + b + c+d+e+f+g+h

