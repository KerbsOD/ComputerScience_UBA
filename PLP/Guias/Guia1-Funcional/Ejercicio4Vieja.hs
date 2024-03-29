-- Cuando queremos generar todos los pares naturales con 
-- [(x, y) | x <- [0..], y <- [0..x]]
-- Lo que hace son for loops. 
-- elem e = (4,2) in paresDeNaturales?
-- for x = 0 .. Inf 
--     for y = 0 .. x 
--         if e == (x,y) return true 
--
-- return false 
--
-- El tema es que para e = (2, 4) el y no puede llegar a 4 porque esta acotado
-- por el 2 y cuando x = 4 e y puede llegar a valer 4 nunca mas ponemos x en 2.

pitagoricas :: Int -> [(Int, Int, Int)] 
pitagoricas n = [(a, b, c) | c <- [1..n], a <-[1..n], b <- [1..n], a^2 + b^2 == c^2]

pares = [(x,y) | z<-[0..], x<-[0..z], y<-[0..z], x+y == z]

-- En pares sabemos que siempre existe el numero porque los naturales son infinitos
-- pero pitagoricos no sabe cuando parar. Por eso nunca devuelve el false. 
