type Complejo = (Float, Float)

re :: Complejo -> Float
re z = fst z

im :: Complejo -> Float
im z = snd z

conjugado :: Complejo -> Complejo
conjugado z = (fst z, snd z * (-1))

suma :: Complejo -> Complejo -> Complejo
suma z w = ((fst z) + (fst w), (snd z) + (snd w))

producto :: Complejo -> Complejo -> Complejo
producto z w = ((fst z)*(fst w) - (snd z)*(snd w), (fst z)*(snd w) + (snd z)*(fst w))


inverso :: Complejo -> Complejo --conjugado sobre norma al cuadrado
inverso (0,0) = undefined
inverso (a,b) = (a / (a**2 + b**2), (-b) / (a**2 + b**2))
         
          
cociente :: Complejo -> Complejo -> Complejo
cociente (a,b) (0,0) = undefined
cociente z w = producto z  (inverso w)

potencia :: Complejo -> Int -> Complejo
potencia (a,b) 0 = (1,0)
potencia z n = producto z (potencia z (n-1))
 
--dis :: Float -> Float -> Float -> Complejo
--dis a b c | b*b - 4*a*c >= 0 = (sqrt (b*b - 4*a*c, 0))
--          | b*b - 4*a*c < 0 = (sqrt (0, -b*b + 4*a*c))

--solucionesCuadraticas :: Float -> Float -> Float -> (Complejo, Complejo)
--solucionesCuadraticas a b c | (dis a b c) >= 0 = (z,s)
--                            | (dis a b c) <= (z, conjugado z) = (z, fst(conjugado z))
--                            where z = cociente (suma (-b,0) (dis a b c)) (2*a,0)
--                                  s = cociente (suma (-b,0) (producto (dis a b c) (-1, 0))) (2*a, 0)

modulo :: Complejo -> Float
modulo (a,b) = sqrt (a*a + b*b)

arg :: Complejo -> Float
arg (0, b) = pi / 2
arg (a, 0) = 0
arg (a,b) | a > 0 && b > 0 = atan(b/a)
          | a > 0 && b < 0 = atan(b/a) + 2*pi
          | a < 0 && b > 0 = atan(b/a) + pi
          | a < 0 && b < 0 = atan(b/a)

pasarACartesianas :: Float -> Float -> Complejo
pasarACartesianas r t | r < 0 = undefined
                      | t < (2*pi) = (r*cos(t), r*sin(t))
                      | otherwise = pasarACartesianas r (t - 2*pi)
                        





























