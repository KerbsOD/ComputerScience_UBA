!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'Ok 4/19/2024 01:17:26'!
test04PopReturnsLastPushedObject

	| stack pushedObject last|
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	last := stack pop.
	
	self assert: last = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'Ok 4/25/2024 13:20:55'!
test01

	| stack prefix sentencesThatMatchesPrefix sentenceObject answer|
	
	stack := OOStack new.
	stack push: 'winter is coming'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	stack push: 'Winter is here'.
	
	prefix := 'Wint'.
	answer := OrderedCollection new.
	answer add: 'Winter is here'.
	
	sentenceObject := SentenceFinderByPrefix new.
	
	sentencesThatMatchesPrefix := sentenceObject from: stack getSentencesWithPrefix:prefix. 
	
	self assert: sentencesThatMatchesPrefix equals: answer.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'Ok 4/25/2024 13:38:35'!
test02

	| stack prefix sentencesThatMatchesPrefix sentenceObject answer|
	
	stack := OOStack new.
	stack push: 'winter is coming'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	
	prefix := 'Wint'.
	answer := OrderedCollection new.
	
	sentenceObject := SentenceFinderByPrefix new.
	
	sentencesThatMatchesPrefix := sentenceObject from: stack getSentencesWithPrefix:prefix. 
	
	self assert: sentencesThatMatchesPrefix equals: answer.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'Ok 4/25/2024 13:39:21'!
test03

	| stack prefix sentencesThatMatchesPrefix sentenceObject answer|
	
	stack := OOStack new.
	stack push: 'Winter is coming'.
	stack push: 'winning is everything'.
	stack push: 'The winds of Winter'.
	stack push: 'Winter is here'.
	
	prefix := 'Wint'.
	answer := OrderedCollection new.
	answer add: 'Winter is here'; add: 'Winter is coming'.
	
	sentenceObject := SentenceFinderByPrefix new.
	
	sentencesThatMatchesPrefix := sentenceObject from: stack getSentencesWithPrefix:prefix. 
	
	self assert: sentencesThatMatchesPrefix equals: answer.
	
	! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'operations' stamp: 'Ok 4/19/2024 07:08:00'!
pop
	|top|
	
	top := self top.
	stack removeLast.
	
	^top 
	
! !

!OOStack methodsFor: 'operations' stamp: 'Ok 4/19/2024 20:39:14'!
push: aNewElement
	stack add: aNewElement! !

!OOStack methodsFor: 'operations' stamp: 'Ok 4/19/2024 07:26:01'!
top
	^self state top.! !


!OOStack methodsFor: 'initialization' stamp: 'Ok 4/19/2024 07:06:22'!
initialize
	 stack := OrderedCollection new ! !


!OOStack methodsFor: 'testing' stamp: 'Ok 4/19/2024 07:27:21'!
isEmpty
	^self size = 0! !

!OOStack methodsFor: 'testing' stamp: 'Ok 4/19/2024 20:26:20'!
isPopulated
	^stack isEmpty = false! !

!OOStack methodsFor: 'testing' stamp: 'Ok 4/19/2024 07:27:43'!
size
	^stack size! !


!OOStack methodsFor: 'private' stamp: 'Ok 4/19/2024 07:13:28'!
state
	^OOStackState stateFor: self! !

!OOStack methodsFor: 'private' stamp: 'Ok 4/19/2024 07:19:02'!
topWhenEmpty
	
	^self error: self class stackEmptyErrorDescription! !

!OOStack methodsFor: 'private' stamp: 'Ok 4/19/2024 20:24:21'!
topWhenPopulated
	
	^stack last! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: 'stack'!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackState category: #'Stack-Exercise'!
Object subclass: #OOStackState
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackState methodsFor: 'as yet unclassified' stamp: 'Ok 4/19/2024 07:14:39'!
initializeFor: aStack
	stack := aStack! !

!OOStackState methodsFor: 'as yet unclassified' stamp: 'Ok 4/19/2024 07:15:17'!
top
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackState class' category: #'Stack-Exercise'!
OOStackState class
	instanceVariableNames: ''!

!OOStackState class methodsFor: 'as yet unclassified' stamp: 'Ok 4/19/2024 20:42:31'!
canHandle: aStackObject

	self subclassResponsibility ! !

!OOStackState class methodsFor: 'as yet unclassified' stamp: 'Ok 4/19/2024 20:42:11'!
for: aStackObject

	^self new initializeFor: aStackObject! !

!OOStackState class methodsFor: 'as yet unclassified' stamp: 'Ok 4/19/2024 20:42:48'!
stateFor: aStackObject

	^(self subclasses detect: [:aStackStateClass | aStackStateClass canHandle: aStackObject ]) for: aStackObject
	
	" El primero que de true, le manda el mensaje for por lo que crea el objeto EmptyStackState o PopulatedStackState. Enviandole el stack que es copiado por StackState para responder la pregunta top con double dispatch"! !


!classDefinition: #EmptyStackState category: #'Stack-Exercise'!
OOStackState subclass: #EmptyStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyStackState methodsFor: 'as yet unclassified' stamp: 'Ok 4/19/2024 07:18:38'!
top
	
	^stack topWhenEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmptyStackState class' category: #'Stack-Exercise'!
EmptyStackState class
	instanceVariableNames: ''!

!EmptyStackState class methodsFor: 'as yet unclassified' stamp: 'Ok 4/19/2024 20:14:02'!
canHandle: aStack
	^aStack isEmpty ! !


!classDefinition: #PopulatedStackState category: #'Stack-Exercise'!
OOStackState subclass: #PopulatedStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!PopulatedStackState methodsFor: 'as yet unclassified' stamp: 'Ok 4/19/2024 20:30:43'!
top
	
	^stack topWhenPopulated! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PopulatedStackState class' category: #'Stack-Exercise'!
PopulatedStackState class
	instanceVariableNames: ''!

!PopulatedStackState class methodsFor: 'as yet unclassified' stamp: 'Ok 4/19/2024 20:37:41'!
canHandle: aStack
	^aStack isPopulated ! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'Ok 4/25/2024 18:24:00'!
from: aStackWithSentences getSentencesWithPrefix: thePrefix
	^ self filter: aStackWithSentences with: [:sentence | sentence beginsWith: thePrefix]
	
	
	
	! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'Ok 4/25/2024 18:28:26'!
fill: aStack with: allStackElements.
	
	[allStackElements isEmpty] whileFalse: [
		aStack push: allStackElements removeLast.	
	]! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'Ok 4/25/2024 18:27:51'!
filter: aStack with: aCondition
	|currentElement elementsThatMeetCondition allStackElements|
	
	elementsThatMeetCondition := OrderedCollection new.
	allStackElements := OrderedCollection new.
	
	[aStack isEmpty] whileFalse: [
		currentElement := aStack pop.
		(aCondition value: currentElement)  ifTrue: [elementsThatMeetCondition add: currentElement ].
		allStackElements add: currentElement.	
	].

	self fill: aStack with: allStackElements.
	
	^elementsThatMeetCondition.! !
