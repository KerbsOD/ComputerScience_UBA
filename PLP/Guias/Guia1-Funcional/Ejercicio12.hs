data Polinomio a = X 
                 | Cte a 
                 | Suma (Polinomio a) (Polinomio a) 
                 | Prod (Polinomio a) (Polinomio a)


-- El polinomio compuesto por la variable independiente X. 
-- El polinomio compuesto por la constante a.
-- El polinomio compuesto por la suma de 2 polinomios. 
-- El polinomio compuesto por la multiplicacion de 2 polinomios. 



-- El polinomio simple 3X se puede representar utilizando el constructor 'Producto' con un 'Cte 3' y 'X'. 
-- La expresion "3X" seria equivalente a 'Producto (Cte 3) X' en la estructura de datos 'Polinomio a'



foldPoli :: b -> (a -> b) -> (b -> b -> b) -> (b -> b -> b) -> Polinomio a -> b 
foldPoli casoX casoCte casoSuma casoProd polinomio = 
    case polinomio of 
        X -> casoX
        Cte n -> casoCte n
        Suma p q -> casoSuma (acc p) (acc q)
        Prod p q -> casoProd (acc p) (acc q)
        where acc = foldPoli casoX casoCte casoSuma casoProd 

-- Si el polinomio es X, se devuelve casoX.
-- Si el polinomio es Cte n, se aplica casoCte a n.
-- Si el polinomio es una suma Suma p q, se aplica casoSuma a los resultados de aplicar recursivamente foldPoli a p y q.
-- Si el polinomio es un producto Prod p q, se aplica casoProd a los resultados de aplicar recursivamente foldPoli a p y q.



evaluar :: Num a => a -> Polinomio a  -> a 
evaluar n = foldPoli n id (+) (*)


-- X representa la variable independiente en un polinomio. Es un constructor que no lleva ningun argumento y simplemente indica la presencia de la variable independiente en el polinomio. Por eso X es simplemente el valor con el que evaluamos el polinomio (n).
-- Cte representa un termino constante en un polinomio donde 'a' es el TIPO del coeficiente. Usamos id porque queremos que nos devuelva el numero de la constante. Abajo leemos Cte 2 ~> casoCte 2 ~> id n ~> n. (leer todas las definiciones para que cobre sentido)
-- Suma representa la suma de 2 polinomios. Aca es donde viene el paso recursivo. La suma entre dos polinomios es igual a la suma de la evaluacion de ambos. Cuando se suman p y q se llama recursivamente foldPoli con p y con q. 
-- Suma p q -> casoSuma (acc p) (acc q) ~> (+) (acc p) (acc q) 


-- Definimos un polinomio 2x^2 + 3x + 1
polinomioEjemplo :: Polinomio Int
polinomioEjemplo = Suma (Prod (Cte 2) (Prod X X)) (Suma (Prod (Cte 3) X) (Cte 1))

main :: IO ()
main = print (evaluar 5 polinomioEjemplo)



-- O sea yo le doy cualquier polinomio y lo va a tratar de resolver recursivamente.
