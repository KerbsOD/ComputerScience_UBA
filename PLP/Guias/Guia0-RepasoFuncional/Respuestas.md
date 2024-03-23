# EJercicio 1 
1. null :: Foldable t => t a -> Bool
    - Toma una funcion de la clase Foldable y un elemento de tipo generico. Retorna si el elemento es null o no.
    
    // Ejemplo foldr: foldr (+) 0 [1, 2, 3] -- 1 + (2 + (3 + 0))
    // Primero hace 0 + 3, despues (0+3) + 2, (despues (0+3) + 2) + 1. O sea recorre la lista de derecha a izquierda
    // foldl lo recorre de izquierda a derecha

2. head :: GHC.Stack.Types.HasCallStack => [a] -> a 
    - Toma una lista que pertenece a la clase de elementos que tienen un callstack y devuelve el primer elemento.

3. tail :: GHC.Stack.Types.HasCallStack => [a] -> [a]
    - Toma una lista que pertenece a la clase de elementos que tinene un callstack y devuelve una lista sin el primer elemnto.

4. init :: GHC.Stack.Types.HasCallStack => [a] -> [a]
    - Toma una lista que pertenece a la calse de elementos que tienen un callstack y devuelve la lista sin el ultimo elemento.

5. last :: GHC.Stack.Types.HasCallStack => [a] -> a
    - Toma una lista que pertenece a la clase de elementos que tienne un callstack y devuelve el ultimo elemento.
    
6. take :: Int -> [a] -> [a]
    - Dado un int y una lista te devuelve la lista con solo los primeros n elementos.

7. drop :: Int -> [a] -> [a]
    - Dado un int y una lista te devuelve la lista sin los primeros n elementos.

8. (++) :: [a] -> [a] -> [a]
    - Concatena dos listas 

9. concat :: Foldable t => t [a] -> [a]
    - Dada una lista de listas te devuelve una lista con los elementos de todas las listas en la lista (re turbio)

10. (!!) :: GHC.Stack.Types.HasCallStack => [a] -> Int -> a
    - Dada una lista y un entero te devuelve el elemento en la posicion i de la lista.

11. elem :: (Foldable t, Eq a) => a -> t a -> Bool
    - Dado un elemnto y una lista. El elemento tiene que ser de la clase equal y la lista de la clase (iterable?) te dice si 
    el elemento pertenece a la lista o no.
