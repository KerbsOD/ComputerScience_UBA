Object subclass: Counter [
    |count|"Instance variable."
    
    class << new [
        ^ super new initialize: 0.
    ]
    
    initialize: aValue [
        count := aValue.
        ^ self.
    ]
    
    next [
        self initialize: count+1.
        ^ count.
    ]

    nextIf: condition [
        ^ condition ifTrue:  [ self next ]
                    ifFalse: [ count ]
    ]
]

Counter subclass: FlexibleCounter[
    |block|"Instance variable"
    class << new: aBlock [
        ^ super new useBlock: aBlock.
    ]
    useBlock: aBlock [
        block := aBlock.
        ^ self.
    ]
    next [
        self initialize: ( block value: count ).
        ^ count.
    ]
]


aCounter := FlexibleCounter new: [:v | v+2 ]. 
"
1. A la clase FlexibleCounter se le envia el mensaje new con un bloque.
2. new: aBlock de FlexibleCounter llama 'super new', busca el metodo new en Counter.
3. new de Counter llama 'super new', busca el metodo 'new' en Object.
4. Object new devuelve una instancia de un FlexibleCounter, aFlexibleCounter (Recordemos que super = self pero busca el metodo new mas arriba).
5. Se llama aFlexibleCounter initialize: 0.
6. Se instancia la instance variable 'count' con 0. count = 0.
7. Se retorna self.
8. Volvemos abajo de todo donde se llama aFlexibleCounter useBlock: aBlock.
9. Se instancia la instance variable block como aBlock ( [:v | v+2 ] ).
10.Se devuelve aFlexibleCounter con instance variables block = [:v | v+2 ] y count = 0.
"

aCounter nextIf: true.
"
1. Al objeto aCounter de tipo aFlexibbleCounter se le envia el mensaje nextIf: true. Como no lo encuentra, lo busca en su clase padre y lo encuentra.
2. condition = true. Al objeto true se le envia el mensaje ifTrue: [ self next ] ifFalse: [ count ]. Como true es true, a aCounter
    se le envia el mensaje next.
3. a aCounter se le envia el mensaje initialize con el colaborador igual a 0+2 = 2.
4. initialize setea la variable de instancia count en 2 y devuelve self.
5. Nos quea aCounter con instance variables block = [:v | v+2 ] y count = 2.
"

"No confundir el nombre del objeto aCounter con la clase Counter. Esta hecho para confundir :("

Resumen de Mensajes Enviados:

    - FlexibleCounter new: [:v | v+2]
    - super new
    - super new
    - initialize: 0
    - useBlock: [:v | v+2]
    - nextIf: true
    - true ifTrue: [ self next ] ifFalse: [ count ]
    - self next
    - block value: count
    - initialize: 2