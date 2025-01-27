# Ejercicio 1
## 1.1
``` haskell
∀p::(a,b). intercambiar (intercambiar p) = p

-- Por principio de extensionalidad para pares basta ver que ∀p :: (a,b). ∃x::a. ∃y::b. p = (x,y).

-- Demostrar
intercambiar (intercambiar (x,y)) = (x,y)

intercambiar (intercambiar (x,y)) 
{I1} = intercambiar (y,x) 
{I1} = (x,y)
{EP} = p
```

## 1.2
``` haskell
∀p::(a,(b,c)). asociarD (asociarI p) = p

-- Por principio de extensionalidad para pares basta ver que ∀p :: (a,d). ∃x::a. ∃w::d. p = (x,w).

-- Demostrar
asociarD (asociarI (x,w)) = (x,w)

-- Por principio de extensionalidad para pares basta ver que ∀w :: (b,c). ∃y::b. ∃z::c. w = (y,z).

-- Demostrar
asociarD (asociarI (x,(y,z))) = (x,(y,z))

asociarD (asociarI (x,(y,z)))  
{A1} = asociarD ((x,y),z) 
{AD} = (x,(y,z)) 
{EP} = p
```

## 1.3
``` haskell
∀p::Either a b. espejar (espejar p) = p

-- Por principio de extensionalidad para sumas basta ver que ∀p :: Either a b. 
-- o bien ∃x::a. p = Left x 
-- o bien ∃y::b. p = Right y

-- Demostrar
espejar (espejar p) = p

-- Caso p = Left x 
espejar (espejar Left x)  
{E1} = espejar Right x  
{E2} = Left x 
{EP} = p

-- Caso p = Right y
espejar (espejar Right y)
{E2} = espejar Left y
{E1} = Right y
{EP} = p
```

## 1.4
``` haskell
∀x::a. ∀ y::b. flip (flip f) x y = f x y

-- Demostrar
flip (flip f) x y = f x y

flip (flip f) x y
{F1} = (flip f) y x 
{F1} = f x y
```

## 1.5
``` haskell
∀f::a->b->c. ∀x::a. ∀y::b. curry (uncurry f) x y = f x y

-- Demostrar
curry (uncurry f) x y = f x y

curry (uncurry f) x y
{C1} = (uncurry f) (x,y)
{U1} = f x y
```

# Ejercicio 2

## 2.1 
```haskell
flip . flip = id

-- Por principio de extensionalidad funcional basta ver que ∀f::a->b->c. ∀x::a. ∀y::b.

-- Demostrar
(flip . flip) f x y = id f x y

(flip . flip) f x y 
{D.} = flip (flip f x y)
{F1} = flip f y x
{F1} = f x y
{ID} = id f x y
```

## 2.2
```haskell
∀f::(a,b)->c. uncurry (curry f) = f 

-- Por principio de extensionalidad funcional basta ver que ∀f::(a,b)->c. ∀p :: (a,b).

-- Demostrar 
uncurry (curry f) p = f p

-- Por principio de extensionalidad para pares basta ver que ∀f::(a,b)->c. ∀p :: (a,b). ∃x::a. ∃y::b. p = (x,y).

-- Demostrar
uncurry (curry f) (x,y) = f (x,y)

uncurry (curry f) (x,y)
{U1} = (curry f) x y
{C1} = f (x,y)
```

## 2.3
```haskell
flip const = const id

-- Por principio de extensionalidad funcional basta ver que ∀x::a. ∀y::b.

-- Demostrar
flip const x y = const id x y 

flip const x y
{F1} = const y x 
{CS} = y
{CS} = const x y
{ID} = const (id x) y
```

## 2.4
```haskell
∀f::a->b. ∀g::b->c. ∀h::c->d. ((h.g).f) = (h.(g.f))

-- Por principio de extensionalidad funcional basta ver que ∀f::a->b. ∀g::b->c. ∀h::c->d. ∀x::a.

-- Demostrar
((h.g).f) x = (h.(g.f)) x

((h.g).f) x
{D.} = (h.g) (f x)
{D.} = h (g(f x))
{D.} = h ((g.f) x)
{D.} = (h.(g.f)) x
```

# Ejercicio 3

## 3.1
```haskell
∀xs::[a]. length (duplicar xs) = 2 * length xs

-- Por principio de induccion estructural sobre listas.

-- Demostrar
P(xs): length (duplicar xs) = 2 * length xs

-- Caso base: P([])
length (duplicar []) 
{D0} = length []
{L0} = 0
{--} = 2 * 0
{L0} = 2 * length []

-- Caso inductivo: ∀x::a. ∀xs::[a]. Usando P(xs) como hipotesis inductiva, quiero ver que P(x:xs).

-- Demostrar
P(x:xs): length (duplicar x:xs) = 2 * length x:xs

length (duplicar x:xs) 
{D1} = length (x : x : duplicar xs)
{L1} = 1 + length (x : duplicar xs)
{L1} = 1 + 1 + length (duplicar xs)
{HI} = 1 + 1 + (2 * (length xs))
{--} = 2 + (2 * (length xs))
{--} = 2 * (1 + (length xs))
{L1} = 2 * length (x:xs)
```

## 3.2
```haskell
∀ xs::[a] . ∀ ys::[a] . length (append xs ys) = length xs + length ys

-- Por principio de induccion estructural sobre listas.

-- Demostrar 
P(xs): length (append xs ys) = length xs + length ys

-- Caso base: P([])
length (append [] ys)
{A0} = length (ys)
{--} = 0 + length ys
{L0} = length [] + length ys

-- Caso inductivo:  ∀x::a. ∀xs::[a]. ∀ys::[a]. Usando P(xs) como hipotesis inductiva, quiero ver que P(x:xs).

-- Demostrar
P(x:xs): length (append x:xs ys) = length x:xs + length ys

length (append x:xs ys)
{A1} = length (x : append xs ys)
{L1} = 1 + length (append xs ys)
{HI} = 1 + length xs + length ys 
{L1} = length x:xs + length ys
```

## 3.3
```haskell
∀ xs::[a] . ∀ x::a . [x]++xs = x:xs

-- Por principio de induccion estructural sobre listas.

-- Demostrar 
P(xs): [x]++xs = x:xs

-- Caso base: P([])
[x]++[]
{++} = foldr (:) [] [x]
{F1} = (:) x (foldr (:) [] [])
{F0} = (:) x []
{--} = x:[]

-- Caso inductivo:  ∀x::a. ∀xs::[a]. Usando P(xs) como hipotesis inductiva, quiero ver que P(x:xs).

-- Demostrar
P(x:xs): [x]++(x:xs) = x:(x:xs)

[x]++(x:xs)
{++} = foldr (:) (x:xs) [x]
{F1} = (:) x (foldr (:) (x:xs) [])
{F0} = (:) x (x:xs)
{--} = x:(x:xs)
```

## 3.4
```haskell
∀ xs::[a] . ∀ f::(a->b) . length (map f xs) = length xs

-- Por principio de induccion estructural sobre listas.

-- Demostrar 
P(xs): length (map f xs) = length xs

-- Caso base: P([])
length (map f [])
{M0} = length [] 

-- Caso inductivo:  ∀x::a. ∀xs::[a]. Usando P(xs) como hipotesis inductiva, quiero ver que P(x:xs).

-- Demostrar
P(x:xs): length (map f x:xs) = length x:xs

length (map f x:xs)
{M1} = length (f x : map f xs)
{L1} = 1 + length (map f xs)
{HI} = 1 + length xs 
{L1} = length x:xs
```

## 3.5
```haskell
∀ xs::[a] . ∀ p::a->Bool . ∀ e::a . ((elem e (filter p xs)) ⇒ (elem e xs)) 

-- Por principio de induccion estructural sobre listas.

-- Demostrar 
P(xs): ((elem e (filter p xs)) ⇒ (elem e xs)) = True

-- Caso base: P([])
elem e (filter p []])
{F0} = elem e []
{E0} = False
-- Como (False => cualquier cosa) = True, entonces vale.

-- Caso inductivo:  ∀x::a. ∀xs::[a]. Usando P(xs) como hipotesis inductiva, quiero ver que P(x:xs).

-- Demostrar
P(x:xs): ((elem e (filter p x:xs)) ⇒ (elem e x:xs)) = True
{F1} = ((elem e (if p x then x : (filter p xs) else (filter p xs))) ⇒ (elem e x:xs))

-- Por principio de induccion sobre booleanos.

-- Caso p x = False
((elem e (filter p xs)) ⇒ (elem e x:xs))

---- Por principio de induccion sobre booleanos.

---- Caso (elem e x:xs) = True => No importa lo que valga (elem e (filter p xs)) igualmente da True la ecuacion.

---- Caso (elem e x:xs) = False => e tampoco pertenece a filter p xs => False => False = True

-- Caso p x = True
((elem e (x : filter p xs)) ⇒ (elem e x:xs))
{E1} = ((e == x | elem e (filter p xs)) ⇒ (e == x | elem e xs))

-- Por principio de induccion sobre booleanos.

---- Caso e == x = True 
(True) ⇒ (True)
{--} = True

---- Caso e == x = False
((elem e (filter p xs)) ⇒ (elem e xs))
{HI} = True


```

## 3.6
```haskell
∀ xs::[a] . ∀ x::a . ponerAlFinal x xs = xs ++ (x:[])

-- Por principio de induccion estructural sobre listas.

-- Demostrar 
P(xs): ponerAlFinal x xs = xs ++ (x:[])

-- Caso base: P([])
ponerAlFinal x xs 
{P0} = foldr (:) (x:[]) []
{++} = [] ++ (x:[])

-- Caso inductivo:  ∀x::a. ∀xs::[a]. Usando P(xs) como hipotesis inductiva, quiero ver que P(x:xs).

-- Demostrar
P(x:xs): ponerAlFinal x x:xs = x:xs ++ (x:[])

ponerAlFinal x x:xs
{P0} = foldr (:) (x:[]) (x:xs)
{++} = (x:xs) ++ (x:[])
```

## 3.7
```haskell
reverse = foldr (\x rec -> rec ++ (x:[])) []

-- Por principio de extensionalidad funcional basta ver que ∀xs::[a]. 

-- Demostrar 
reverse xs = foldr (\x rec -> rec ++ (x:[])) [] xs

-- Por principio de induccion estructural sobre listas.

-- Demostrar 
P(xs): reverse xs = foldr (\x rec -> rec ++ (x:[])) [] xs

-- Caso base: P([])
reverse []
{R0}  = foldl (flip (:)) [] []
{FL0} = []
{FR0} = foldr (\x rec -> rec ++ (x:[])) [] []

-- Caso inductivo:  ∀x::a. ∀xs::[a]. Usando P(xs) como hipotesis inductiva, quiero ver que P(x:xs).

-- Demostrar
P(x:xs): reverse x:xs = foldr (\x rec -> rec ++ (x:[])) [] x:xs

foldr (\x rec -> rec ++ (x:[])) [] x:xs
{FR1} = (\x rec -> rec ++ (x:[])) x ( foldr (\x rec -> rec ++ (x:[])) [] xs)
{--}  = ( foldr ( \x rec -> rec ++ x:[] ) [] xs ) ++ x:[]
{HI}  = reverse xs ++ [x]

-- Llegamos a:
1. reverse x:xs 
2. reverse xs ++ [x] 

-- Queremos ver que son iguales, hacemos otra demostracion!
```

```haskell
∀x::[a].∀xs::[a]. reverse x:xs = reverse xs ++ [x]


```
## 3.8
```haskell
∀xs::[a] . ∀x::a . head (reverse (ponerAlFinal x xs)) = x

-- Por principio de induccion estructural sobre listas.

-- Demostrar 
P(xs): head (reverse (ponerAlFinal x xs)) = x

-- Caso base: P([])
head (reverse (ponerAlFinal x []))
{P0} = head (reverse (foldr (:) (x:[]) []))
{F0} = head (reverse [x])
{R0} = head (foldl (flip (:)) [] [x])
{F1} = head (foldl (flip (:)) ((flip (:)) [] x) [])
{--} = head (foldl (flip (:)) ((:) x []) [])
{--} = head (foldl (flip (:)) [x] [])
{F0} = head ([x])
{H0} = x

-- Caso inductivo:  ∀x::a. ∀xs::[a]. Usando P(xs) como hipotesis inductiva, quiero ver que P(x:xs).

-- Demostrar
P(x:xs): head (reverse (ponerAlFinal x x:xs)) = x

head (reverse (ponerAlFinal x y:ys)) 
{P0} = head ( reverse ( foldr (:) (x:[]) (y:ys) ) )
{F1} = head ( reverse ( (:) y ( foldr (:) (x:[]) ys ) ) )
{P0} = head ( reverse ( y : (ponerAlFinal x ys) ))
{R0} = head ( foldl (flip (:)) [] ( y : (ponerAlFinal x ys) ) )
{F1} = head ( foldl (flip (:)) ( (flip (:)) [] y ) (ponerAlFinal x ys) )
{--} = head ( foldl (flip (:)) y:[] (ponerAlFinal x ys) )
{--} = head (foldl (flip (:)) [y] (ponerAlFinal x ys))

```

# Ejercicio 5

```haskell
zip = zip'

-- Por principio de extensionalidad funcional basta ver que ∀xs::[a]. ∀ys::[a].  

-- Demostrar 
zip xs ys = zip' xs ys

-- Por principio de induccion estructural sobre listas.

-- Demostrar 
P(xs): zip xs ys = zip' xs ys

-- Caso base: P([])
zip [] ys
{Z0} = foldr (\x rec zs -> if null zs then [] else (x, head zs) : rec (tail zs)) (const []) [] ys
{F0} = (const []) ys
{CT} = []
{Z'0} = zip' [] ys

-- Caso inductivo:  ∀x::a. ∀xs::[a]. ∀ys::[a]. Usando P(xs) como hipotesis inductiva, quiero ver que P(x:xs).

-- Demostrar
P(x:xs): zip (x:xs) ys = zip' (x:xs) ys

f = (\x rec ys -> if null ys then [] else (x, head ys) : rec (tail ys))

zip (x:xs) ys
{Z0} = foldr f (const []) (x:xs) ys
{F1} = f x (foldr f (const []) xs) ys
{FF} = if null ys then [] else (x, head ys) : foldr f (const []) xs (tail ys) 
{Z0} = if null ys then [] else (x, head ys) : zip xs (tail ys) 
{HI} = if null ys then [] else (x, head ys) : zip' xs (tail ys) 
--Considerar que si algo vale para toda lista entonces, en particular, vale para la instancia de lista (tail ys).
{Z'1} = zip' (x:xs)
```

# Ejercicio 6

## 6.1
```haskell
Eq a => ∀xs::[a]. ∀e::a. ∀p::a -> Bool. elem e xs && p e = elem e (filter p xs)

-- Por principio de induccion estructural sobre listas.

-- Demostrar 
P(xs): elem e xs && p e = elem e (filter p xs)

-- Caso base: P([])

-- Lado izquierdo
elem e [] && p e
{E0} = False && p e
{&&} = False

-- Lado derecho
elem e (filter p [])
{F0} = elem e []
{E0} = False

-- Caso inductivo:  ∀x::a. ∀xs::[a]. Usando P(xs) como hipotesis inductiva, quiero ver que P(x:xs).

-- Demostrar
P(x:xs): elem e x:xs && p e = elem e (filter p x:xs)
-- Lado Izquierdo
elem e (x:xs) && p e
-- Lado Derecho
elem e (filter p x:xs)
{F1} = elem e (if p x then x : filter p xs else filter p xs)

-- Por principio de induccion sobre booleanos.

--- Caso (p x = True). 
--- Lado Izquierdo
elem e (x:xs) && p e
--- Lado derecho
elem e (if True then x : filter p xs else filter p xs)
{IF} = elem e (x : filter p xs)
{E1} = (e == x || elem e (filter p xs))
{HI} = (e == x || (elem e xs && p e) )
{||} = (e == x || elem e xs) && (e == x || p e)
{E1} = elem e (x:xs) && (e == x || p e)

--- Por principio de induccion sobre booleanos.

---- Caso: (p x = True), (e == x = False)
---- Lado Izquierdo
elem e (x:xs) && (p e)
---- Lado derecho
elem e (x:xs) && (False || p e)
{||} = elem e (x:xs) && (p e)

---- Caso: (p x = True), (e == x = True)
---- Lado Izquierdo
elem e (x:xs) && (p e)
{==} = elem e (x:xs) && (p x) -- Porque e == x. p x = True
{&&} = elem e (x:xs)
---- Lado derecho
elem e (x:xs) && (True || p e)
{||} = elem e (x:xs) && True
{&&} = elem e (x:xs)


--- Caso: (p x = False). 
--- Lado Izquierdo
elem e (x:xs) && p e
{E1} = (e == x || elem e xs) && p e
{||} = (e == x && p e) || (elem e xs && p e)
--- Lado derecho
elem e (if False then x : filter p xs else filter p xs)
{IF} = elem e (filter p xs)
{HI} = elem e xs && p e

---- Caso: (p x = False) y (e == x = True)
---- Lado Izquierdo
(True && p e) || (elem e xs && p e)
{&&} = (p e) || (elem e xs && p e)
{==} = (False) || (elem xs && False) -- p e = p x = False
{--} = False
---- Lado derecho
elem e xs && p e
{==} = elem e xs && False
{&&} = False
```

## 6.2
```haskell
Eq a => ∀ xs::[a] . ∀ e::a . elem e xs = elem e (nub xs)

-- Por principio de induccion estructural sobre listas.

-- Demostrar:
P(xs): elem e xs = elem e (nub xs)

-- Caso base: P([])
-- Lado izquierdo
elem e []
{E0} = False
-- Lado derecho
elem e (nub [])
{N0} = elem e []
{E0} = False

-- Caso inductivo:  ∀x::a. ∀xs::[a]. Usando P(xs) como hipotesis inductiva, quiero ver que P(x:xs).

-- Demostrar:
P(x:xs): elem e x:xs = elem e (nub x:xs)
-- Lado izquierdo
elem e x:xs
{E1} = (e == x || elem e xs)
{HI} = (e == x || elem e (nub xs))
-- Lado derecho
elem e (nub x:xs)
{N1} = elem e (x : filter (\y -> x /= y) (nub xs))
{E1} = (e == x || filter (\y -> x /= y) (nub xs))

-- Por principio de induccion sobre booleanos

-- Caso: e == x = True
-- Lado Izquierdo
(e == x || elem e (nub xs))
{DEF} = (True || elem e (nub xs))
{||}  = True 
-- Lado Derecho
(e == x || filter (\y -> x /= y) (nub xs))
{DEF} = (True || filter (\y -> x /= y) (nub xs))
{||}  = True 

-- Caso: e == x = False
-- Lado Izquierdo
(e == x || elem e (nub xs))
{DEF} = (False || elem e (nub xs))
{||}  = elem e (nub xs) 
-- Lado Derecho
(e == x || filter (\y -> x /= y) (nub xs))
{DEF} = (False || filter (\y -> x /= y) (nub xs))
{||}  = filter (\y -> x /= y) (nub xs) 

```

## 6.3
```haskell

```

## 6.4
```haskell

```

## 6.5
```haskell

```

## 6.6
```haskell

```