1) Queda ligada a la instancia anObject, es decir, al receptor del mensaje.

2)
La pseudo-variable super en el contexto de ejecución del método aMessage también hace referencia a anObject, igual que self. Sin embargo, la diferencia entre self y super no está en a qué objeto hacen referencia, sino en cómo buscan los métodos:
    - self busca métodos empezando por la clase del receptor del mensaje.
    - super busca métodos empezando por la clase padre de la clase en la que está definido el método que hace referencia a super.
En otras palabras, super invoca el método del mismo nombre comenzando la búsqueda en la superclase de la clase en la que está el método actual.

3) Si, hacen referencia al mismo objeto en todos los contextos de ejecucion.