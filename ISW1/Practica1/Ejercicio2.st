!classDefinition: #Bill category: #Ejercicio2!
DenotativeObject subclass: #Bill
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Bill class' category: #Ejercicio2!
Bill class
	instanceVariableNames: 'energia'!

!Bill class methodsFor: 'as yet unclassified' stamp: 'OK 3/20/2024 23:36:05'!
caminar: unaCantidadDeKilometros
	energia := energia - unaCantidadDeKilometros  - 3.
	^ energia! !

!Bill class methodsFor: 'as yet unclassified' stamp: 'OK 3/20/2024 23:33:18'!
comer: unaCantidadDeKilosDeCerebro
	energia := unaCantidadDeKilosDeCerebro * 4 + energia.
	^ energia
! !

!Bill class methodsFor: 'as yet unclassified' stamp: 'OK 3/20/2024 23:24:37'!
energia
	^energia! !

!Bill class methodsFor: 'as yet unclassified' stamp: 'OK 3/20/2024 23:39:33'!
init
	energia := 28! !


!Bill class methodsFor: '--** private fileout/in **--' stamp: 'KerbsOctavio 3/24/2024 13:30:52'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	energia := 28.! !

Bill initializeAfterFileIn!