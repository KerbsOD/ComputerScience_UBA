!classDefinition: #I category: #Ejercicio4!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #Ejercicio4!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'Adjacents' stamp: 'KerbsOctavio 3/23/2024 00:58:25'!
next
	^II! !

!I class methodsFor: 'Adjacents' stamp: 'KerbsOctavio 3/23/2024 00:49:28'!
previous 
	! !


!I class methodsFor: 'Operations' stamp: 'OK 3/24/2024 16:06:18'!
* aMultiplicand
	^aMultiplicand ! !

!I class methodsFor: 'Operations' stamp: 'OK 3/24/2024 14:05:28'!
+ anAdder
	^anAdder next.! !

!I class methodsFor: 'Operations' stamp: 'Ok 4/2/2024 08:29:58'!
- sustrahend
	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'Operations' stamp: 'OK 3/24/2024 16:57:22'!
/ dividend
	^dividend! !

!I class methodsFor: 'Operations' stamp: 'Ok 4/2/2024 08:29:36'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^ 'You are trying to substract a number to a smaller number'! !

!I class methodsFor: 'Operations' stamp: 'OK 3/24/2024 15:46:56'!
restarA: minuendo
	^minuendo previous! !


!I class methodsFor: 'Operations' stamp: 'OK 3/24/2024 16:06:18'!
* aMultiplicand
	^aMultiplicand ! !

!I class methodsFor: 'Operations' stamp: 'OK 3/24/2024 14:05:28'!
+ anAdder
	^anAdder next.! !

!I class methodsFor: 'Operations' stamp: 'Ok 4/2/2024 08:29:58'!
- sustrahend
	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'Operations' stamp: 'OK 3/24/2024 16:57:22'!
/ dividend
	^dividend! !

!I class methodsFor: '-- all --' stamp: 'Ok 4/2/2024 08:33:08'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'Cant divide a number by a greater number'! !

!I class methodsFor: 'Operations' stamp: 'Ok 4/2/2024 08:29:36'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^ 'You are trying to substract a number to a smaller number'! !

!I class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !

!I class methodsFor: 'Adjacents' stamp: 'KerbsOctavio 3/23/2024 00:58:25'!
next
	^II! !

!I class methodsFor: 'Adjacents' stamp: 'KerbsOctavio 3/23/2024 00:49:28'!
previous 
	! !

!I class methodsFor: 'Operations' stamp: 'OK 3/24/2024 15:46:56'!
restarA: minuendo
	^minuendo previous! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !


!classDefinition: #II category: #Ejercicio4!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #Ejercicio4!
II class
	instanceVariableNames: 'previous next'!

!II class methodsFor: 'Adjacents' stamp: 'Ok 4/2/2024 10:12:02'!
next

	|nameRomano|
	
	nameRomano := ​self name, 'I'.
	(self name endsWith: 'III') ifTrue:[nameRomano := (self name withoutSuffix: 'III'), 'IV'].
	(self name endsWith: 'IV') ifTrue:[nameRomano := (self name withoutSuffix: 'IV'), 'V'].
	​(self name endsWith: 'VIII') ifTrue:[nameRomano := (self name withoutSuffix: 'VIII'), 'IX'].
	(self name endsWith: 'IX') ifTrue:[nameRomano := (self name withoutSuffix: 'IX'), 'X'].
	(self name endsWith: 'XXXIX') ifTrue:[nameRomano := (self name withoutSuffix: 'XXXIX'), 'XL'].
	(self name endsWith: 'XLIX') ifTrue:[nameRomano := (self name withoutSuffix: 'XLIX'), 'L'].
	(self name endsWith: 'LXXXIX') ifTrue:[nameRomano := (self name withoutSuffix: 'LXXXIX'), 'XC'].
	(self name endsWith: 'XCIX') ifTrue:[nameRomano := (self name withoutSuffix: 'XCIX'), 'C'].
	
	next := II createChildNamed: nameRomano.
	
	next previous: self.
	
	^next! !

!II class methodsFor: 'Adjacents' stamp: 'OK 3/24/2024 14:02:14'!
previous 
	^previous! !

!II class methodsFor: 'Adjacents' stamp: 'OK 3/25/2024 20:42:47'!
previous: theCurrentObject
	previous := theCurrentObject.! !


!II class methodsFor: 'Operations' stamp: 'OK 3/24/2024 16:05:56'!
* aMultiplicand
	^self previous * aMultiplicand + aMultiplicand.! !

!II class methodsFor: 'Operations' stamp: 'OK 3/24/2024 14:06:53'!
+ anAdder
	^previous + anAdder next! !

!II class methodsFor: 'Operations' stamp: 'OK 3/24/2024 15:49:18'!
- sustrahend
	^sustrahend restarA: self! !

!II class methodsFor: 'Operations' stamp: 'OK 3/24/2024 15:54:40'!
restarA: minuendo
	^minuendo previous - self previous! !


!II class methodsFor: 'Operations' stamp: 'OK 3/24/2024 16:05:56'!
* aMultiplicand
	^self previous * aMultiplicand + aMultiplicand.! !

!II class methodsFor: 'Operations' stamp: 'OK 3/24/2024 14:06:53'!
+ anAdder
	^previous + anAdder next! !

!II class methodsFor: 'Operations' stamp: 'OK 3/24/2024 15:49:18'!
- sustrahend
	^sustrahend restarA: self! !

!II class methodsFor: '-- all --' stamp: 'Ok 4/2/2024 08:31:38'!
/ dividend

	| dividendoMenosDivisor calcularCociente |

	(self isEqualTo: dividend) ifTrue: [^I].
	
	dividendoMenosDivisor  := [dividend - self] on: Error do: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].

	calcularCociente  := [(self / dividendoMenosDivisor) + I] on: Error do: [^I].
	
	^calcularCociente 
	
 	 
		
	
	
	
	
	
	! !

!II class methodsFor: '-- all --' stamp: 'Ok 4/2/2024 08:31:12'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'Cant divide a number by a greater number'! !

!II class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := I.
	next := III.! !

!II class methodsFor: 'Adjacents' stamp: 'Ok 4/2/2024 10:12:02'!
next

	|nameRomano|
	
	nameRomano := ​self name, 'I'.
	(self name endsWith: 'III') ifTrue:[nameRomano := (self name withoutSuffix: 'III'), 'IV'].
	(self name endsWith: 'IV') ifTrue:[nameRomano := (self name withoutSuffix: 'IV'), 'V'].
	​(self name endsWith: 'VIII') ifTrue:[nameRomano := (self name withoutSuffix: 'VIII'), 'IX'].
	(self name endsWith: 'IX') ifTrue:[nameRomano := (self name withoutSuffix: 'IX'), 'X'].
	(self name endsWith: 'XXXIX') ifTrue:[nameRomano := (self name withoutSuffix: 'XXXIX'), 'XL'].
	(self name endsWith: 'XLIX') ifTrue:[nameRomano := (self name withoutSuffix: 'XLIX'), 'L'].
	(self name endsWith: 'LXXXIX') ifTrue:[nameRomano := (self name withoutSuffix: 'LXXXIX'), 'XC'].
	(self name endsWith: 'XCIX') ifTrue:[nameRomano := (self name withoutSuffix: 'XCIX'), 'C'].
	
	next := II createChildNamed: nameRomano.
	
	next previous: self.
	
	^next! !

!II class methodsFor: 'Adjacents' stamp: 'OK 3/24/2024 14:02:14'!
previous 
	^previous! !

!II class methodsFor: 'Adjacents' stamp: 'OK 3/25/2024 20:42:47'!
previous: theCurrentObject
	previous := theCurrentObject.! !

!II class methodsFor: 'Operations' stamp: 'OK 3/24/2024 15:54:40'!
restarA: minuendo
	^minuendo previous - self previous! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := I.
	next := III.! !


!classDefinition: #C category: #Ejercicio4!
II subclass: #C
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'C class' category: #Ejercicio4!
C class
	instanceVariableNames: ''!

!C class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XCIX.
	next := nil.! !


!classDefinition: #III category: #Ejercicio4!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #Ejercicio4!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := II.
	next := IV.! !


!classDefinition: #IIII category: #Ejercicio4!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #Ejercicio4!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := III.
	next := AnObsoleteIIIII.! !


!classDefinition: #IIIIII category: #Ejercicio4!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: #Ejercicio4!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := AnObsoleteIIIII.
	next := IIIIIII.! !


!classDefinition: #IIIIIII category: #Ejercicio4!
II subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIII class' category: #Ejercicio4!
IIIIIII class
	instanceVariableNames: ''!

!IIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIII.
	next := IIIIIIII.! !


!classDefinition: #IIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIII class' category: #Ejercicio4!
IIIIIIII class
	instanceVariableNames: ''!

!IIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIII.
	next := IIIIIIIII.! !


!classDefinition: #IIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIII class' category: #Ejercicio4!
IIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIII.
	next := IIIIIIIIII.! !


!classDefinition: #IIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIII.
	next := IIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIII.
	next := IIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIII.
	next := IIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIII.
	next := IIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIII.
	next := IIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #Ejercicio4!
II subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: #Ejercicio4!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := nil.! !


!classDefinition: #IV category: #Ejercicio4!
II subclass: #IV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IV class' category: #Ejercicio4!
IV class
	instanceVariableNames: ''!

!IV class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := III.
	next := V.! !


!classDefinition: #IX category: #Ejercicio4!
II subclass: #IX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IX class' category: #Ejercicio4!
IX class
	instanceVariableNames: ''!

!IX class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := VIII.
	next := X.! !


!classDefinition: #L category: #Ejercicio4!
II subclass: #L
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'L class' category: #Ejercicio4!
L class
	instanceVariableNames: ''!

!L class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XLIX.
	next := LI.! !


!classDefinition: #LI category: #Ejercicio4!
II subclass: #LI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LI class' category: #Ejercicio4!
LI class
	instanceVariableNames: ''!

!LI class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := L.
	next := LII.! !


!classDefinition: #LII category: #Ejercicio4!
II subclass: #LII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LII class' category: #Ejercicio4!
LII class
	instanceVariableNames: ''!

!LII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LI.
	next := LIII.! !


!classDefinition: #LIII category: #Ejercicio4!
II subclass: #LIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LIII class' category: #Ejercicio4!
LIII class
	instanceVariableNames: ''!

!LIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LII.
	next := LIV.! !


!classDefinition: #LIV category: #Ejercicio4!
II subclass: #LIV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LIV class' category: #Ejercicio4!
LIV class
	instanceVariableNames: ''!

!LIV class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LIII.
	next := LV.! !


!classDefinition: #LIX category: #Ejercicio4!
II subclass: #LIX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LIX class' category: #Ejercicio4!
LIX class
	instanceVariableNames: ''!

!LIX class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LVIII.
	next := LX.! !


!classDefinition: #LV category: #Ejercicio4!
II subclass: #LV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LV class' category: #Ejercicio4!
LV class
	instanceVariableNames: ''!

!LV class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LIV.
	next := LVI.! !


!classDefinition: #LVI category: #Ejercicio4!
II subclass: #LVI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LVI class' category: #Ejercicio4!
LVI class
	instanceVariableNames: ''!

!LVI class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LV.
	next := LVII.! !


!classDefinition: #LVII category: #Ejercicio4!
II subclass: #LVII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LVII class' category: #Ejercicio4!
LVII class
	instanceVariableNames: ''!

!LVII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LVI.
	next := LVIII.! !


!classDefinition: #LVIII category: #Ejercicio4!
II subclass: #LVIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LVIII class' category: #Ejercicio4!
LVIII class
	instanceVariableNames: ''!

!LVIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LVII.
	next := LIX.! !


!classDefinition: #LX category: #Ejercicio4!
II subclass: #LX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LX class' category: #Ejercicio4!
LX class
	instanceVariableNames: ''!

!LX class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LIX.
	next := LXI.! !


!classDefinition: #LXI category: #Ejercicio4!
II subclass: #LXI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXI class' category: #Ejercicio4!
LXI class
	instanceVariableNames: ''!

!LXI class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LX.
	next := LXII.! !


!classDefinition: #LXII category: #Ejercicio4!
II subclass: #LXII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXII class' category: #Ejercicio4!
LXII class
	instanceVariableNames: ''!

!LXII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXI.
	next := LXIII.! !


!classDefinition: #LXIII category: #Ejercicio4!
II subclass: #LXIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXIII class' category: #Ejercicio4!
LXIII class
	instanceVariableNames: ''!

!LXIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXII.
	next := LXIV.! !


!classDefinition: #LXIV category: #Ejercicio4!
II subclass: #LXIV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXIV class' category: #Ejercicio4!
LXIV class
	instanceVariableNames: ''!

!LXIV class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXIII.
	next := LXV.! !


!classDefinition: #LXIX category: #Ejercicio4!
II subclass: #LXIX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXIX class' category: #Ejercicio4!
LXIX class
	instanceVariableNames: ''!

!LXIX class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXVIII.
	next := LXX.! !


!classDefinition: #LXV category: #Ejercicio4!
II subclass: #LXV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXV class' category: #Ejercicio4!
LXV class
	instanceVariableNames: ''!

!LXV class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXIV.
	next := LXVI.! !


!classDefinition: #LXVI category: #Ejercicio4!
II subclass: #LXVI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXVI class' category: #Ejercicio4!
LXVI class
	instanceVariableNames: ''!

!LXVI class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXV.
	next := LXVII.! !


!classDefinition: #LXVII category: #Ejercicio4!
II subclass: #LXVII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXVII class' category: #Ejercicio4!
LXVII class
	instanceVariableNames: ''!

!LXVII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXVI.
	next := LXVIII.! !


!classDefinition: #LXVIII category: #Ejercicio4!
II subclass: #LXVIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXVIII class' category: #Ejercicio4!
LXVIII class
	instanceVariableNames: ''!

!LXVIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXVII.
	next := LXIX.! !


!classDefinition: #LXX category: #Ejercicio4!
II subclass: #LXX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXX class' category: #Ejercicio4!
LXX class
	instanceVariableNames: ''!

!LXX class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXIX.
	next := LXXI.! !


!classDefinition: #LXXI category: #Ejercicio4!
II subclass: #LXXI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXXI class' category: #Ejercicio4!
LXXI class
	instanceVariableNames: ''!

!LXXI class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXX.
	next := LXXII.! !


!classDefinition: #LXXII category: #Ejercicio4!
II subclass: #LXXII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXXII class' category: #Ejercicio4!
LXXII class
	instanceVariableNames: ''!

!LXXII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXXI.
	next := LXXIII.! !


!classDefinition: #LXXIII category: #Ejercicio4!
II subclass: #LXXIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXXIII class' category: #Ejercicio4!
LXXIII class
	instanceVariableNames: ''!

!LXXIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXXII.
	next := LXXIV.! !


!classDefinition: #LXXIV category: #Ejercicio4!
II subclass: #LXXIV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXXIV class' category: #Ejercicio4!
LXXIV class
	instanceVariableNames: ''!

!LXXIV class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXXIII.
	next := LXXV.! !


!classDefinition: #LXXIX category: #Ejercicio4!
II subclass: #LXXIX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXXIX class' category: #Ejercicio4!
LXXIX class
	instanceVariableNames: ''!

!LXXIX class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXXVIII.
	next := LXXX.! !


!classDefinition: #LXXV category: #Ejercicio4!
II subclass: #LXXV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXXV class' category: #Ejercicio4!
LXXV class
	instanceVariableNames: ''!

!LXXV class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXXIV.
	next := LXXVI.! !


!classDefinition: #LXXVI category: #Ejercicio4!
II subclass: #LXXVI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXXVI class' category: #Ejercicio4!
LXXVI class
	instanceVariableNames: ''!

!LXXVI class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXXV.
	next := LXXVII.! !


!classDefinition: #LXXVII category: #Ejercicio4!
II subclass: #LXXVII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXXVII class' category: #Ejercicio4!
LXXVII class
	instanceVariableNames: ''!

!LXXVII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXXVI.
	next := LXXVIII.! !


!classDefinition: #LXXVIII category: #Ejercicio4!
II subclass: #LXXVIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXXVIII class' category: #Ejercicio4!
LXXVIII class
	instanceVariableNames: ''!

!LXXVIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXXVII.
	next := LXXIX.! !


!classDefinition: #LXXX category: #Ejercicio4!
II subclass: #LXXX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXXX class' category: #Ejercicio4!
LXXX class
	instanceVariableNames: ''!

!LXXX class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXXIX.
	next := LXXXI.! !


!classDefinition: #LXXXI category: #Ejercicio4!
II subclass: #LXXXI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXXXI class' category: #Ejercicio4!
LXXXI class
	instanceVariableNames: ''!

!LXXXI class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXXX.
	next := LXXXII.! !


!classDefinition: #LXXXII category: #Ejercicio4!
II subclass: #LXXXII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXXXII class' category: #Ejercicio4!
LXXXII class
	instanceVariableNames: ''!

!LXXXII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXXXI.
	next := LXXXIII.! !


!classDefinition: #LXXXIII category: #Ejercicio4!
II subclass: #LXXXIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXXXIII class' category: #Ejercicio4!
LXXXIII class
	instanceVariableNames: ''!

!LXXXIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXXXII.
	next := LXXXIV.! !


!classDefinition: #LXXXIV category: #Ejercicio4!
II subclass: #LXXXIV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXXXIV class' category: #Ejercicio4!
LXXXIV class
	instanceVariableNames: ''!

!LXXXIV class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXXXIII.
	next := LXXXV.! !


!classDefinition: #LXXXIX category: #Ejercicio4!
II subclass: #LXXXIX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXXXIX class' category: #Ejercicio4!
LXXXIX class
	instanceVariableNames: ''!

!LXXXIX class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXXXVIII.
	next := XC.! !


!classDefinition: #LXXXV category: #Ejercicio4!
II subclass: #LXXXV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXXXV class' category: #Ejercicio4!
LXXXV class
	instanceVariableNames: ''!

!LXXXV class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXXXIV.
	next := LXXXVI.! !


!classDefinition: #LXXXVI category: #Ejercicio4!
II subclass: #LXXXVI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXXXVI class' category: #Ejercicio4!
LXXXVI class
	instanceVariableNames: ''!

!LXXXVI class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXXXV.
	next := LXXXVII.! !


!classDefinition: #LXXXVII category: #Ejercicio4!
II subclass: #LXXXVII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXXXVII class' category: #Ejercicio4!
LXXXVII class
	instanceVariableNames: ''!

!LXXXVII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXXXVI.
	next := LXXXVIII.! !


!classDefinition: #LXXXVIII category: #Ejercicio4!
II subclass: #LXXXVIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LXXXVIII class' category: #Ejercicio4!
LXXXVIII class
	instanceVariableNames: ''!

!LXXXVIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXXXVII.
	next := LXXXIX.! !


!classDefinition: #V category: #Ejercicio4!
II subclass: #V
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'V class' category: #Ejercicio4!
V class
	instanceVariableNames: ''!

!V class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IV.
	next := VI.! !


!classDefinition: #VI category: #Ejercicio4!
II subclass: #VI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VI class' category: #Ejercicio4!
VI class
	instanceVariableNames: ''!

!VI class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := V.
	next := VII.! !


!classDefinition: #VII category: #Ejercicio4!
II subclass: #VII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VII class' category: #Ejercicio4!
VII class
	instanceVariableNames: ''!

!VII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := VI.
	next := VIII.! !


!classDefinition: #VIII category: #Ejercicio4!
II subclass: #VIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VIII class' category: #Ejercicio4!
VIII class
	instanceVariableNames: ''!

!VIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := VII.
	next := IX.! !


!classDefinition: #X category: #Ejercicio4!
II subclass: #X
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'X class' category: #Ejercicio4!
X class
	instanceVariableNames: ''!

!X class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IX.
	next := XI.! !


!classDefinition: #XC category: #Ejercicio4!
II subclass: #XC
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XC class' category: #Ejercicio4!
XC class
	instanceVariableNames: ''!

!XC class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := LXXXIX.
	next := XCI.! !


!classDefinition: #XCI category: #Ejercicio4!
II subclass: #XCI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XCI class' category: #Ejercicio4!
XCI class
	instanceVariableNames: ''!

!XCI class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XC.
	next := XCII.! !


!classDefinition: #XCII category: #Ejercicio4!
II subclass: #XCII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XCII class' category: #Ejercicio4!
XCII class
	instanceVariableNames: ''!

!XCII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XCI.
	next := XCIII.! !


!classDefinition: #XCIII category: #Ejercicio4!
II subclass: #XCIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XCIII class' category: #Ejercicio4!
XCIII class
	instanceVariableNames: ''!

!XCIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XCII.
	next := XCIV.! !


!classDefinition: #XCIV category: #Ejercicio4!
II subclass: #XCIV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XCIV class' category: #Ejercicio4!
XCIV class
	instanceVariableNames: ''!

!XCIV class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XCIII.
	next := XCV.! !


!classDefinition: #XCIX category: #Ejercicio4!
II subclass: #XCIX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XCIX class' category: #Ejercicio4!
XCIX class
	instanceVariableNames: ''!

!XCIX class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XCVIII.
	next := C.! !


!classDefinition: #XCV category: #Ejercicio4!
II subclass: #XCV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XCV class' category: #Ejercicio4!
XCV class
	instanceVariableNames: ''!

!XCV class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XCIV.
	next := XCVI.! !


!classDefinition: #XCVI category: #Ejercicio4!
II subclass: #XCVI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XCVI class' category: #Ejercicio4!
XCVI class
	instanceVariableNames: ''!

!XCVI class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XCV.
	next := XCVII.! !


!classDefinition: #XCVII category: #Ejercicio4!
II subclass: #XCVII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XCVII class' category: #Ejercicio4!
XCVII class
	instanceVariableNames: ''!

!XCVII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XCVI.
	next := XCVIII.! !


!classDefinition: #XCVIII category: #Ejercicio4!
II subclass: #XCVIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XCVIII class' category: #Ejercicio4!
XCVIII class
	instanceVariableNames: ''!

!XCVIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XCVII.
	next := XCIX.! !


!classDefinition: #XI category: #Ejercicio4!
II subclass: #XI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XI class' category: #Ejercicio4!
XI class
	instanceVariableNames: ''!

!XI class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := X.
	next := XII.! !


!classDefinition: #XII category: #Ejercicio4!
II subclass: #XII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XII class' category: #Ejercicio4!
XII class
	instanceVariableNames: ''!

!XII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XI.
	next := XIII.! !


!classDefinition: #XIII category: #Ejercicio4!
II subclass: #XIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XIII class' category: #Ejercicio4!
XIII class
	instanceVariableNames: ''!

!XIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XII.
	next := XIV.! !


!classDefinition: #XIV category: #Ejercicio4!
II subclass: #XIV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XIV class' category: #Ejercicio4!
XIV class
	instanceVariableNames: ''!

!XIV class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XIII.
	next := XV.! !


!classDefinition: #XIX category: #Ejercicio4!
II subclass: #XIX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XIX class' category: #Ejercicio4!
XIX class
	instanceVariableNames: ''!

!XIX class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XVIII.
	next := XX.! !


!classDefinition: #XL category: #Ejercicio4!
II subclass: #XL
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XL class' category: #Ejercicio4!
XL class
	instanceVariableNames: ''!

!XL class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XXXIX.
	next := XLI.! !


!classDefinition: #XLI category: #Ejercicio4!
II subclass: #XLI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XLI class' category: #Ejercicio4!
XLI class
	instanceVariableNames: ''!

!XLI class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XL.
	next := XLII.! !


!classDefinition: #XLII category: #Ejercicio4!
II subclass: #XLII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XLII class' category: #Ejercicio4!
XLII class
	instanceVariableNames: ''!

!XLII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XLI.
	next := XLIII.! !


!classDefinition: #XLIII category: #Ejercicio4!
II subclass: #XLIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XLIII class' category: #Ejercicio4!
XLIII class
	instanceVariableNames: ''!

!XLIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XLII.
	next := XLIV.! !


!classDefinition: #XLIV category: #Ejercicio4!
II subclass: #XLIV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XLIV class' category: #Ejercicio4!
XLIV class
	instanceVariableNames: ''!

!XLIV class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XLIII.
	next := XLV.! !


!classDefinition: #XLIX category: #Ejercicio4!
II subclass: #XLIX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XLIX class' category: #Ejercicio4!
XLIX class
	instanceVariableNames: ''!

!XLIX class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XLVIII.
	next := L.! !


!classDefinition: #XLV category: #Ejercicio4!
II subclass: #XLV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XLV class' category: #Ejercicio4!
XLV class
	instanceVariableNames: ''!

!XLV class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XLIV.
	next := XLVI.! !


!classDefinition: #XLVI category: #Ejercicio4!
II subclass: #XLVI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XLVI class' category: #Ejercicio4!
XLVI class
	instanceVariableNames: ''!

!XLVI class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XLV.
	next := XLVII.! !


!classDefinition: #XLVII category: #Ejercicio4!
II subclass: #XLVII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XLVII class' category: #Ejercicio4!
XLVII class
	instanceVariableNames: ''!

!XLVII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XLVI.
	next := XLVIII.! !


!classDefinition: #XLVIII category: #Ejercicio4!
II subclass: #XLVIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XLVIII class' category: #Ejercicio4!
XLVIII class
	instanceVariableNames: ''!

!XLVIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XLVII.
	next := XLIX.! !


!classDefinition: #XV category: #Ejercicio4!
II subclass: #XV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XV class' category: #Ejercicio4!
XV class
	instanceVariableNames: ''!

!XV class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XIV.
	next := XVI.! !


!classDefinition: #XVI category: #Ejercicio4!
II subclass: #XVI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XVI class' category: #Ejercicio4!
XVI class
	instanceVariableNames: ''!

!XVI class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XV.
	next := XVII.! !


!classDefinition: #XVII category: #Ejercicio4!
II subclass: #XVII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XVII class' category: #Ejercicio4!
XVII class
	instanceVariableNames: ''!

!XVII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XVI.
	next := XVIII.! !


!classDefinition: #XVIII category: #Ejercicio4!
II subclass: #XVIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XVIII class' category: #Ejercicio4!
XVIII class
	instanceVariableNames: ''!

!XVIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XVII.
	next := XIX.! !


!classDefinition: #XX category: #Ejercicio4!
II subclass: #XX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XX class' category: #Ejercicio4!
XX class
	instanceVariableNames: ''!

!XX class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XIX.
	next := XXI.! !


!classDefinition: #XXI category: #Ejercicio4!
II subclass: #XXI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXI class' category: #Ejercicio4!
XXI class
	instanceVariableNames: ''!

!XXI class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XX.
	next := XXII.! !


!classDefinition: #XXII category: #Ejercicio4!
II subclass: #XXII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXII class' category: #Ejercicio4!
XXII class
	instanceVariableNames: ''!

!XXII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XXI.
	next := XXIII.! !


!classDefinition: #XXIII category: #Ejercicio4!
II subclass: #XXIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXIII class' category: #Ejercicio4!
XXIII class
	instanceVariableNames: ''!

!XXIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XXII.
	next := XXIV.! !


!classDefinition: #XXIV category: #Ejercicio4!
II subclass: #XXIV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXIV class' category: #Ejercicio4!
XXIV class
	instanceVariableNames: ''!

!XXIV class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XXIII.
	next := XXV.! !


!classDefinition: #XXIX category: #Ejercicio4!
II subclass: #XXIX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXIX class' category: #Ejercicio4!
XXIX class
	instanceVariableNames: ''!

!XXIX class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XXVIII.
	next := XXX.! !


!classDefinition: #XXV category: #Ejercicio4!
II subclass: #XXV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXV class' category: #Ejercicio4!
XXV class
	instanceVariableNames: ''!

!XXV class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XXIV.
	next := XXVI.! !


!classDefinition: #XXVI category: #Ejercicio4!
II subclass: #XXVI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXVI class' category: #Ejercicio4!
XXVI class
	instanceVariableNames: ''!

!XXVI class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XXV.
	next := XXVII.! !


!classDefinition: #XXVII category: #Ejercicio4!
II subclass: #XXVII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXVII class' category: #Ejercicio4!
XXVII class
	instanceVariableNames: ''!

!XXVII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XXVI.
	next := XXVIII.! !


!classDefinition: #XXVIII category: #Ejercicio4!
II subclass: #XXVIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXVIII class' category: #Ejercicio4!
XXVIII class
	instanceVariableNames: ''!

!XXVIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XXVII.
	next := XXIX.! !


!classDefinition: #XXX category: #Ejercicio4!
II subclass: #XXX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXX class' category: #Ejercicio4!
XXX class
	instanceVariableNames: ''!

!XXX class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XXIX.
	next := XXXI.! !


!classDefinition: #XXXI category: #Ejercicio4!
II subclass: #XXXI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXXI class' category: #Ejercicio4!
XXXI class
	instanceVariableNames: ''!

!XXXI class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XXX.
	next := XXXII.! !


!classDefinition: #XXXII category: #Ejercicio4!
II subclass: #XXXII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXXII class' category: #Ejercicio4!
XXXII class
	instanceVariableNames: ''!

!XXXII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XXXI.
	next := XXXIII.! !


!classDefinition: #XXXIII category: #Ejercicio4!
II subclass: #XXXIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXXIII class' category: #Ejercicio4!
XXXIII class
	instanceVariableNames: ''!

!XXXIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XXXII.
	next := XXXIV.! !


!classDefinition: #XXXIV category: #Ejercicio4!
II subclass: #XXXIV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXXIV class' category: #Ejercicio4!
XXXIV class
	instanceVariableNames: ''!

!XXXIV class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XXXIII.
	next := XXXV.! !


!classDefinition: #XXXIX category: #Ejercicio4!
II subclass: #XXXIX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXXIX class' category: #Ejercicio4!
XXXIX class
	instanceVariableNames: ''!

!XXXIX class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XXXVIII.
	next := XL.! !


!classDefinition: #XXXV category: #Ejercicio4!
II subclass: #XXXV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXXV class' category: #Ejercicio4!
XXXV class
	instanceVariableNames: ''!

!XXXV class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XXXIV.
	next := XXXVI.! !


!classDefinition: #XXXVI category: #Ejercicio4!
II subclass: #XXXVI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXXVI class' category: #Ejercicio4!
XXXVI class
	instanceVariableNames: ''!

!XXXVI class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XXXV.
	next := XXXVII.! !


!classDefinition: #XXXVII category: #Ejercicio4!
II subclass: #XXXVII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXXVII class' category: #Ejercicio4!
XXXVII class
	instanceVariableNames: ''!

!XXXVII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XXXVI.
	next := XXXVIII.! !


!classDefinition: #XXXVIII category: #Ejercicio4!
II subclass: #XXXVIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXXVIII class' category: #Ejercicio4!
XXXVIII class
	instanceVariableNames: ''!

!XXXVIII class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/2/2024 10:15:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := XXXVII.
	next := XXXIX.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
C initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
IIIIIII initializeAfterFileIn!
IIIIIIII initializeAfterFileIn!
IIIIIIIII initializeAfterFileIn!
IIIIIIIIII initializeAfterFileIn!
IIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IV initializeAfterFileIn!
IX initializeAfterFileIn!
L initializeAfterFileIn!
LI initializeAfterFileIn!
LII initializeAfterFileIn!
LIII initializeAfterFileIn!
LIV initializeAfterFileIn!
LIX initializeAfterFileIn!
LV initializeAfterFileIn!
LVI initializeAfterFileIn!
LVII initializeAfterFileIn!
LVIII initializeAfterFileIn!
LX initializeAfterFileIn!
LXI initializeAfterFileIn!
LXII initializeAfterFileIn!
LXIII initializeAfterFileIn!
LXIV initializeAfterFileIn!
LXIX initializeAfterFileIn!
LXV initializeAfterFileIn!
LXVI initializeAfterFileIn!
LXVII initializeAfterFileIn!
LXVIII initializeAfterFileIn!
LXX initializeAfterFileIn!
LXXI initializeAfterFileIn!
LXXII initializeAfterFileIn!
LXXIII initializeAfterFileIn!
LXXIV initializeAfterFileIn!
LXXIX initializeAfterFileIn!
LXXV initializeAfterFileIn!
LXXVI initializeAfterFileIn!
LXXVII initializeAfterFileIn!
LXXVIII initializeAfterFileIn!
LXXX initializeAfterFileIn!
LXXXI initializeAfterFileIn!
LXXXII initializeAfterFileIn!
LXXXIII initializeAfterFileIn!
LXXXIV initializeAfterFileIn!
LXXXIX initializeAfterFileIn!
LXXXV initializeAfterFileIn!
LXXXVI initializeAfterFileIn!
LXXXVII initializeAfterFileIn!
LXXXVIII initializeAfterFileIn!
V initializeAfterFileIn!
VI initializeAfterFileIn!
VII initializeAfterFileIn!
VIII initializeAfterFileIn!
X initializeAfterFileIn!
XC initializeAfterFileIn!
XCI initializeAfterFileIn!
XCII initializeAfterFileIn!
XCIII initializeAfterFileIn!
XCIV initializeAfterFileIn!
XCIX initializeAfterFileIn!
XCV initializeAfterFileIn!
XCVI initializeAfterFileIn!
XCVII initializeAfterFileIn!
XCVIII initializeAfterFileIn!
XI initializeAfterFileIn!
XII initializeAfterFileIn!
XIII initializeAfterFileIn!
XIV initializeAfterFileIn!
XIX initializeAfterFileIn!
XL initializeAfterFileIn!
XLI initializeAfterFileIn!
XLII initializeAfterFileIn!
XLIII initializeAfterFileIn!
XLIV initializeAfterFileIn!
XLIX initializeAfterFileIn!
XLV initializeAfterFileIn!
XLVI initializeAfterFileIn!
XLVII initializeAfterFileIn!
XLVIII initializeAfterFileIn!
XV initializeAfterFileIn!
XVI initializeAfterFileIn!
XVII initializeAfterFileIn!
XVIII initializeAfterFileIn!
XX initializeAfterFileIn!
XXI initializeAfterFileIn!
XXII initializeAfterFileIn!
XXIII initializeAfterFileIn!
XXIV initializeAfterFileIn!
XXIX initializeAfterFileIn!
XXV initializeAfterFileIn!
XXVI initializeAfterFileIn!
XXVII initializeAfterFileIn!
XXVIII initializeAfterFileIn!
XXX initializeAfterFileIn!
XXXI initializeAfterFileIn!
XXXII initializeAfterFileIn!
XXXIII initializeAfterFileIn!
XXXIV initializeAfterFileIn!
XXXIX initializeAfterFileIn!
XXXV initializeAfterFileIn!
XXXVI initializeAfterFileIn!
XXXVII initializeAfterFileIn!
XXXVIII initializeAfterFileIn!