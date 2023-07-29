# La arquitectura
- Los datos y los programas se almacenan en la misma memoria de lectura-escritura.
- Los contenidos de esta memoria se direccionan indicando su posicion sin importar su tipo.
- Ejecucion en secuencia.
- Se evito que la programacion sea solo un tema de la "ingenieria electronica".

![[Pasted image 20230726155851.png]]

#### Ciclos de Instruccion

![[Pasted image 20230726162809.png]]

- **Fetch**: Se obtiene la instruccion almacenada en la **direccion** de memoria que indica el _PC_. Luego se incrementa el _PC_, con la _ALU_ o con un incrementador propio. Se escribe en el _IR_ la instruccion a ejecutar.

- **Decode**: Se decodifica la instruccion traida de memoria en un lenguaje que la _ALU_ pueda entender.

- **Execute**: La _ALU_ realiza la operacion que corresponde. Se escribe un resultado en memoria o se modifica algun registro. Luego vamos nuevamente al fetch.

#### Componentes

- **Control Unit**: Supervisa la ejecucion de todas las instrucciones y la transferencia de toda la informacion. Coordina el labor de los componentes mediante las senales. Extrae elementos de la memoria, le dice a la ALU como operar y utiliza al PC para saber cual es la siguiente instruccion a ejecutar.

- **Registros**: Objetos fisicos que guardan valores binarios. Se encuentran en el procesador y son de acceso **inmediato**. Hay de proposito general (variables) y especial (_PC_, *IR*)

- **ALU**: Lleva a cabo operaciones logicas y aritmeticas. En la arquitectura x86 estas operaciones afectan a las denominadas flags. No pasa en Risc-V pues no tiene flags. La _ALU_ es controlada por la *Control Unit*.
- [[Memoria]]
- [[Entrada-Salida]]