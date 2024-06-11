!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'testObjectsFactory userPurchases debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'OK 6/11/2024 06:34:33'!
createDefaultInterface
	
	^ TusLibros usingDatabase: self andCatalog: testObjectsFactory defaultCatalog.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'OK 6/9/2024 13:21:04'!
debit: anAmount from: aCreditCard 
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'OK 6/9/2024 13:18:46'!
getPurchasesFrom: aUserID andPassword: aPassword

	^ userPurchases.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'OK 6/9/2024 06:56:53'!
hasRegistered: aUserID withPassword: aPassword 
	
	^ ( aUserID = ( testObjectsFactory validUserID ) ) and: ( aPassword = ( testObjectsFactory validPassword ) )! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'OK 6/9/2024 13:25:53'!
newPurchase: aPurchase

	userPurchases := aPurchase.
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'OK 6/9/2024 13:18:28'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	userPurchases := Dictionary new.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'OK 6/11/2024 06:34:40'!
test01CanNotCreateCartForUnknownUser

	| interface |
	
	interface := self createDefaultInterface.
	
	self 
		should: [ interface createCartForUserID: ( testObjectsFactory invalidUserID ) andPassword: ( testObjectsFactory invalidPassword ) ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibros invalidUserIDOrPasswordErrorMessage.
			self assert: ( interface amountOfActiveCarts = 0 )
		].! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'OK 6/11/2024 06:34:53'!
test02CartIsCreatedCorrectlyForKnownUser

	| interface cartID|
	
	interface := self createDefaultInterface.
	
	cartID := interface createCartForUserID: ( testObjectsFactory validUserID ) andPassword: ( testObjectsFactory validPassword ).
	
	self assert: ( interface hasCartID: cartID ).
	self assert: ( interface isEmpty: cartID ).
	self assert: ( interface cart: cartID isOwnedByUserID: ( testObjectsFactory validUserID ) andPassword: ( testObjectsFactory validPassword ) ).
	self assert: ( interface amountOfActiveCarts = 1 ).
		! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'OK 6/11/2024 06:34:58'!
test03CanNotAddToInvalidCartID

	| interface cartID |
	
	interface := self createDefaultInterface.
	cartID := interface createCartForUserID: ( testObjectsFactory validUserID ) andPassword: ( testObjectsFactory validPassword ).
	
	self 
		should: [ interface addToCart: ( testObjectsFactory invalidCartID ) theItem: ( testObjectsFactory itemSellByTheStore ) times: ( testObjectsFactory validQuantityOfItems)]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: anError messageText = TusLibros invalidCartIDErrorMessage.
			self assert: ( interface hasCartID: cartID ).
			self assert: ( interface isEmpty: cartID ).
			self assert: ( interface cart: cartID isOwnedByUserID: ( testObjectsFactory validUserID ) andPassword: ( testObjectsFactory validPassword ) ).
			self assert: ( interface amountOfActiveCarts = 1 ).
		]
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'OK 6/11/2024 06:35:01'!
test04CanAddToCartByKnowingItsID

	| interface cartID |
	
	interface := self createDefaultInterface.
	
	cartID := interface createCartForUserID: ( testObjectsFactory validUserID ) andPassword: ( testObjectsFactory validPassword ).
	interface addToCart: cartID theItem: ( testObjectsFactory itemSellByTheStore ) times: ( testObjectsFactory validQuantityOfItems).
	
	self assert: ( interface hasCartID: cartID ).
	self deny:   ( interface isEmpty: cartID ).
	self assert: ( interface cart: cartID isOwnedByUserID: ( testObjectsFactory validUserID ) andPassword: ( testObjectsFactory validPassword ) ).
	self assert: ( interface amountOfActiveCarts = 1 ).
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'OK 6/11/2024 06:35:07'!
test05CartsKnowTheUserTheyBelongTo

	| interface cartID |
	
	interface := self createDefaultInterface.
	
	cartID := interface createCartForUserID: ( testObjectsFactory validUserID ) andPassword: ( testObjectsFactory validPassword ).
	
	self assert: ( interface hasCartID: cartID ).
	self deny:   ( interface cart: cartID isOwnedByUserID: ( testObjectsFactory invalidUserID ) andPassword: ( testObjectsFactory invalidPassword ) ).
	self assert: ( interface amountOfActiveCarts = 1 ).
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'OK 6/11/2024 06:35:11'!
test06CanNotListEmptyCart

	| interface cartID |
	
	interface := self createDefaultInterface.
	
	cartID := interface createCartForUserID: ( testObjectsFactory validUserID ) andPassword: ( testObjectsFactory validPassword ).
	
	self 
		should: [ interface listCart: cartID ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: anError messageText = TusLibros canNotListEmptyCartErrorMessage .
			self assert: ( interface hasCartID: cartID ).
			self assert: ( interface isEmpty: cartID ).
			self assert: ( interface cart: cartID isOwnedByUserID: ( testObjectsFactory validUserID ) andPassword: ( testObjectsFactory validPassword ) ).
			self assert: ( interface amountOfActiveCarts = 1 ).
		]
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'OK 6/11/2024 06:35:14'!
test07CartsWithAtLeastOneItemAreListedAsDictionary

	| interface cartID expected |
	
	interface := self createDefaultInterface.
	
	cartID := interface createCartForUserID: ( testObjectsFactory validUserID ) andPassword: ( testObjectsFactory validPassword ).
	interface addToCart: cartID theItem: ( testObjectsFactory itemSellByTheStore ) times: ( testObjectsFactory validQuantityOfItems).
	
	expected := Dictionary new.
	expected add: ( testObjectsFactory itemSellByTheStore )->( testObjectsFactory validQuantityOfItems ).
	
	self assert: ( interface listCart: cartID ) = expected.
	self assert: ( interface hasCartID: cartID ).
	self deny:   ( interface isEmpty: cartID ).
	self assert: ( interface cart: cartID isOwnedByUserID: ( testObjectsFactory validUserID ) andPassword: ( testObjectsFactory validPassword ) ).
	self assert: ( interface amountOfActiveCarts = 1 ).
		
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'OK 6/11/2024 06:35:18'!
test08CanNotCheckOutWithExpiredCard

	| interface cartID |
	
	interface := self createDefaultInterface.
	
	cartID := interface createCartForUserID: ( testObjectsFactory validUserID ) andPassword: ( testObjectsFactory validPassword ).
	interface addToCart: cartID theItem: ( testObjectsFactory itemSellByTheStore ) times: ( testObjectsFactory validQuantityOfItems).
	
	self 
		should: [ interface 
					checkOutCart: cartID 
					withCreditCard: testObjectsFactory expiredCreditCard 
					through: self 
					on: testObjectsFactory today ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: ( interface hasCartID: cartID ).
			self assert: ( interface amountOfActiveCarts = 1 ).
		]
	
		
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'OK 6/11/2024 06:35:22'!
test09UserCanListValidPurchases

	| interface cartID purchases expected |
	
	interface := self createDefaultInterface.
	
	cartID := interface createCartForUserID: ( testObjectsFactory validUserID ) andPassword: ( testObjectsFactory validPassword ).
	interface addToCart: cartID theItem: ( testObjectsFactory itemSellByTheStore ) times: ( testObjectsFactory validQuantityOfItems).
	interface checkOutCart: cartID withCreditCard: testObjectsFactory notExpiredCreditCard through: self on: testObjectsFactory today.
	purchases := interface listPurchasesFor: ( testObjectsFactory validUserID ) andPassword: ( testObjectsFactory validPassword ).
		
	expected := Dictionary new.
	expected add: ( testObjectsFactory itemSellByTheStore ) -> 1.
	expected add: 'total' -> 10.
		
	self assert: ( purchases = expected ).
	self assert: ( interface hasCartID: cartID ).
	self deny:   ( interface isEmpty: cartID ).
	self assert: ( interface cart: cartID isOwnedByUserID: ( testObjectsFactory validUserID ) andPassword: ( testObjectsFactory validPassword ) ).
	self assert: ( interface amountOfActiveCarts = 1 ).
		
	
		
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'OK 6/11/2024 10:13:16'!
test10CanNotCheckOutNotCreatedCart

	| interface cartID |
	
	interface := self createDefaultInterface.
	cartID := testObjectsFactory invalidCartID.
	
	self 
		should: [ interface checkOutCart: cartID withCreditCard: testObjectsFactory notExpiredCreditCard through: self on: testObjectsFactory today. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibros invalidCartIDErrorMessage.
			self deny:   ( interface hasCartID: cartID ).
			self assert: ( interface amountOfActiveCarts = 0 ).
		].
		
	
		
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'OK 6/11/2024 11:18:21'!
test11CanNotAddItemToExpiredCart

	| interface cartID |
	
	interface := self createDefaultInterface.
	
	cartID := interface createCartForUserID: ( testObjectsFactory validUserID ) andPassword: ( testObjectsFactory validPassword ).
	
	interface increaseCartTime: cartID byMinutes: 31.
	
	self 
		should: [ interface addToCart: cartID theItem: ( testObjectsFactory itemSellByTheStore ) times: ( testObjectsFactory validQuantityOfItems). ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibros canNotUseAnExpiredCartErrorMessage.
			self deny: ( interface hasCartID: cartID ).
			self assert: ( interface amountOfActiveCarts = 0 ).
		].
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'OK 6/11/2024 11:28:58'!
test12CanNotListExpiredCart

	| interface cartID |
	
	interface := self createDefaultInterface.
	
	cartID := interface createCartForUserID: ( testObjectsFactory validUserID ) andPassword: ( testObjectsFactory validPassword ).
	
	interface increaseCartTime: cartID byMinutes: 31.
	
	self 
		should: [ interface addToCart: cartID theItem: ( testObjectsFactory itemSellByTheStore ) times: ( testObjectsFactory validQuantityOfItems) ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibros canNotUseAnExpiredCartErrorMessage.
			self deny: ( interface hasCartID: cartID ).
			self assert: ( interface amountOfActiveCarts = 0 ).
		].
	
		
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'OK 6/11/2024 11:29:40'!
test13CanNotCheckOutExpiredCart

	| interface cartID |
	
	interface := self createDefaultInterface.
	
	cartID := interface createCartForUserID: ( testObjectsFactory validUserID ) andPassword: ( testObjectsFactory validPassword ).
	interface addToCart: cartID theItem: ( testObjectsFactory itemSellByTheStore ) times: ( testObjectsFactory validQuantityOfItems).
		
	interface increaseCartTime: cartID byMinutes: 31.
		
	self 
		should: [ interface checkOutCart: cartID withCreditCard: testObjectsFactory notExpiredCreditCard through: self on: testObjectsFactory today. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibros canNotUseAnExpiredCartErrorMessage.
			self deny: ( interface hasCartID: cartID ).
			self assert: ( interface amountOfActiveCarts = 0 ).
		].
		
	
		
	
	! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'OK 6/9/2024 12:37:54'!
list

	^ self listAsDictionary: items! !

!Cart methodsFor: 'queries' stamp: 'OK 6/9/2024 12:39:27'!
listAsDictionary: aBag

	| dictionary |
	
	dictionary := Dictionary new.
	
	aBag asSet do: [ :anItem | dictionary add: anItem->( aBag occurrencesOf: anItem ) ].
	
	^ dictionary.! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'OK 6/11/2024 10:52:58'!
increaseTimeBy: anAmountOfMinutes 
	self shouldBeImplemented.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !

!Cart class methodsFor: 'instance creation' stamp: 'OK 6/9/2024 09:53:32'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'instance creation' stamp: 'OK 6/9/2024 09:53:23'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!classDefinition: #CartProperties category: #TusLibros!
Object subclass: #CartProperties
	instanceVariableNames: 'cart owner password userID lastUpdate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartProperties methodsFor: 'initialization' stamp: 'OK 6/11/2024 10:57:58'!
initializeWith: aCart forUser: aUserID andPassword: aPassword 
	
	cart := aCart.
	userID := aUserID.
	password := aPassword.
	lastUpdate := DateAndTime now.! !


!CartProperties methodsFor: 'observer' stamp: 'OK 6/11/2024 10:06:35'!
cart
	
	^cart! !

!CartProperties methodsFor: 'observer' stamp: 'OK 6/11/2024 11:17:05'!
isExpiredIfCurrenTimeEquals: aClock 
	
	^ ( lastUpdate - aClock ) minutes > 30! !

!CartProperties methodsFor: 'observer' stamp: 'OK 6/11/2024 10:07:27'!
password
	
	^password! !

!CartProperties methodsFor: 'observer' stamp: 'OK 6/11/2024 11:02:18'!
updateTimeTo: aDateAndTime
	
	lastUpdate := aDateAndTime.! !

!CartProperties methodsFor: 'observer' stamp: 'OK 6/11/2024 10:07:06'!
user
	
	^ userID ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartProperties class' category: #TusLibros!
CartProperties class
	instanceVariableNames: ''!

!CartProperties class methodsFor: 'as yet unclassified' stamp: 'OK 6/11/2024 10:05:17'!
withCart: aCart forUser: aUserID andPassword: aPassword 
	
	^ self new initializeWith: aCart forUser: aUserID andPassword: aPassword.! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'OK 6/9/2024 13:25:14'!
purchaseTicket 

	^  ( ( cart list ) add: 'total'->total; yourself ) copy.! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'OK 6/9/2024 09:49:28'!
validQuantityOfItems
	
	^ 1.! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'OK 6/9/2024 09:54:01'!
validCartID
	self shouldBeImplemented.! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'user' stamp: 'OK 6/9/2024 09:45:45'!
invalidCartID

	^ 0.! !

!StoreTestObjectsFactory methodsFor: 'user' stamp: 'OK 6/9/2024 06:28:26'!
invalidPassword
	
	^ 'Sapeee'! !

!StoreTestObjectsFactory methodsFor: 'user' stamp: 'OK 6/9/2024 06:28:15'!
invalidUserID
	
	^ 'Norber'! !

!StoreTestObjectsFactory methodsFor: 'user' stamp: 'OK 6/9/2024 06:50:06'!
validPassword
	
	^ 'Kerbs'! !

!StoreTestObjectsFactory methodsFor: 'user' stamp: 'OK 6/9/2024 06:49:54'!
validUserID
	
	^ 'Octo'! !


!classDefinition: #TusLibros category: #TusLibros!
Object subclass: #TusLibros
	instanceVariableNames: 'userDatabase catalog propertiesByCartID clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibros methodsFor: 'initializing' stamp: 'OK 6/11/2024 11:01:32'!
initializeWith: aUserDatabase usingCatalog: aCatalog 

	userDatabase := aUserDatabase.
	catalog := aCatalog.
	propertiesByCartID := Dictionary new.
	clock := DateAndTime now.! !


!TusLibros methodsFor: 'api' stamp: 'OK 6/9/2024 12:11:46'!
addToCart: aCartID theItem: anItem times: aQuantity 

	self assertValidCartID: aCartID.
	self withCart: ( self getCartByCartID: aCartID ) do: [ :aCart | aCart add: aQuantity of: anItem ].
	
	! !

!TusLibros methodsFor: 'api' stamp: 'OK 6/11/2024 10:14:51'!
checkOutCart: aCartID withCreditCard: aCreditCard through: aMerchantProcessor on: aDate 
	
	| cashier purchase |
	
	self assertValidCartID: aCartID.
	
	cashier := Cashier 
				toCheckout:  ( self getCartByCartID: aCartID )
				charging:  aCreditCard
				throught:  aMerchantProcessor
				on:  aDate
				registeringOn: OrderedCollection new.
				
	cashier checkOut.
	purchase := cashier purchaseTicket.
	
	userDatabase newPurchase: purchase.
	
	^ purchase identityHash.
	
	
	
! !

!TusLibros methodsFor: 'api' stamp: 'OK 6/11/2024 11:03:54'!
createCartForUserID: aUserID andPassword: aPassword
	
	self assertValidUserID: aUserID andPassword: aPassword.
	self withCart: ( Cart acceptingItemsOf: catalog ) do: [ :aCart | 
		propertiesByCartID add: aCart identityHash->  ( CartProperties withCart: aCart forUser: aUserID andPassword: aPassword ). 
		^aCart identityHash 
	].
	
	
	
	! !

!TusLibros methodsFor: 'api' stamp: 'OK 6/11/2024 11:26:44'!
listCart: aCartID
	
	self assertValidCartID: aCartID.
	self assertCartIsNotEmpty: aCartID.
	
	^ ( self getCartByCartID: aCartID ) list.! !

!TusLibros methodsFor: 'api' stamp: 'OK 6/9/2024 13:17:14'!
listPurchasesFor: aUserID andPassword: aPassword 
	
	self assertValidUserID: aUserID andPassword: aPassword.
	
	^ userDatabase getPurchasesFrom: aUserID andPassword: aPassword.
	! !


!TusLibros methodsFor: 'asserts' stamp: 'OK 6/9/2024 12:25:43'!
assertCartIsNotEmpty: aCartID

	( self getCartByCartID: aCartID ) isEmpty ifTrue: [ self error: TusLibros canNotListEmptyCartErrorMessage ].

	! !

!TusLibros methodsFor: 'asserts' stamp: 'OK 6/11/2024 11:12:15'!
assertValidCartID: aCartID
	
	( self hasCartID: aCartID ) ifFalse: [ self error: TusLibros invalidCartIDErrorMessage ].
	( self isExpired: aCartID ) ifTrue: [ propertiesByCartID removeKey: aCartID. self error: TusLibros canNotUseAnExpiredCartErrorMessage ].! !

!TusLibros methodsFor: 'asserts' stamp: 'OK 6/9/2024 12:03:20'!
assertValidUserID: aUserID andPassword: aPassword
	
	( userDatabase hasRegistered: aUserID withPassword: aPassword ) ifFalse: [ self error: TusLibros invalidUserIDOrPasswordErrorMessage ].
	 
	
	! !


!TusLibros methodsFor: 'private' stamp: 'OK 6/11/2024 11:25:16'!
getCartByCartID: aCartID
	
	| cartProperties |
	
	cartProperties := propertiesByCartID at: aCartID.
	cartProperties updateTimeTo: clock.
	
	^ cartProperties cart  
! !

!TusLibros methodsFor: 'private' stamp: 'OK 6/11/2024 10:07:19'!
getPasswordByCartID: aCartID

	^ ( propertiesByCartID at: aCartID ) password  ! !

!TusLibros methodsFor: 'private' stamp: 'OK 6/11/2024 10:06:57'!
getUserIDByCartID: aCartID

	^ ( propertiesByCartID at: aCartID ) user  ! !

!TusLibros methodsFor: 'private' stamp: 'OK 6/9/2024 12:07:30'!
withCart: aCart do: anOperationBlock

	anOperationBlock value: aCart.! !


!TusLibros methodsFor: 'testing' stamp: 'OK 6/11/2024 10:04:45'!
amountOfActiveCarts
	
	^ ( propertiesByCartID keys ) size! !

!TusLibros methodsFor: 'testing' stamp: 'OK 6/9/2024 12:16:24'!
cart: aCartID isOwnedByUserID: aUserID andPassword: aPassword 
	
	
	^    ( ( self getUserIDByCartID: aCartID ) = aUserID ) and: 
		( ( self getPasswordByCartID: aCartID ) = aPassword )! !

!TusLibros methodsFor: 'testing' stamp: 'OK 6/11/2024 10:16:06'!
hasCartID: aCartID 
	
	^ ( propertiesByCartID keys ) includes: aCartID ! !

!TusLibros methodsFor: 'testing' stamp: 'OK 6/11/2024 11:08:31'!
increaseCartTime: aCartID byMinutes: anAmountOfMinutes

	( propertiesByCartID at: aCartID ) updateTimeTo: ( clock + ( Duration minutes: anAmountOfMinutes) ) 
	
	! !

!TusLibros methodsFor: 'testing' stamp: 'OK 6/11/2024 10:06:11'!
isEmpty: aCartID 
	
	^ ( propertiesByCartID at: aCartID ) cart isEmpty.! !

!TusLibros methodsFor: 'testing' stamp: 'OK 6/11/2024 11:14:09'!
isExpired: aCartID 
	
	^ ( propertiesByCartID at: aCartID ) isExpiredIfCurrenTimeEquals: clock.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibros class' category: #TusLibros!
TusLibros class
	instanceVariableNames: ''!

!TusLibros class methodsFor: 'as yet unclassified' stamp: 'OK 6/9/2024 12:26:03'!
canNotListEmptyCartErrorMessage

	^ 'Can not list empty cart!!'.! !

!TusLibros class methodsFor: 'as yet unclassified' stamp: 'OK 6/11/2024 11:16:05'!
canNotUseAnExpiredCartErrorMessage
	
	^ 'The cart you are trying to use is expired!!'! !

!TusLibros class methodsFor: 'as yet unclassified' stamp: 'OK 6/9/2024 09:51:04'!
invalidCartIDErrorMessage
	
	^ 'Cart ID is invalid or expired'.! !

!TusLibros class methodsFor: 'as yet unclassified' stamp: 'OK 6/9/2024 06:36:23'!
invalidUserIDOrPasswordErrorMessage
	
	^ 'Invalid user id or password!!'! !

!TusLibros class methodsFor: 'as yet unclassified' stamp: 'OK 6/9/2024 10:45:19'!
usingDatabase: aUserDatabase andCatalog: aCatalog 

	^ self new initializeWith: aUserDatabase usingCatalog: aCatalog! !
