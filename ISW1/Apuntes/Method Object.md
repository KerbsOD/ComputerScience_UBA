#### Problema 
Metodo gigante adentro de una clase que se escapa del dominio del problema pero es necesario.
- No se simplifica correctamente con metodos compuestos. 
- Hay falta de cohesion. 

El comportamiento se representa con un solo metodo que con el tiempo crece ganando nuevas lineas, variables temporales, parametros hasta que se vuelve inmantenible. 
Cuando queramos aplicar metodos compuestos (o sea, achicarlo en pequenos metodos para que no sea tan largo) vamos a complicar mucho las cosas porque estos metodos nuevos van a necesitar todas las variables temporales y parametros 

#### Solucion 
Crear una clase que represente ese metodo muy grande usando como colaboradores internos:
- los parametros del metodo original
- el objeto donde estaba el metodo (o sea le pasamos self) 
- las variables temporales

Crearle un inicializador (constructor) que recibe el receiver original (self del objeto que usa al metodo original) y los argumentos del metodo. 

> Parametros: campos que definen el tipo y numero de inputs de un metodo,
> Argumentos: valores que son pasados al metodo cuando este es llamado.

Crear un metodo exactamente igual al metodo original pero adentro del method object. Estamos haciendo el metodo original parte del protocolo del method object.

Remplazar el metodo original en el codigo viejo con un metodo que crea la instancia del method object y enviarle el mensaje que llama al metodo grande que nos queriamos sacar de encima.

### Casos de uso
Cuando tenemos un metodo grande que queremos descomponer en muchos metodos chiquitos pero cada metodo necesita muchos argumentos (parametros/variables temporales).



