data Componente = Contenedor | Motor | Escudo | Canon deriving Eq

data NaveEspacial = Modulo Componente NaveEspacial NaveEspacial | Base Componente deriving Eq