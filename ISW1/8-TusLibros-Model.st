!classDefinition: #ActiveVariable category: #'TusLibros-Model'!
Object subclass: #ActiveVariable
	instanceVariableNames: 'value semaphore calculated'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!ActiveVariable methodsFor: 'as yet unclassified' stamp: 'OK 6/12/2024 18:58:20'!
doesNotUnderstand: aMessage

	^ aMessage sendTo: ( self value ).! !

!ActiveVariable methodsFor: 'as yet unclassified' stamp: 'OK 6/12/2024 19:13:14'!
initializeWith: aBlock

	semaphore := Semaphore new.
	calculated := false.
	[ [ value := aBlock value] ensure: [ semaphore signal ] ] fork.! !

!ActiveVariable methodsFor: 'as yet unclassified' stamp: 'OK 6/12/2024 19:13:51'!
value

	calculated ifFalse: [ semaphore wait. calculated := true].
	
	^ value.
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ActiveVariable class' category: #'TusLibros-Model'!
ActiveVariable class
	instanceVariableNames: ''!

!ActiveVariable class methodsFor: 'as yet unclassified' stamp: 'OK 6/13/2024 07:45:36'!
calculateUsing: aBlock

	^ self new initializeWith: aBlock.! !


!classDefinition: #Cart category: #'TusLibros-Model'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage
	
	^self class invalidItemErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage
	
	^self class invalidQuantityErrorMessage ! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:17'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self signalInvalidItem ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:18'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [self signalInvalidQuantity ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:29'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/22/2013 12:31'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity ! !


!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:17'!
catalog
	
	^ catalog! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:30'!
content
	
	^items copy! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/23/2013 12:10'!
itemsAndQuantitiesDo: aBlock
	
	^ items contents keysAndValuesDo: [ :anItem :aQuantity | aBlock value: anItem value: aQuantity ]! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:18'!
signalInvalidItem 

	self error: self invalidItemErrorMessage! !

!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:19'!
signalInvalidQuantity 

	self error: self invalidQuantityErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Model'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!classDefinition: #CartSession category: #'TusLibros-Model'!
Object subclass: #CartSession
	instanceVariableNames: 'owner cart lastUsedTime systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:34'!
assertIsNotExpirtedAt: aTime

	(self isExpiredAt: aTime) ifTrue: [ self signalCartSessionExpired ]! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
isExpiredAt: aTime 
	
	^ (lastUsedTime + systemFacade sessionDuration) < aTime! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
now

	^systemFacade now! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:37'!
today

	^systemFacade today! !


!CartSession methodsFor: 'session management' stamp: 'HernanWilkinson 6/17/2015 20:35'!
do: aBlock

	| now |

	now := self now.
	self assertIsNotExpirtedAt: now.
	
	^ [ aBlock value: self ] ensure: [ lastUsedTime := now  ]! !


!CartSession methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2015 20:36'!
initializeOwnedBy: aCustomer with: aCart on: aSystemFacade

	owner := aCustomer.
	cart := aCart.
	systemFacade := aSystemFacade.
	lastUsedTime := self now.! !


!CartSession methodsFor: 'error signal' stamp: 'HernanWilkinson 6/17/2015 20:37'!
signalCartSessionExpired
	
	self error: systemFacade sessionHasExpiredErrorDescription ! !


!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:34'!
addToCart: anAmount of: aBook

	^cart add: anAmount of: aBook! !

!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:35'!
cartContent

	^cart content! !

!CartSession methodsFor: 'cart' stamp: 'HAW 7/23/2020 15:22:42'!
checkOutCartWithCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear 

	^(Cashier 
		toCheckout: cart 
		ownedBy: owner
		charging: (CreditCard numbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear) 
		throught: systemFacade merchantProcessor 
		on: self today 
		registeringOn: systemFacade salesBook) checkOut ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #'TusLibros-Model'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2015 20:37'!
ownedBy: aCustomer with: aCart on: aSystemFacade

	^self new initializeOwnedBy: aCustomer with: aCart on: aSystemFacade! !


!classDefinition: #Cashier category: #'TusLibros-Model'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard owner ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:17'!
createLineItemOf: anItem quantity: aQuantity 

	^LineItem of: anItem quantity: aQuantity total: (self totalOf: anItem quantity: aQuantity) ! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:25'!
createSale

	^ Sale doneBy: owner certifiedWith: ticket
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:28'!
createTicket

	| lineItems |
	
	lineItems := OrderedCollection new.
	cart itemsAndQuantitiesDo: [ :anItem :aQuantity | 
		lineItems add: (self createLineItemOf: anItem quantity: aQuantity)].
	
	ticket := Ticket of: lineItems 
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HAW 5/5/2020 18:04:55'!
debitTotal

	| transactionId |
	
	transactionId := merchantProcessor debit: ticket total from: creditCard.
	ticket transactionId: transactionId! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:17'!
totalOf: anItem quantity: aQuantity 

	^(cart catalog at: anItem) * aQuantity  ! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/22/2013 12:28'!
checkOut

	self createTicket.
	self debitTotal.
	self registerSale.

	^ ticket ! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:02'!
initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	owner := anOwner.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Model'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self signalCartCanNotBeEmpty ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [self signalCanNotChargeAnExpiredCreditCard]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:00'!
toCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCanNotChargeAnExpiredCreditCard

	 self error: self canNotChargeAnExpiredCreditCardErrorMessage ! !

!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCartCanNotBeEmpty

	self error: self cartCanNotBeEmptyErrorMessage! !


!classDefinition: #Clock category: #'TusLibros-Model'!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
now

	self subclassResponsibility ! !

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
today

	self subclassResponsibility ! !


!classDefinition: #CreditCard category: #'TusLibros-Model'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number ownerName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HAW 7/22/2020 14:39:22'!
initializeNumbered: aNumber ownedBy: anOwnerName expiringOn: aMonth 
	
	number := aNumber.
	ownerName := anOwnerName.
	expiration := aMonth ! !


!CreditCard methodsFor: 'accessing' stamp: 'HAW 7/22/2020 14:37:53'!
expiration
	
	^expiration ! !

!CreditCard methodsFor: 'accessing' stamp: 'HAW 7/22/2020 14:37:11'!
number
	
	^number! !

!CreditCard methodsFor: 'accessing' stamp: 'HAW 7/22/2020 14:39:22'!
ownerName
	
	^ownerName ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Model'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HAW 7/22/2020 14:40:01'!
numbered: aNumber ownedBy: anOwnerName expiringOn: aMonth 
	
	self assertIsValidNumber: aNumber.
	self assertIsValidOwnerName: anOwnerName.
	
	^self new initializeNumbered: aNumber ownedBy: anOwnerName expiringOn: aMonth! !


!CreditCard class methodsFor: 'exceptions' stamp: 'HAW 7/22/2020 14:19:45'!
invalidNumberErrorDescription
	
	^'Invalid credit card number. It must be 16 digits'! !

!CreditCard class methodsFor: 'exceptions' stamp: 'HAW 7/22/2020 14:27:09'!
invalidOwnerNameErrorDescription
	
	^'Owner name can not be empty'! !

!CreditCard class methodsFor: 'exceptions' stamp: 'HAW 7/22/2020 14:21:14'!
signalInvalidNumber
	
	self error: self invalidNumberErrorDescription ! !

!CreditCard class methodsFor: 'exceptions' stamp: 'HAW 7/22/2020 14:28:05'!
signalInvalidOwnerName
	
	self error: self invalidOwnerNameErrorDescription ! !


!CreditCard class methodsFor: 'assertions' stamp: 'HAW 7/22/2020 14:39:48'!
assertIsValidNumber: aNumber

	aNumber size = 16 ifFalse: [ self signalInvalidNumber ].
	(aNumber anySatisfy: [ :aCharacter | aCharacter isDigit not ]) ifTrue: [ self signalInvalidNumber ]! !

!CreditCard class methodsFor: 'assertions' stamp: 'HAW 7/22/2020 14:40:28'!
assertIsValidOwnerName: anOwnerName

	anOwnerName isEmpty ifTrue: [ self signalInvalidOwnerName ]! !


!classDefinition: #LineItem category: #'TusLibros-Model'!
Object subclass: #LineItem
	instanceVariableNames: 'item quantity total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:33'!
item
	
	^ item! !

!LineItem methodsFor: 'accessing' stamp: 'HAW 7/23/2020 15:33:00'!
quantity

	^quantity ! !

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:21'!
total
	
	^ total! !


!LineItem methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:18'!
initializeOf: anItem quantity: aQuantity total: aTotal

	item := anItem.
	quantity := aQuantity.
	total := aTotal 

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LineItem class' category: #'TusLibros-Model'!
LineItem class
	instanceVariableNames: ''!

!LineItem class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:18'!
of: anItem quantity: aQuantity total: aTotal

	^self new initializeOf: anItem quantity: aQuantity total: aTotal

! !


!classDefinition: #MerchantProcessor category: #'TusLibros-Model'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:31'!
README

	"Aunque nadie subclasifica esta clase, esta para definir el protocolo que se espera que todo MerchantProcessor sepa responder - Hernan"! !

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:30'!
debit: anAmount from: aCreditCard 

	self subclassResponsibility ! !


!classDefinition: #Sale category: #'TusLibros-Model'!
Object subclass: #Sale
	instanceVariableNames: 'customer ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/22/2013 12:26'!
total
	
	^ ticket total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:26'!
initializeDoneBy: aCustomer certifiedWith: aTicket 

	customer := aCustomer.
	ticket := aTicket ! !


!Sale methodsFor: 'testing' stamp: 'HernanWilkinson 6/22/2013 12:06'!
wasDoneBy: aCustomer

	^customer = aCustomer ! !


!Sale methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock
	
	^ticket lineItemsDo: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #'TusLibros-Model'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:25'!
doneBy: aCustomer certifiedWith: aTicket 

	^self new initializeDoneBy: aCustomer certifiedWith: aTicket ! !


!classDefinition: #Ticket category: #'TusLibros-Model'!
Object subclass: #Ticket
	instanceVariableNames: 'lineItems transactionId transactionIdSale transactionIdTaxes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Ticket methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2015 20:39'!
total
	
	^lineItems sum: [ :aLineItem | aLineItem total]! !


!Ticket methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:20'!
initializeOf: aCollectionOfLineItems 

	lineItems := aCollectionOfLineItems ! !

!Ticket methodsFor: 'initialization' stamp: 'HAW 5/5/2020 18:06:16'!
transactionId

	^transactionId ! !

!Ticket methodsFor: 'initialization' stamp: 'NR 6/13/2022 07:21:08'!
transactionId: anId

	transactionId := anId! !


!Ticket methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock
	
	^lineItems do: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: #'TusLibros-Model'!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:20'!
of: aCollectionOfLineItems

	^self new initializeOf: aCollectionOfLineItems ! !


!classDefinition: #TusLibrosSystemFacade category: #'TusLibros-Model'!
Object subclass: #TusLibrosSystemFacade
	instanceVariableNames: 'validUsersAndPasswords catalog lastId merchantProcessor salesBook clock cartSessions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:24'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^Cashier canNotChargeAnExpiredCreditCardErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:17'!
cartCanNotBeEmptyErrorMessage
	
	^Cashier cartCanNotBeEmptyErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:27'!
invalidCartIdErrorDescription
	
	^'Invalid cart id'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage
	
	^Cart invalidItemErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:03'!
invalidUserAndOrPasswordErrorDescription
	
	^'Invalid user and/or password'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 13:07'!
sessionHasExpiredErrorDescription
	
	^'Can not use the cart after ', self sessionDuration minutes printString , ' minutes of inactivity'! !


!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 13:02'!
now
	
	^clock now! !

!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:49'!
today
	
	^clock today! !


!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
does: aUser authenticatesWith: aPassword 

	"Recordar que esto es solo un ejemplo. No se deben guardar passwords en un sistema de verdad sino un
	hash o similar - Hernan"
	
	| storedPassword |
	
	storedPassword := validUsersAndPasswords at: aUser ifAbsent: [ ^false ].
	^aPassword = storedPassword ! !

!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
if: aUser authenticatesWith: aPassword do: aBlock

	^ (self does: aUser authenticatesWith: aPassword) 
		ifTrue: aBlock 
		ifFalse: [ self signalInvalidUserAndOrPassword ].
	! !


!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:27'!
signalInvalidCartId
	
	self error: self invalidCartIdErrorDescription ! !

!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:02'!
signalInvalidUserAndOrPassword
	
	self error: self invalidUserAndOrPasswordErrorDescription! !


!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/21/2013 23:32'!
generateCartId
	
	"Recuerden que esto es un ejemplo, por lo que voy a generar ids numericos consecutivos, pero en una 
	implementacion real no deberian se numeros consecutivos ni nada que genere problemas de seguridad - Hernan"
	
	lastId := lastId + 1.
	^lastId! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HAW 5/6/2020 13:57:29'!
removeCartId: aCartId

	"I'll not generate an error if the cartId is invalid because when used from http
	request can be duplicated - Hernan"
	cartSessions removeKey: aCartId ifAbsent: []! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/22/2013 13:02'!
sessionDuration
	
	^30 minutes! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/17/2015 20:50'!
withCartSessionIdentifiedAs: aCartId do: aBlock

	| cartSession |
	
	cartSession := cartSessions at: aCartId ifAbsent: [self signalInvalidCartId ].
	^cartSession do: aBlock
! !


!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:41'!
add: anAmount of: aBook toCartIdentifiedAs: aCartId

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession addToCart: anAmount of: aBook ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HAW 7/23/2020 15:24:41'!
checkOutCartIdentifiedAs: aCartId withCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	^self 
		withCartSessionIdentifiedAs: aCartId 
		do: [ :cartSession | | ticket | 
			ticket := cartSession 
				checkOutCartWithCreditCardNumbered: aCreditCartNumber 
				ownedBy: anOwner 
				expiringOn: anExpirationMonthOfYear.
			self removeCartId: aCartId.
			ticket transactionId ]
! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:52'!
createCartFor: aUser authenticatedWith: aPassword

	^ self if: aUser authenticatesWith: aPassword do: [ | cartId cartSession |
	
		cartId := self generateCartId.
		cartSession := CartSession ownedBy: aUser with: (Cart acceptingItemsOf: catalog) on: self..
		cartSessions at: cartId put: cartSession.
	
		cartId  ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:48'!
listCartIdentifiedAs: aCartId

	^ self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession cartContent ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'NR 6/13/2022 07:30:44'!
listPurchasesOf: aUser

	| sales soldItems total |
	
	sales := self salesDoneBy: aUser.	
	soldItems := sales
		inject: Dictionary new
		into: [ :quantitiesByItem :aSale | 
			self list: aSale on: quantitiesByItem.
			quantitiesByItem ].
	total := sales sum: [ :aSale | aSale total ] ifEmpty: [ 0 ].
	^Array with: soldItems with: total! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'NR 6/13/2022 07:30:37'!
listPurchasesOf: aUser authenticatingWith: aPassword

	^self if: aUser authenticatesWith: aPassword do: [	self listPurchasesOf: aUser]! !


!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:49'!
merchantProcessor

	^ merchantProcessor! !

!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:50'!
salesBook

	^ salesBook! !


!TusLibrosSystemFacade methodsFor: 'private' stamp: 'OK 6/13/2024 07:45:36'!
bookPerformance: anItem

	| bookPerformance totalMoney totalSales |

	bookPerformance := Dictionary new.
	
	totalSales := ActiveVariable calculateUsing: [ self totalSalesOf: anItem ].
	totalMoney := ActiveVariable calculateUsing: [ self totalMoneyRaisedBy: anItem ].
	
	bookPerformance at: 'quantity' put: totalSales value.
	bookPerformance at: 'total' put: totalMoney value.
	
	bookPerformance at: 'summary' put: anItem,' was selled ',totalSales value asString, ' times and raised a total amount of money equal to: ', totalMoney value asString.
	
	^bookPerformance
	

! !

!TusLibrosSystemFacade methodsFor: 'private' stamp: 'OK 6/12/2024 16:40:40'!
forEachSaleSum: aBlock

	(Delay forSeconds: 1) wait.

	^salesBook sum: [ :aSale | aBlock value: aSale ].! !

!TusLibrosSystemFacade methodsFor: 'private' stamp: 'HAW 7/23/2020 15:34:54'!
list: aSale on: quantitiesByItem 

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	aSale lineItemsDo: [ :aLineItem | | oldQuantity newQuantity |
		oldQuantity := quantitiesByItem at: aLineItem item ifAbsentPut: [ 0 ].
		newQuantity := oldQuantity + aLineItem quantity.
		quantitiesByItem at: aLineItem item put: newQuantity ]! !

!TusLibrosSystemFacade methodsFor: 'private' stamp: 'HernanWilkinson 6/17/2015 20:55'!
salesDoneBy: aUser

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	^ salesBook select: [ :aSale | aSale wasDoneBy: aUser ]! !

!TusLibrosSystemFacade methodsFor: 'private' stamp: 'OK 6/13/2024 07:45:36'!
storePerformance

	| totalMoney totalSales performance |
	
	performance := Dictionary new.
	
	totalSales := ActiveVariable calculateUsing: [ self totalSales ].
	totalMoney := ActiveVariable calculateUsing: [ self totalMoneyRaised ].
	
	performance at: 'quantity' put: totalSales value.
	performance at: 'total' put: totalMoney value.
	
	performance at: 'summary' put: 'The store selled a total of ',( totalSales value ) asString, ' books and raised a total amount of money equal to: ', ( totalMoney value ) asString.
	
	^performance
	

! !

!TusLibrosSystemFacade methodsFor: 'private' stamp: 'OK 6/12/2024 16:40:34'!
totalMoneyRaised
	
	^ self forEachSaleSum: [:aSale | aSale total]
	
	"(Delay forSeconds: 1) wait.
	
	^salesBook sum: [:aSale | aSale total]."
	
! !

!TusLibrosSystemFacade methodsFor: 'private' stamp: 'OK 6/12/2024 16:40:30'!
totalMoneyRaisedBy: anItem

	^ self forEachSaleSum: [:aSale | | totalPerItem |
		totalPerItem :=0.
		aSale lineItemsDo: [:aLineItem | (aLineItem item = anItem) ifTrue: [totalPerItem := totalPerItem + aLineItem total]].
		totalPerItem].
	
	"
	(Delay forSeconds: 1) wait.

	^salesBook sum: [:aSale | | totalPerItem |
		totalPerItem :=0.
		aSale lineItemsDo: [:aLineItem | (aLineItem item = anItem) ifTrue: [totalPerItem := totalPerItem + aLineItem total]].
		totalPerItem]."
	
	! !

!TusLibrosSystemFacade methodsFor: 'private' stamp: 'OK 6/12/2024 16:38:33'!
totalSales

	^ self forEachSaleSum: [:aSale | | totalQuantity |
		totalQuantity := 0.
		aSale lineItemsDo: [:aLineItem | totalQuantity := totalQuantity + aLineItem quantity].
		totalQuantity].
	
	"(Delay forSeconds: 1) wait.

	^salesBook sum: [:aSale | | totalQuantity |
		totalQuantity := 0.
		aSale lineItemsDo: [:aLineItem | totalQuantity := totalQuantity + aLineItem quantity].
		totalQuantity]."
	
! !

!TusLibrosSystemFacade methodsFor: 'private' stamp: 'OK 6/12/2024 16:36:56'!
totalSalesOf: anItem

	^ self forEachSaleSum: [ :aSale | | quantityPerItem | 
		quantityPerItem := 0.
		aSale lineItemsDo: [:aLineItem | (aLineItem item = anItem) ifTrue: [quantityPerItem := quantityPerItem + aLineItem quantity]].
		quantityPerItem.]
	"
	(Delay forSeconds: 1) wait.

	^salesBook sum: [:aSale | | quantityPerItem | 
		quantityPerItem := 0.
		aSale lineItemsDo: [:aLineItem | (aLineItem item = anItem) ifTrue: [quantityPerItem := quantityPerItem + aLineItem quantity]].
		quantityPerItem].
	"
! !

!TusLibrosSystemFacade methodsFor: 'private' stamp: 'OK 6/12/2024 17:28:47'!
when: aBlock isFinishedDo: anotherBlock
	
	| semaphore |
	
	semaphore := Semaphore new.
	
	[ aBlock ensure: [semaphore signal] ] fork.
	
	semaphore wait. 
	anotherBlock value ! !


!TusLibrosSystemFacade methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 14:17'!
initializeAuthenticatingWith: aValidUsersAndPasswords 
	acceptingItemsOf: aCatalog 
	registeringOn: aSalesBook 
	debitingThrought: aMerchantProcessor 
	measuringTimeWith: aClock

	validUsersAndPasswords := aValidUsersAndPasswords.
	catalog := aCatalog.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.
	clock := aClock.
	
	cartSessions := Dictionary new.
	lastId := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystemFacade class' category: #'TusLibros-Model'!
TusLibrosSystemFacade class
	instanceVariableNames: ''!

!TusLibrosSystemFacade class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 14:17'!
authenticatingWith: aValidUsersAndPasswords 
	acceptingItemsOf: aCatalog 
	registeringOn: aSalesBook 
	debitingThrought: aMerchantProcessor 
	measuringTimeWith: aClock

	^self new 
		initializeAuthenticatingWith: aValidUsersAndPasswords 
		acceptingItemsOf: aCatalog 
		registeringOn: aSalesBook 
		debitingThrought: aMerchantProcessor 
		measuringTimeWith: aClock! !
