# Buses
Un _BUS_ es un conjunto de cables conectado entre componentes para transferir informacion. Los Componentes deben sincronizarse para no mover distinta informacion al mismo tiempo por un mismo bus.
La velocidad del bus se ve afectada por su longitud y por la cantidad de componentes conectados. Generalmente los componentes se dividen entre _masters_ y _slaves_.

**Master**: Inicializador de acciones.
**Slave**: responde a pedidos de su master.

## Tipos de Buses
**Point-to-point**: Conexion entre 2 componentes especificos.
![[Pasted image 20230728155036.png]]
**Multipoint**: Cable compartido entre multiples componentes.
![[Pasted image 20230728155243.png]]

- **Proccessor-memory**:  cortos, muy rapidos, conectados a la memoria para maximizar el ancho de banda.
- **I/O Buses**: generalmente mas largos que proccessor-memory busses. 
- **Backplane-BUS**: Conecta el procesador, memoria e input/output devices.
- **Sincronicos**: Las operaciones ocurren solo cuando se clockea.
- **Asincronicos**: Las lineas de control coordinan las operaciones.

## Buses generales
En las computadoras tenemos diferentes buses para diferentes propositos.
- **System Bus**: 

## Bus Protocol
El bus se divide en multiples lineas de informacion.

- **Data Lines**: Contienen la informacion a ser movida.
- **Address Lines**: Indican la direccion a ser leida o escrita (por ejemplo en memoria).
- **Control Lines**: Indican que que componente tiene permiso para usar el bus y para que lo quiere usar (lectura o escritura a memoria o de un input/output).
- **Power Lines**: proveen la energia necesaria para la operacion.

