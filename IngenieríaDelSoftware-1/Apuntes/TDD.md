# Introducción
TDD es una técnica de desarrollo de software que consiste en tener una lista de requisitos, **escribir un test que falle** (siendo el test referencia a algun requisito que se quiere cumplir), **escribir la implementación mas simple** (casi hardcodeado) que pase el test, y luego **refactorizar**. Si encontramos un caso borde, lo agregamos a la lista. 
Iteramos hasta completar todos los requisitos.

# Ciclo

![[Drawing 2024-07-08 08.02.03.excalidraw]]


**RED**: Escribir un test que falle.
**GREEN**: Implementamos el minimo codigo para que el test nuevo pase (y los anteriores no se rompan).
**REFACTOR**: Luego de que el codigo pase el test examinamos si hay alguna mejora.   

# Herramienta de Diseño
Nos ayuda a diseñar la API que va a tener nuestro sistema. 
Nos obliga a pensar en cómo queremos utilizarlo. 
Esto suele acabar derivando en componentes con responsabilidades bien definidas y bajo acoplamiento.

> TDD nos obliga a ser el primer usuario del sistema que estamos diseñando

TDD nos ayuda a tener codigo mas simple, no a obtener mas tests.

# Pasos para diseñar un sistema con TDD

1. Elegimos un requisito.
2. Escribimos un test que falla.
3. Creamos la implementación mas simple para que el test pase.
4. Refactorizamos.
5. Actualizamos lista de requisitos.

Al actualizar la lista de requisitos tachamos el requisito implementado y agregamos los que hayan surgido de la iteración de aprendizaje.
# Diseño emergente
Mientras diseñamos el sistema con los requisitos originales podemos encontrarnos nuevos casos borde que no tuvimos en cuenta en la especificacion.

# Estrategias de implementación

**Implementación falsa**
Una vez que tenemos el test fallando, la forma más rápida de obtener la primera implementación es creando un fake que devuelva una constante. 

Al tener el test pasando podemos avanzar al siguiente test.

Una ventaja de la implementación falsa es mantenernos en el problema real y no "adelantarnos" con la implementación. Evitamos las *optimizaciones prematuras*.

**Triangular**
Paso siguiente a la *implementación falsa*. Trata sobre extender los casos para llegar a una generalización.

``` C++
// Iteración 1
esPar(n = 0)
	return true
	
// Iteración 2
esPar(n = 1)
	if n == 1 {
		return false
	}
	return true
	
//Iteración 3
esPar(n = 2)
	if n == 1 {
		return false
	}
	if n == 2 {
		return true
	}
	return true
	
// Iteración 4 (generalización)
esPar(n = 2)
	return n % 2 == 0
```

1. Escoger el caso más simple que debe resolver el algoritmo.
2. Aplicar _Red-Green-Refactor_.
3. Repetir los pasos anteriores cubriendo los diferentes casos posibles.

**Implementación obvia**
Cuando la solución parece muy sencilla, lo ideal es escribir la implementación obvia en las primeras iteraciones del ciclo _Red-Green-Refactor_.


# Consejos

1. Siempre refactorizar el código luego de una triangulación.
2. Nunca refactorizar si todavia hay tests que no pasan.
3. Nombres de tests declarativos para saber que se quiere testear.
4. Empezar por los casos mas simples.
5. Correr todos los tests juntos. Asi sabemos que hacer pasar un test no rompió al resto.
6. También hay que refactorizar el código de tests.
7. Hay que testear *funcionalidades*, no tirar asserts porque si.
8. Evitar los tests fragiles (no están en control del sistema. ej: base de datos, validador extero, archivo de entrada, etc.).
9. En un sistema grande conviene empezar el testeo por componentes medianos. Los grandes (por ejemplo el sistema en si) son demasiado complejos para hacer tests simples y los chicos (por ejemplo un libro en un e-commerce) no agregan mucho valor.
10. Si testeamos componentes mas grandes, no volvemos a testear cosas que ya testeamos en sus sub-componentes. (Ej: Si tenemos un supermercado y ya testeamos que no se puede hacer checkout al carrito vacio entonces a la hora de testear el cajero, no volvemos a ver si el carrito esta vacio)
11. Nunca agregar tests que pasan a la primera (no aprendimos nada).

# Tipos de objetos simuladores para tests
Son una implementación de mentira de la interfaz de los colaboradores. Simulan ser el objeto *externo*. De esta manera el test tiene completo control (consejo 8) y no depende de factores externos que pueden cambiar el resultado sin haber cambiado el código 
(Ej: Supongamos que tenemos un test donde cargamos un archivo externo y el test pasa. Si alguien del proyecto cambia un poco el archivo entonces el test puede dejar de funcionar por un factor externo al código. Solución: Un objeto que simule ser el archivo con el contenido hardcodeado. El test deja de funcionar solo si alguien cambia el test en si porque el objeto pasas a ser propiedad del test en algún sentido).

**Mock**: Verifica que se hicieron una serie de pasos. Se quiere verificar la lógica interna del software. No verifica estado. Se testea que la *colaboración* de objetos sea la esperada. Test de caja blanca. 

Ej: Verificar que en una suma entre x e y le haya llegado el mensaje "suma" a x.

> Evitar los **mocks**. No testean funcionalidad. (consejo 7).

**Stub**: Un objeto que tiene un protocolo con respuestas hardcodeadas. 
Su interfaz es polimórfica con el objeto al que simula (solo los mensajes que neceistamos para los tests, mismo protocolo diferente implementación).

Ej: Una base de datos. Para que el test no sea fragil (consejo 8) simulamos la base de datos. 
Cuando testeamos le pasamos el stub. 
Cuando integramos le pasamos la base de datos real. 
El codigo fuente envia los mismos mensajes a la base de datos pero la base de datos es diferente dependiendo del entorno. 
Responde el dato real en integración.
Responde el dato hardcodeado para ese mensaje en testeo. El test tiene completo control sobre que responde cada mensaje del stub.

```C++
// Caso real
database = myEnterpriseDatabaseWithKey(DATABASE_KEY).
data = database.request("octo").
print(data). // Octavio Dario Kerbs

// Stub
databaseStub >> request: aNickName
	return Juan Perez

database = databaseStub new.
data = database.request("octo").
print(data). // Juan Perez

```

**Fake**: Hace lo mismo que el objeto al que simula pero a menor escala. Por ejemplo una base de datos con una sola tabla. 

