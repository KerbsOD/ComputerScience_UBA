Ejecutando ' strace -qf ./hai64 echo “imprimir este texto” > hola.txt '

a) Se lanzan 2 procesos (el segundo es la senal SIGURG). Se escribe "sup!\n" en la direccion 1. Luego al proceso se le dice 
kill con la senal SIGURG (urgent condition on socket pero sobreescrita). Esto se repite 5 veces.
Por ultimo termina el proceso.

b) Se usan los senales para escribir "ya va" en el buffer actual. La senal SIGURG fue sobre-escrita.

c) Es un programa que dado un buffer escribe "sup!\n", luego llama a la senal SIGURG que esta modificada para escribir 
"ya va \n" en el mismo buffer, siguiente linea.



