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

!II class methodsFor: 'Adjacents' stamp: 'OK 3/25/2024 20:58:00'!
next

	next := II createChildNamed: self name, 'I'	.
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

!II class methodsFor: 'Operations' stamp: 'OK 3/25/2024 21:03:51'!
/ dividend
	! !

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

!II class methodsFor: 'Operations' stamp: 'OK 3/25/2024 21:03:51'!
/ dividend
	! !

!II class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:48'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := I.
	next := III.! !

!II class methodsFor: 'Adjacents' stamp: 'OK 3/25/2024 20:58:00'!
next

	next := II createChildNamed: self name, 'I'	.
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


!II class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:48'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := I.
	next := III.! !


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

!III class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:48'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := II.
	next := IIII.! !


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

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:49'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := III.
	next := IIIII.! !


!classDefinition: #IIIII category: #Ejercicio4!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: #Ejercicio4!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:49'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIII.
	next := IIIIII.! !


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

!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:49'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIII.
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

!IIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:49'!
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

!IIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:49'!
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

!IIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:49'!
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

!IIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:49'!
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

!IIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:49'!
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

!IIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:49'!
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

!IIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:49'!
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

!IIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:49'!
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

!IIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:49'!
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

!IIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:49'!
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

!IIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:49'!
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

!IIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:49'!
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

!IIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:49'!
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

!IIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:50'!
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

!IIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:50'!
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

!IIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:50'!
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

!IIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:50'!
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

!IIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:50'!
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

!IIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:50'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:50'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:50'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:50'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:50'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:50'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:50'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:50'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:50'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:50'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:50'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:51'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:51'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:51'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:51'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:51'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:51'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:51'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:51'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:51'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:51'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:51'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:51'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:51'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:51'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:51'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:51'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:52'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:52'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:52'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:52'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:52'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:52'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:52'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:52'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:52'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:52'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:52'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:52'!
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

!IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'OK 3/26/2024 05:29:52'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII.
	next := nil.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
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