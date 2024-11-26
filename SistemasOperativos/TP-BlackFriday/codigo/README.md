# Trabajo práctico 1 - Threading

## Estructura
* En la carpeta `src` encontrarán el código que deben completar.
* En la carpeta `data` encontrarán algunos archivos que pueden usar para probar
  su solución. Les recomendamos que hagan pruebas con otros archivos, en
  particular, archivos de mayor tamaño.
* En la carpeta `scripts` encontrarán un script de `awk` que pueden usar para
  contar la cantidad de apariciones de palabras en un archivo. Combinando con
  el comando `sort` pueden usarlo para averiguar las palabras con más
  apariciones y contrastar con su solución, ejecutando:
  ```
  awk -f contar-palabras.awk <archivo> | sort -nk 2
  ```
  Las palabras más repetidas aparecerán al final del output.

## Compilación
* El `Makefile` debería permitirles compilar el código con el comando `make`.
  El ejecutable generado estará en la carpeta `build`.
* El ejecutable se puede correr de la siguiente forma:
  ```
  ./ContarPalabras <threads_lectura> <threads_maximo> <archivo1> [<archivo2>...]
  ```
  donde:
  * `threads_lectura` es la cantidad de threads que se usará para leer archivos,
  * `threads_maximo` es la cantidad de threads que se usará para computar
    la palabra con más apariciones, y
  * `archivo1`, `archivo2`, etc. son los nombres de los archivos a procesar.

## Tests
* Ejecutando `make test` podrán compilar y ejecutar una pequeña suite de tests
  unitarios. Estos tests solo pretenden facilitarles el proceso de desarrollo
  verificando algunos aspectos básicos del funcionamiento del código.
  **No evalúan aspectos de concurrencia** y por lo tanto no brindan ninguna
  garantía de que el código escrito sea correcto.

## Intensivo
* Se agregó un archivo para testear con intensidad nuestra implementacion.
* Para compilarlo se debe ejecutar:
``` 
  make intensivo
```
* Además se incluyeron varios archivos de texto adicionales para poder probar en la carpeta data.
* Su modo de uso es similar a ContarPalabras:
``` 
  ./Intensivo <threads_lectura> <threads_maximo> <archivo1> [<archivo2>...]
```
* Algunos de nuestras pruebas favoritas:
``` 
  ./build/Intensivo <threads_lectura> <threads_maximo> data/ultraCorpus/*
  ./build/Intensivo <threads_lectura> <threads_maximo> data/war-peace/*
  ./build/Intensivo <threads_lectura> <threads_maximo> data/Shakespeare/*
  ./build/Intensivo <threads_lectura> <threads_maximo> data/megaIntensivo/*
 
```
* Por un tema de sanidad mental al momento de compilarse se utiliza la bandera -O2 y además las operaciónes están 
  limitadas a durar 3 minutos c/u. Esto no quita que en el peor de los casos pueda estar mucho tiempo 
  correindo el programa