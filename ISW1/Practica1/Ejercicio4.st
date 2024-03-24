!classDefinition: #I category: #Ejercicio4!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #Ejercicio4!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'Adjacents' stamp: 'KerbsOctavio 3/23/2024 00:58:25'!
next
	^II! !

!I class methodsFor: 'Adjacents' stamp: 'KerbsOctavio 3/23/2024 00:49:28'!
previous 
	! !


!I class methodsFor: 'Operations' stamp: 'OK 3/24/2024 14:05:28'!
+ anAdder
	^anAdder next.! !

!I class methodsFor: 'Operations' stamp: 'OK 3/24/2024 15:46:56'!
restarA: minuendo
	^minuendo previous! !


!I class methodsFor: '-- all --' stamp: 'OK 3/24/2024 16:06:18'!
* aMultiplicand
	^aMultiplicand ! !

!I class methodsFor: 'Operations' stamp: 'OK 3/24/2024 14:05:28'!
+ anAdder
	^anAdder next.! !

!I class methodsFor: '-- all --' stamp: 'OK 3/24/2024 16:44:25'!
- sustrahend
	self error: #CantGoFurtherThanOne! !

!I class methodsFor: '-- all --' stamp: 'OK 3/24/2024 16:57:22'!
/ dividend
	^dividend! !

!I class methodsFor: 'Adjacents' stamp: 'KerbsOctavio 3/23/2024 00:58:25'!
next
	^II! !

!I class methodsFor: 'Adjacents' stamp: 'KerbsOctavio 3/23/2024 00:49:28'!
previous 
	! !

!I class methodsFor: 'Operations' stamp: 'OK 3/24/2024 15:46:56'!
restarA: minuendo
	^minuendo previous! !


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

!II class methodsFor: 'Adjacents' stamp: 'OK 3/24/2024 15:56:03'!
definePrevious: theCurrentObject
	previous := theCurrentObject.! !

!II class methodsFor: 'Adjacents' stamp: 'OK 3/24/2024 15:56:03'!
next
	next ifNil: [
		next := self createChildNamed: self name, 'I'	.
		next definePrevious: self.
	].
	
	^next! !

!II class methodsFor: 'Adjacents' stamp: 'OK 3/24/2024 14:02:14'!
previous 
	^previous! !


!II class methodsFor: 'Operations' stamp: 'OK 3/24/2024 14:06:53'!
+ anAdder
	^previous + anAdder next! !

!II class methodsFor: 'Operations' stamp: 'OK 3/24/2024 15:49:18'!
- sustrahend
	^sustrahend restarA: self! !

!II class methodsFor: 'Operations' stamp: 'OK 3/24/2024 15:54:40'!
restarA: minuendo
	^minuendo previous - self previous! !


!II class methodsFor: '-- all --' stamp: 'OK 3/24/2024 16:05:56'!
* aMultiplicand
	^self previous * aMultiplicand + aMultiplicand.! !

!II class methodsFor: 'Operations' stamp: 'OK 3/24/2024 14:06:53'!
+ anAdder
	^previous + anAdder next! !

!II class methodsFor: 'Operations' stamp: 'OK 3/24/2024 15:49:18'!
- sustrahend
	^sustrahend restarA: self! !

!II class methodsFor: '-- all --' stamp: 'OK 3/24/2024 16:53:46'!
/ divisor
	|decreaseDividend|
	
	decreaseDividend  := [self - divisor] on: Error do: [].! !

!II class methodsFor: 'Adjacents' stamp: 'OK 3/24/2024 15:56:03'!
definePrevious: theCurrentObject
	previous := theCurrentObject.! !

!II class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/24/2024 17:13:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := I.
	next := nil.! !

!II class methodsFor: 'Adjacents' stamp: 'OK 3/24/2024 15:56:03'!
next
	next ifNil: [
		next := self createChildNamed: self name, 'I'	.
		next definePrevious: self.
	].
	
	^next! !

!II class methodsFor: 'Adjacents' stamp: 'OK 3/24/2024 14:02:14'!
previous 
	^previous! !

!II class methodsFor: 'Operations' stamp: 'OK 3/24/2024 15:54:40'!
restarA: minuendo
	^minuendo previous - self previous! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/24/2024 17:13:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := I.
	next := nil.! !

II initializeAfterFileIn!