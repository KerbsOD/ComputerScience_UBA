generarBloqueInfinito
	
	^ [self generarBloqueInfinitoWithCounter: 1].

generarBloqueInfinitoWithCounter: aCounter

	| nextBlock array |
	
	nextBlock := [self class new generarBloqueInfinitoWithCounter: (aCounter + 1)].
	
	array := Array new: 2.
	array atWrap: 1 put: aCounter.
	array atWrap: 2 put: nextBlock.
	
	^ array.


Se puede probar con 
|b1 b2  b3|
b1 := BlockClosure new generarBloqueInfinito.
b1 value.
b2 := b1 value atWrap: 2.
b2 value.
b3 := b2 value atWrap: 2.
b3 value.

Sin el value les da el closure, con el value les da el arreglo donde en la primera posicion esta el numero del bloque y en la segunda esta el sigueinte bloque.