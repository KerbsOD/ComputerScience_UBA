![[Pasted image 20230825165604.png]]

- **int argc(Argument Counter):** Cantidad de argumentos pasados por la linea de comandos. Siempre es por lo menos 1 porque el nombre del programa es considerado el primer argumento.
- **char \*argv[](Argument Vector):** Arreglo de strings (char pointers) donde cada elemento del arreglo representa un argumento pasado por la linea de comandos. argv[0] es siempre el nombbre del programa. Los argumentos que pasamos por la linea de comandos empiezan a partir del argv[1].

1. Creo los punteros destino. Va a ser la posicion donde copie el argumento.
2. Creo el int strmembytes. Va a ser el largo de mi argumento (o sea, cuantos chars).
3. Si la cantidad de argumentos que paso por la linea de comandos es diferente de 2. Es porque o no puse ningun argumento o porque puse de mas.
4. Definimos el largo del argumento para strmembytes. Se agrega + 1 para el null terminator (creo que seria '\0'). strlen no cuenta el null terminator.
5. Reservamos memoria para destino. Esto va a ser la cantidad de letras por el tamaño de una letra. (un char es de 1 byte).
6. Usamos nuestra funcion creada en assembly. Esta toma el destino (o sea, pointer donde comienza el espacio reservado para la copia), src (el argumento a ser copiado) y n que es el largo del argumento a ser copiado. 
7. Liberamos la memoria *destino* del heap.
   ![[Pasted image 20230825000910.png]]
   > Importante memorizar las Convenciones ABI. Los ints y pointers van a los R mientras que los flotantes y doubles van a los XMM. Cuando ambos espacios se acabban, se procede a la pila.
   
   
   En este caso:
- char \*dest se guarda en RDI
- char \*src se guarda en RSI
- size_t n se guarda en RDX
   
   ![[Pasted image 20230825161918.png]]

La instruccion *movs* me deja mover algo de una posicion de memoria a otra.
- **movsb:** mover byte.
- **movsw:** mover words(2bytes)
- **movsd:** mover doblewords(4bytes)
- **movsq:** mover cuadruplewords(8bytes)