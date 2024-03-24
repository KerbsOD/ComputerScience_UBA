!classDefinition: #Ejercicio3Test category: #Ejercicio3!
DenotativeObject subclass: #Ejercicio3Test
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ejercicio3Test class' category: #Ejercicio3!
Ejercicio3Test class
	instanceVariableNames: ''!

!Ejercicio3Test class methodsFor: 'Verdadero' stamp: 'OK 3/21/2024 11:08:58'!
testVerdaderoNoEsFalso
	Assert that: Verdadero no isEqualTo: Falso! !

!Ejercicio3Test class methodsFor: 'Verdadero' stamp: 'OK 3/21/2024 11:10:09'!
testVerdaderoOFalsoEsVerdadero
	Assert that: (Verdadero o: Falso) isEqualTo: Verdadero.! !

!Ejercicio3Test class methodsFor: 'Verdadero' stamp: 'OK 3/21/2024 11:10:36'!
testVerdaderoOVerdaderoEsVerdadero
	Assert that: (Verdadero o: Verdadero) isEqualTo: Verdadero.! !

!Ejercicio3Test class methodsFor: 'Verdadero' stamp: 'KerbsOctavio 3/21/2024 21:12:02'!
testVerdaderoSiFalso
	| Accion | 
	
	Accion := #NoSeRealizaAccion.
	
	Verdadero siFalso: [Accion := #SeRealizaAccion].
	
	Assert that: Accion isEqualTo: #NoSeRealizaAccion! !

!Ejercicio3Test class methodsFor: 'Verdadero' stamp: 'KerbsOctavio 3/21/2024 21:12:48'!
testVerdaderoSiVerdadero
	| accion | 
	
	accion := #NoSeRealizaAccion.
	
	Verdadero siVerdadero: [accion := #SeRealizaAccion].
	
	Assert that: accion isEqualTo: #SeRealizaAccion! !

!Ejercicio3Test class methodsFor: 'Verdadero' stamp: 'OK 3/21/2024 11:11:49'!
testVerdaderoYFalsoEsFalso
	Assert that: (Verdadero y: Falso) isEqualTo: Falso! !

!Ejercicio3Test class methodsFor: 'Verdadero' stamp: 'OK 3/21/2024 11:12:08'!
testVerdaderoYVerdaderoEsVerdadero
	Assert that: (Verdadero y: Verdadero) isEqualTo: Verdadero! !


!Ejercicio3Test class methodsFor: 'Falso' stamp: 'OK 3/21/2024 10:34:31'!
testFalsoNoEsVerdadero
	Assert that: Falso no isEqualTo: Verdadero! !

!Ejercicio3Test class methodsFor: 'Falso' stamp: 'OK 3/21/2024 10:40:38'!
testFalsoOFalsoEsFalso
	Assert that: (Falso o: Falso) isEqualTo: Falso.! !

!Ejercicio3Test class methodsFor: 'Falso' stamp: 'OK 3/21/2024 10:53:50'!
testFalsoOVerdaderoEsVerdadero
	Assert that: (Falso o: Verdadero) isEqualTo: Verdadero ! !

!Ejercicio3Test class methodsFor: 'Falso' stamp: 'KerbsOctavio 3/21/2024 21:17:25'!
testFalsoSiFalso 
	| Accion | 
	
	Accion := #NoSeRealizaAccion.
	
	Falso siFalso: [Accion := #SeRealizaAccion].
	
	Assert that: Accion isEqualTo: #SeRealizaAccion.! !

!Ejercicio3Test class methodsFor: 'Falso' stamp: 'KerbsOctavio 3/21/2024 21:17:34'!
testFalsoSiVerdadero
	| Accion | 
	
	Accion := #NoSeRealizaAccion.
	
	Falso siVerdadero: [Accion := #SeRealizaAccion].
	
	Assert that: Accion isEqualTo: #NoSeRealizaAccion.! !

!Ejercicio3Test class methodsFor: 'Falso' stamp: 'OK 3/21/2024 10:57:15'!
testFalsoYFalsoEsFalso
	Assert that: (Falso y: Falso) isEqualTo: Falso! !

!Ejercicio3Test class methodsFor: 'Falso' stamp: 'OK 3/21/2024 10:57:30'!
testFalsoYVerdaderoEsFalso
	Assert that: (Falso y: Verdadero) isEqualTo: Falso! !


!classDefinition: #Falso category: #Ejercicio3!
DenotativeObject subclass: #Falso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Falso class' category: #Ejercicio3!
Falso class
	instanceVariableNames: ''!

!Falso class methodsFor: 'as yet unclassified' stamp: 'OK 3/20/2024 23:46:54'!
no
	^Verdadero! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'OK 3/20/2024 23:48:46'!
o: unBooleano
	^unBooleano! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'KerbsOctavio 3/21/2024 20:41:54'!
siFalso: unaAccionARealizarUIgnorar
	unaAccionARealizarUIgnorar value ! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'OK 3/21/2024 11:05:32'!
siVerdadero: unaAccionARealizarUIgnorar
	! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'OK 3/20/2024 23:49:04'!
y: unBooleano
	^self! !


!classDefinition: #Verdadero category: #Ejercicio3!
DenotativeObject subclass: #Verdadero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Verdadero class' category: #Ejercicio3!
Verdadero class
	instanceVariableNames: ''!

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'OK 3/20/2024 23:46:47'!
no
	^Falso! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'OK 3/20/2024 23:47:11'!
o: unBooleano
	^self! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'OK 3/21/2024 11:05:56'!
siFalso: unaAccionARealizarUIgnorar
	! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'OK 3/20/2024 23:47:24'!
y: unBooleano
	^unBooleano! !


!Verdadero class methodsFor: 'as yet unclassified' stamp: 'OK 3/20/2024 23:46:47'!
no
	^Falso! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'OK 3/20/2024 23:47:11'!
o: unBooleano
	^self! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'OK 3/21/2024 11:05:56'!
siFalso: unaAccionARealizarUIgnorar
	! !

!Verdadero class methodsFor: '-- all --' stamp: 'KerbsOctavio 3/21/2024 20:50:42'!
siVerdadero: unaAccionARealizarUIgnorar
	unaAccionARealizarUIgnorar value! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'OK 3/20/2024 23:47:24'!
y: unBooleano
	^unBooleano! !
