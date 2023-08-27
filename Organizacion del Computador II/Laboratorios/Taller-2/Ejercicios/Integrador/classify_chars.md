# Documentacion Funcion classify_chars
![[Pasted image 20230827015602.png]]
Nos dan un arreglo del tipo **classifier_t** (*array*) y el tamaño de este (*size_of_array*). 

Se nos brinda la siguiente data de **classifier_t**:
![[Pasted image 20230827013229.png]]
- *vowels_and_consonants* apunta a **NULL**. 
  > char\*\* representa la posicion de memoria donde comienza un arreglo de palabras (arreglo de arreglo de letras).
- *string* viene inicializado con una palabra cargada. 
  > char* representa la posicion de memoria donde comienza un arreglo de letras (una palabra).
- *string* tiene **como mucho** 64 vocales y 64 consonantes. 
###### Algoritmo

Para cada *classifier_t* se nos pide:
1. Inicializar *vowels_and_consonants*. Es un arreglo que contiene 2 arreglos dentro. Un arreglo para guardar las vocales de *string* y un arreglo para guardar las consonantes de *string*. Posicion 0 y 1 respectivamente. 
   ![[Pasted image 20230827015311.png]]
   > Recordar que array[i] representa a una instancia de la estructura *classifier_t*
2. Inicializar un arreglo para las *vocales*.
   ![[Pasted image 20230827015326.png]]
3. Inicializar un arreglo para las *consonantes*.
   ![[Pasted image 20230827015341.png]]
   > Notar el uso de *calloc* en vez de malloc. Esto nos inicializa todos los bytes en 0. Queremos que todos los bytes valgan 0 porque no sabemos cuando vamos a dejar de agregar vocales o consonantes al array. 
   > Son 65 elementos porque pueden haber 64 vocales o consonantes y por ultimo necesitamos el '\0' que cierra una palabra en C. 
   

4. Llamar a la funcion que, dado un string y los arreglos de vocales y consonantes, llena el array de vocales con las vocales del string y llena el array de consonantes con las consonantes del string.
   ![[Pasted image 20230827015456.png]]
   # Documentacion Funcion classify_chars_in_string
![[Pasted image 20230827015618.png]]

- *stringIterator* va a recorrer el string letra por letra.
- *vowelIterator* empieza en la posicion inicial del arreglo de vocales. Si agregamos una vocal entonces pasa a la siguiente posicion.
- *constantInterator* empieza en la posicion inicial del arreglo de vocales. Si agregamos una consonante entonces pasa a la siguiente posicion.

###### Algoritmo

1. Mientras que no lleguemos al final del string (recordar que un string en c termina cuando la letra es '\0').
2. Creamos letter para que sea mas lindo, simplemente representa a la desreferencia del stringIterator.
3. Si *letter* es una vocal, entonces la ponemos en el arreglo de vocales. Avanzamos en 1 la posicion en el arreglo de vocales.
4. Si *letter* no es una vocal, entonces la ponemos en el arreglo de consonantes. Avanzamos en 1 la posicion en el arreglo de consonantes.
5. Pasamos a la siguiente posicion en string.

> *memset(ptr, @, n)* pone en ptr el simbolo @ n veces. 
> Por eso necesitabamos el vowelIterator y el consonantIterator. Son pointer a la direccion actual en sus respectivos arreglos. Si hay una letra que tiene que entrar en ese arreglo usamos memset para que la ponga 1 vez y despues avanzamos el pointer a la posicion siguiente.