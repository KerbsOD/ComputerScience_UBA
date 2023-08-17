__Load__: traer a un registro un dato de memoria.
__Store__: guardar en memoria el dato de un registro

## ISA
Hay dos tipos de ISAs. ISA registro-memoria (Intel) o ISA Load-Store (Riscv)(buscamos los datos en memoria y los guardamos en los registros para operaciones)
- __Registro de proposito general__: Todos los registros sirven para lo que sea independientemente del nombre. 
- __Registro dedicados__: Registros de proposito general.

_Direccionamiento de Memoria_: Alineacion obligatoria de datos vs. administracion de a bytes.

Las instrucciones de intel tienen tamaño variable mientras que arm o riscv tienen un tamaño fijo.

## Organizacion
AMD e INTEL tienen la misma ISA pero __diferente organizacion__. No es lo mismo Arquitectura que organizacion. Pueden manejarse de manera diferente. Por ejemplo como se maneja el cache.

## Hardware
Dos procesadores pueden tener la misma ISA y la misma organizacion pero diferentes tipos de hardware, por ejemplo para apagar modulos del procesador y asi ahorrar energia. Mientras que el otro no lo tiene, consume mas.

