# Extract as Parameter
Convierte un dato en un parametro del mensaje. Crea parametros.
- Add parameter agrega uno nuevo al mensaje sin hacer nada.
- Remove parameter lo elimina.

# Temporary to instance variable
Convierte una variable temporal del metodo a una variable de instancia del objeto.

# Extract method
Convierte una serie de pasos en un un mensaje. Es necesario que la serie de pasos no use variables temporales del metodo actual porque **NO** convierte las temporales en parametros.

# Inline temporary variable
Cambia todas las aparciones de la variable temporal por su valor y la remueve del metodo.

# inline method
Cambia todas las apariciones del metodo por su implementacion y remueve el metodo de los mensajes del objeto.
