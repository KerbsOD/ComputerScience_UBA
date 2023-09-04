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
- char \*dest se guarda en RDI. Destination register.
- char \*src se guarda en RSI. Source register.
- size_t n se guarda en RDX. Data register.
   
   ![[Pasted image 20230825161918.png]]
   1. Pusheamos rcx al stack para preservar su valor previo.
   2. Limpiamos el directions flag. (cld=clear direccion flags, o sea, ponerlo en 0. con std lo ponemos en 1). 
      - Si direction flag = 0 $\implies$ movs incrementa en n bytes rsi y rdi.
      - Si direction flag = 1 $\implies$ movs decrementa en n bytes rsi y rdi.
   1. Movemos el valor de rdx (n) a rcx (registro contador de intel)
   2. REPE repite la accion hasta que el registro rcx valga 0.
   3. movsb mover el byte de rsi a rdi. Luego incrementa los punteros rsi y rdi. Los puede incrementar o decrementar de acuerdo a lo que este en el *directions flag*.

> **movs** automaticamente mueve byte a byte (movesb) desde RSi hasta RDI. Luego incrementa o decrementa la direccion a la que apuntan ambos registros. 
> - Si usamos movsb los incrementa o decrementa en 1 byte.
> - Si usamos movsw los incrementa o decrementa en 2 bytes.
> - Si usamos movesd los incrementa o decrementa en 4 bytes.
> - Si usamos movesq los incrementa o decrementa en 8 bytes.