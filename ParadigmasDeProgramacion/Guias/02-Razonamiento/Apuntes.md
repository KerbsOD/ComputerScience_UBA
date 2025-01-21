# Induccion
Probarlo para cada caso del pattern matching.
Si la ecuacion es cierta para cada caso del pattern matching entonces es cierta para todos los elementos del tipo.

## Induccion sobre Booleanos
``` haskell
not True = False
not False = True 
```

**QVQ:** $\forall x:: Bool.\  not \ (not \ x) = x$ 

El not del interior solo se puede desglosar solo si le *asignamos* un valor a *x*.

## Induccion sobre Pares
```haskell
fst (x, _) = x
snd (_, y) = y
swap (x, y) = (y, x)
```

**QVQ:** $\forall p :: (a, b). \ fst \ p = snd\  (swap \ p)$ 

En este caso solo hay un caso de pattern matching para cada ecuacion. Como le tenemos que asignar un valor a p, le asignamos su valor unico para cada caso de swap y fst. Si el resultado de swap p no sigue la estructura de snd, habra que desglosarla nuevamente con alguna otra induccion.

## Induccion sobre Naturales
``` haskell
data Nat = Zero | Suc Nat

suma Zero m = m 
suma (Suc n) m = Suc (suma n) m
```

**QVQ:**  $\forall n :: Nat.\ suma \ n \ Zero = \ n$ 

En este caso n puede ser *Zero* o puede ser *Suc n*. 
Por hipotesis inductiva decimos que la propiedad se cumple para *n*, queremos ver que se cumple para *Suc n*.
Es como cuando en algebra deciamos "Hipotesis inductiva, la propiedad P vale para n. Quiero ver que vale para n+1"

$Si \ P(Zero) \ y\ \forall n :: Nat. \ (P(n) \implies P(Suc \ n)$, entonces $\forall n:Nat. P(n)$

## Induccion estructural
![[Pasted image 20250119105453.png]]

![[Pasted image 20250119105806.png]]

Si vale sobre los casos base, quiero ver que se cumple para los **recursivos del tipo a probar (en listas asumimos que vale sobre la lista xs, en arboles asumimos que vale sobre los arboles i y d)** asumiendo que valen los datos del paso recursivo.

## Extensionalidad

## Extensionalidad sobre Pares

Si se tiene un par *p* del tipo *(a, b)*, la extensionalidad asegura que *p* puede ser descripto por sus componentes.

$p = (x, y)$ con $x :: a, \ y :: b$

- *p* esta compuesto por exactamente dos valores.
- Si dos pares son iguales entonces tambien los son sus componentes.

## Extensionalidad para Sumas

Cualquier instancia $e :: Either$ pertenece a una de las dos formas $\exists x :: a \ | \ e = Left\ x$ o $\exists y :: b \ | \ e = Right\ y$.

- e no puede ser ambas a la vez, es de alguna de las dos formas de manera exclusiva.
- Si sabemos de que forma es entonces podemos acceder al valor del componente.
