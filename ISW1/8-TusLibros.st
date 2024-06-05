!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'OK 6/2/2024 01:10:33'!
test01CartsAreCreatedEmpty

	| cart |
	
	cart := Cart with: BookCatalog new.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'OK 6/2/2024 01:00:20'!
test02CartsCanNotAddUnavailableBooks

	| catalog cart bookISBN |
	
	catalog := BookCatalog new.
	cart := Cart with: catalog.
	bookISBN := '1933988274'.
	
	self 
		should: [ cart add: bookISBN times: 1 ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Cart canNotAddUnavailableBookErrorMessage equals: anError messageText ].
	
	self deny: ( catalog isAvailable: bookISBN ).
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'OK 6/2/2024 01:17:27'!
test03CartsCanAddAvailableBooks

	| cart bookISBN catalog |
	
	catalog := BookCatalog new.
	cart := Cart with: catalog.
	bookISBN := '1933988274'.
	
	catalog add: bookISBN.
	
	cart add: bookISBN times: 1.
	
	self assert: ( catalog isAvailable: bookISBN ).
	self assert: ( cart has: bookISBN times: 1).
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'OK 6/2/2024 00:59:18'!
test04CartsCanAddMultipleBooksFromThePublisher

	| catalog cart bookISBN1 bookISBN2 |
	
	catalog := BookCatalog new.
	cart := Cart with: catalog.
	bookISBN1 := '1933988274'.
	bookISBN2 := '0321146530'.
	
	catalog add: bookISBN1.
	catalog add: bookISBN2.
	
	cart add: bookISBN1 times: 10.
	cart add: bookISBN2 times: 20.
	
	self assert: ( catalog isAvailable: bookISBN1 ).
	self assert: ( catalog isAvailable: bookISBN2 ).
	self assert: ( cart has: bookISBN1 times: 10).
	self assert: ( cart has: bookISBN2 times: 20).
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'OK 6/2/2024 01:33:42'!
test05AddedBooksAreListedWithTheirQuantity

	| catalog cart bookISBN1 bookISBN2 |
	
	catalog := BookCatalog new.
	cart := Cart with: catalog.
	bookISBN1 := '1933988274'.
	bookISBN2 := '0321146530'.
	
	catalog add: bookISBN1.
	catalog add: bookISBN2.
	
	cart add: bookISBN1 times: 10.
	cart add: bookISBN2 times: 20.
	
	self assert: ( catalog isAvailable: bookISBN1 ).
	self assert: ( catalog isAvailable: bookISBN2 ).
	self assert: ( cart has: bookISBN1 times: 10).
	self assert: ( cart has: bookISBN2 times: 20).
	self deny: cart isEmpty.
	
	self assert: cart list = ( ( Dictionary new ) add: bookISBN1->10; add: bookISBN2->20; yourself )! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'OK 6/2/2024 03:00:01'!
test06CartIsExpiredThirtyMinutesAfterCreationWithoutAction

	| cart |
	
	cart := Cart with: BookCatalog new.
	
	cart setTime: (Timespan current - ( Duration minutes: 30 )).
	
	self assert: cart isExpired! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'OK 6/2/2024 03:05:30'!
test07CartTimeIsBackToZeroAfterAction

	| catalog bookISBN cart |
	
	catalog := BookCatalog new.
	bookISBN := '1933988274'.
	cart := Cart with: catalog.
	
	catalog add: bookISBN.
	cart setTime: (Timespan current - ( Duration minutes: 30 )).
	
	cart add: bookISBN times: 10.
	
	self deny: cart isExpired! !


!classDefinition: #BookCatalog category: #TusLibros!
Object subclass: #BookCatalog
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BookCatalog methodsFor: 'as yet unclassified' stamp: 'OK 6/2/2024 01:03:04'!
add: bookISBN 
	
	books add: bookISBN.! !

!BookCatalog methodsFor: 'as yet unclassified' stamp: 'OK 6/2/2024 01:02:32'!
initialize

	books := OrderedCollection new.! !

!BookCatalog methodsFor: 'as yet unclassified' stamp: 'OK 6/2/2024 01:03:25'!
isAvailable: bookISBN 
	
	^ books includes: bookISBN.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items lastAction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'OK 6/2/2024 01:50:46'!
has: bookISBN times: aQuantity 
	
	^ ( items at: bookISBN ) = aQuantity .! !

!Cart methodsFor: 'testing' stamp: 'OK 6/2/2024 01:08:06'!
isEmpty
	
	^ items isEmpty.! !

!Cart methodsFor: 'testing' stamp: 'OK 6/2/2024 02:59:05'!
isExpired

	^ ( Timespan current - lastAction ) minutes >= 30. ! !

!Cart methodsFor: 'testing' stamp: 'OK 6/2/2024 02:54:30'!
setTime: aTimeSpan

	lastAction := aTimeSpan.! !


!Cart methodsFor: 'initialization' stamp: 'OK 6/2/2024 01:55:14'!
initializeWith: aCatalog 
	
	catalog := aCatalog.
	items := Dictionary new.
	lastAction := Timespan current.! !


!Cart methodsFor: 'actions' stamp: 'OK 6/2/2024 03:04:24'!
add: bookISBN times: aQuantity 
	
	( catalog isAvailable: bookISBN )	 ifFalse: [ ^ Cart signalCanNotAddUnavailableBook ].
	
	items add: bookISBN->aQuantity.
	lastAction := Timespan current.! !

!Cart methodsFor: 'actions' stamp: 'OK 6/2/2024 03:04:35'!
list
	
	lastAction := Timespan current.
	^ items.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'initialization' stamp: 'OK 6/1/2024 22:56:48'!
with: aCatalog

	^ self new initializeWith: aCatalog.! !


!Cart class methodsFor: 'error messages' stamp: 'OK 6/1/2024 22:58:42'!
canNotAddUnavailableBookErrorMessage
	
	^ 'Can not add books that are not in catalog or out of print!!'! !


!Cart class methodsFor: 'exceptions' stamp: 'OK 6/1/2024 23:03:53'!
signalCanNotAddUnavailableBook
	
	self error: self canNotAddUnavailableBookErrorMessage ! !
