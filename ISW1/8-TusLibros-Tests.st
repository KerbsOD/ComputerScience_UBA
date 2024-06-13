!classDefinition: #CartTest category: #'TusLibros-Tests'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

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


!classDefinition: #CashierTest category: #'TusLibros-Tests'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:00'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			ownedBy: testObjectsFactory customer
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:22'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		ownedBy: testObjectsFactory customer
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut total = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:01'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				ownedBy: testObjectsFactory customer 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:23'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		ownedBy: testObjectsFactory customer 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut total.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:22'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart
		ownedBy: testObjectsFactory customer 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut total.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:02'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		ownedBy: testObjectsFactory customer
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


!classDefinition: #CreditCardTest category: #'TusLibros-Tests'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!CreditCardTest methodsFor: 'tests' stamp: 'HAW 7/22/2020 14:26:34'!
test01CreditCardNumberWithLessThan16DigitsIsNotValid

	self 
		should: [ CreditCard numbered: '123456789012345' ownedBy: self validOwnerName expiringOn: Month current ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidNumberErrorDescription! !

!CreditCardTest methodsFor: 'tests' stamp: 'HAW 7/22/2020 14:26:33'!
test02CreditCardNumberWithMoreThan16DigitsIsNotValid

	self 
		should: [ CreditCard numbered: '12345678901234567' ownedBy: self validOwnerName expiringOn: Month current ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidNumberErrorDescription! !

!CreditCardTest methodsFor: 'tests' stamp: 'HAW 7/22/2020 14:26:33'!
test03CreditCardNumberShouldBeDigitsOnly

	self 
		should: [ CreditCard numbered: 'a234567890123456' ownedBy: self validOwnerName expiringOn: Month current ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidNumberErrorDescription! !

!CreditCardTest methodsFor: 'tests' stamp: 'HAW 7/22/2020 14:27:23'!
test04NameCanNotBeEmpty

	self 
		should: [ CreditCard numbered: '1234567890123456' ownedBy: '' expiringOn: Month current ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidOwnerNameErrorDescription! !

!CreditCardTest methodsFor: 'tests' stamp: 'HAW 7/22/2020 14:32:08'!
test05IsExpiredOnNextExpirationMonth

	| expirationMonth expiredMonth creditCard |
	
	expirationMonth := Month month: #January year: 2020. 
	expiredMonth := expirationMonth next.
	creditCard := CreditCard 
		numbered: '1234567890123456' 
		ownedBy: self validOwnerName 
		expiringOn: expirationMonth.
		
	self assert: (creditCard isExpiredOn: expiredMonth)! !

!CreditCardTest methodsFor: 'tests' stamp: 'HAW 7/22/2020 14:32:30'!
test06IsNotExpiredOnExpirationMonth

	| expirationMonth creditCard |
	
	expirationMonth := Month month: #January year: 2020. 
	creditCard := CreditCard 
		numbered: '1234567890123456' 
		ownedBy: self validOwnerName 
		expiringOn: expirationMonth.
		
	self deny: (creditCard isExpiredOn: expirationMonth)! !

!CreditCardTest methodsFor: 'tests' stamp: 'HAW 7/22/2020 14:39:10'!
test07CanGetCreditCardInfoFromIt

	| expirationMonth creditCard creditCardNumber creditCardOwner |
	
	expirationMonth := Month month: #January year: 2020. 
	creditCardNumber := self validCreditCardNumber.
	creditCardOwner := self validOwnerName.
	
	creditCard := CreditCard 
		numbered: creditCardNumber 
		ownedBy: creditCardOwner 
		expiringOn: expirationMonth.
		
	self assert: creditCardNumber equals: creditCard number.
	self assert: creditCardOwner equals: creditCard ownerName.
	self assert: expirationMonth equals: creditCard expiration! !

!CreditCardTest methodsFor: 'tests' stamp: 'HAW 7/22/2020 14:33:46'!
validCreditCardNumber

	^ '1234567890123456'! !

!CreditCardTest methodsFor: 'tests' stamp: 'HAW 7/22/2020 14:28:21'!
validOwnerName
	
	^'Pepe Sanchez'! !


!classDefinition: #TusLibrosSystemFacadeTest category: #'TusLibros-Tests'!
TestCase subclass: #TusLibrosSystemFacadeTest
	instanceVariableNames: 'testObjectsFactory clock systemFacade merchantProcessorTransactionId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart' stamp: 'HAW 7/23/2020 15:59:09'!
test04CanAddItemsToACreatedCart

	| cartId cartContent |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	
	cartContent := systemFacade listCartIdentifiedAs: cartId.
	
	self assert: 1 equals: (cartContent occurrencesOf: self validBook).
	self assert: 1 equals: cartContent size! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart' stamp: 'HAW 7/23/2020 15:55:18'!
test05CanNotAddItemToNotCreatedCart

	self
		should: [systemFacade add: 1 of: self validBook toCartIdentifiedAs: self invalidCartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assertMessageTextOf: anError is: systemFacade invalidCartIdErrorDescription ]
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart' stamp: 'HAW 7/23/2020 15:56:49'!
test06CanNotAddItemNotSellByTheStore

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		should: [systemFacade add: 1 of: self invalidBook toCartIdentifiedAs: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assertMessageTextOf: anError is: systemFacade invalidItemErrorMessage.
			self assertIsEmptyCartIdentifiedAs: cartId]
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart' stamp: 'HAW 7/23/2020 15:57:13'!
test17CanNotAddToCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) . 
	self 
		should: [systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assertMessageTextOf: anError is: systemFacade sessionHasExpiredErrorDescription.
			self revertTime: systemFacade sessionDuration.
			self assertIsEmptyCartIdentifiedAs: cartId ]
! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - performance' stamp: 'NR 6/9/2022 20:51:15'!
should: aBlock notTakeMoreThanMilliseconds: aTimeInMillis

	self assert: aBlock timeToRun <= aTimeInMillis! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - performance' stamp: 'NR 6/13/2022 09:05:18'!
test20BookPerformanceShouldNotTakeTooLong

	| cartId bookPerformance quantity total |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade 
		checkOutCartIdentifiedAs: cartId 
		withCreditCardNumbered: testObjectsFactory validCreditCardNumber 
		ownedBy: testObjectsFactory validOwnerName 
		expiringOn: testObjectsFactory notExpiredMonthOfYear.
		
	cartId := systemFacade createCartFor: self anotherValidUser authenticatedWith: self anotherValidUserPassword.
	systemFacade add: 5 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade 
		checkOutCartIdentifiedAs: cartId 
		withCreditCardNumbered: testObjectsFactory validCreditCardNumber 
		ownedBy: testObjectsFactory validOwnerName 
		expiringOn: testObjectsFactory notExpiredMonthOfYear.
		
	self should: [bookPerformance := systemFacade bookPerformance: self validBook ] 
		notTakeMoreThanMilliseconds: 1100.	

	quantity := bookPerformance at: 'quantity'.
	total := bookPerformance at: 'total'.
	self assert: 7 equals: quantity.
	self assert: (testObjectsFactory itemSellByTheStorePrice * 7) equals: total.
	self assert: 
		self validBook,' was selled ',quantity asString, ' times and raised a total amount of money equal to: ', total asString
		equals: (bookPerformance at: 'summary')
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - performance' stamp: 'NR 6/13/2022 08:00:04'!
test21StorePerformanceShouldNotTakeTooLong

	| cartId storePerformance quantity total |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade add: 1 of: self anotherValidBook toCartIdentifiedAs: cartId.
	systemFacade 
		checkOutCartIdentifiedAs: cartId 
		withCreditCardNumbered: testObjectsFactory validCreditCardNumber 
		ownedBy: testObjectsFactory validOwnerName 
		expiringOn: testObjectsFactory notExpiredMonthOfYear.
	
	cartId := systemFacade createCartFor: self anotherValidUser authenticatedWith: self anotherValidUserPassword.
	systemFacade add: 5 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade add: 10 of: self anotherValidBook toCartIdentifiedAs: cartId.
	systemFacade 
		checkOutCartIdentifiedAs: cartId 
		withCreditCardNumbered: testObjectsFactory validCreditCardNumber 
		ownedBy: testObjectsFactory validOwnerName 
		expiringOn: testObjectsFactory notExpiredMonthOfYear.
			
	self should: [storePerformance := systemFacade storePerformance] 
		notTakeMoreThanMilliseconds: 1100.	

	quantity := storePerformance at: 'quantity'.
	total := storePerformance at: 'total'.

	self assert: 18 equals: quantity.
	self assert: (testObjectsFactory itemSellByTheStorePrice * 7) + (testObjectsFactory anotherItemSellByTheStorePrice * 11) equals: total.
	self assert:
		'The store selled a total of ',quantity asString, ' books and raised a total amount of money equal to: ', total asString
		equals: (storePerformance at: 'summary')
		! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'HAW 7/23/2020 16:06:04'!
test14ListPurchasesIncludesBoughtItems

	| cartId purchases soldItems total |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade add: 1 of: self anotherValidBook toCartIdentifiedAs: cartId.
	systemFacade 
		checkOutCartIdentifiedAs: cartId 
		withCreditCardNumbered: testObjectsFactory validCreditCardNumber 
		ownedBy: testObjectsFactory validOwnerName 
		expiringOn: testObjectsFactory notExpiredMonthOfYear.
		
	purchases := systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword.
	soldItems := purchases first.
	total := purchases second.

	self assert: 2 equals: (soldItems at: self validBook).
	self assert: 1 equals: (soldItems at: self anotherValidBook).
	self 
		assert: (testObjectsFactory itemSellByTheStorePrice * 2 + testObjectsFactory anotherItemSellByTheStorePrice)
		equals: total! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'HAW 7/23/2020 16:06:33'!
test15CanNotListPurchasesOfInvalidCustomer

	self 
		should: [systemFacade listPurchasesOf: self invalidUser authenticatingWith: self validUserPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assertMessageTextOf: anError is: systemFacade invalidUserAndOrPasswordErrorDescription ]! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'HAW 7/23/2020 16:06:46'!
test16CanNotListPurchasesOfValidCustomerWithInvalidPassword

	self 
		should: [systemFacade listPurchasesOf: self validUser authenticatingWith: self invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assertMessageTextOf: anError is: systemFacade invalidUserAndOrPasswordErrorDescription ]! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'HAW 7/23/2020 15:56:11'!
test01CanCreateCartWithValidUserAndPassword

	| cartId |
	
	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	
	self assertIsEmptyCartIdentifiedAs: cartId ! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'HAW 7/23/2020 15:53:41'!
test02CanNotCreateCartWithInvalidUser

	self
		should: [ systemFacade createCartFor: self invalidUser authenticatedWith: self validUserPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assertMessageTextOf: anError is: systemFacade invalidUserAndOrPasswordErrorDescription ]! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'HAW 7/23/2020 15:54:39'!
test03CanNotCreateCartWithInvalidPassword

	self
		should: [ systemFacade createCartFor: self validUser authenticatedWith: self invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assertMessageTextOf: anError is: systemFacade invalidUserAndOrPasswordErrorDescription ]! !


!TusLibrosSystemFacadeTest methodsFor: 'merchant processor protocol' stamp: 'HAW 7/23/2020 16:07:46'!
debit: anAmount from: aCreditCard 

	^merchantProcessorTransactionId ! !


!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/22/2013 11:42'!
createSalesBook
	
	^OrderedCollection new! !

!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/22/2013 11:47'!
merchantProcessor 

	^self! !

!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2015 20:53'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	clock := ManualClock now: testObjectsFactory today.
	systemFacade := TusLibrosSystemFacade 
		authenticatingWith: self validUsersAndPasswords 
		acceptingItemsOf: testObjectsFactory defaultCatalog 
		registeringOn: self createSalesBook
		debitingThrought: self merchantProcessor 
		measuringTimeWith: clock
! !


!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/22/2013 00:15'!
anotherValidBook
	
	^testObjectsFactory anotherItemSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'NR 6/9/2022 20:18:52'!
anotherValidUser
	
	^'anotherValidUser'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'NR 6/9/2022 20:19:12'!
anotherValidUserPassword
	
	^'anotherValidUserPassword'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:49'!
invalidBook

	^testObjectsFactory itemNotSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HAW 7/24/2020 11:08:48'!
invalidCartId
	
	"Devuelvo un objeto nuevo cada vez y de esa forma me aseguro que no pueda ser un id usado - Hernan"
	^Object new! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:06'!
invalidPassword
	
	^'invalidPassword'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 22:30'!
invalidUser

	^'invalidUser'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:50'!
validBook
	
	^testObjectsFactory itemSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 22:27'!
validUser
	
	^'validUser'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 22:28'!
validUserPassword
	
	^'validUserPassword'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'NR 6/9/2022 20:20:12'!
validUsersAndPasswords
	
	^Dictionary new
		at: self validUser put: self validUserPassword;
		at: self anotherValidUser put: self anotherValidUserPassword;
		yourself! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HAW 7/23/2020 16:07:46'!
test10CheckOutReturnsTransactionIdAndImpactsCustomerPurchases

	| cartId  currentTransactionId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: testObjectsFactory itemSellByTheStore toCartIdentifiedAs: cartId.
	
	merchantProcessorTransactionId := Random new nextInteger: 1000.
	
	currentTransactionId := systemFacade 
		checkOutCartIdentifiedAs: cartId 
		withCreditCardNumbered: testObjectsFactory validCreditCardNumber 
		ownedBy: testObjectsFactory validOwnerName 
		expiringOn: testObjectsFactory notExpiredMonthOfYear.
	
	self assert: merchantProcessorTransactionId equals: currentTransactionId.
	self assertValidUserBougthOnlyItemSellByTheStore
	
	
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HAW 7/23/2020 16:03:56'!
test10_1_CanNotCheckoutAnAlreadyCheckedOutCart

	| cartId  |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: testObjectsFactory itemSellByTheStore toCartIdentifiedAs: cartId.
	systemFacade 
		checkOutCartIdentifiedAs: cartId 
		withCreditCardNumbered: testObjectsFactory validCreditCardNumber 
		ownedBy: testObjectsFactory validOwnerName 
		expiringOn: testObjectsFactory notExpiredMonthOfYear.
			
	self 
		should: [ 
			systemFacade 
				checkOutCartIdentifiedAs: cartId 
				withCreditCardNumbered: testObjectsFactory validCreditCardNumber 
				ownedBy: testObjectsFactory validOwnerName 
				expiringOn: testObjectsFactory notExpiredMonthOfYear ]		
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assertMessageTextOf: anError is: systemFacade invalidCartIdErrorDescription.
			self assertValidUserBougthOnlyItemSellByTheStore ]! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HAW 7/23/2020 16:04:14'!
test11CanNotCheckoutANotCreatedCart

	self
		should: [systemFacade 
			checkOutCartIdentifiedAs: self invalidCartId  
			withCreditCardNumbered: testObjectsFactory validCreditCardNumber 
			ownedBy: testObjectsFactory validOwnerName 
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assertMessageTextOf: anError is: systemFacade invalidCartIdErrorDescription ]
		
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HAW 7/23/2020 16:04:29'!
test12CanNotCheckoutAnEmptyCart

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		should: [systemFacade 
			checkOutCartIdentifiedAs: cartId 
			withCreditCardNumbered: testObjectsFactory validCreditCardNumber 
			ownedBy: testObjectsFactory validOwnerName 
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assertMessageTextOf: anError is: systemFacade cartCanNotBeEmptyErrorMessage.
			self assertThereAreNoPurchasesForValidUser ]
		
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HAW 7/23/2020 16:08:24'!
test13CanNotCheckoutWithAnExpiredCreditCard

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	self
		should: [systemFacade 
			checkOutCartIdentifiedAs: cartId 
			withCreditCardNumbered: testObjectsFactory validCreditCardNumber 
			ownedBy: testObjectsFactory validOwnerName 
			expiringOn: testObjectsFactory expiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assertMessageTextOf: anError is: systemFacade canNotChargeAnExpiredCreditCardErrorMessage.
			self assertThereAreNoPurchasesForValidUser ]
		
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HAW 7/23/2020 16:08:40'!
test19CanNotCheckOutCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	self advanceTime: (systemFacade sessionDuration + 1 minutes). 
	
	self 
		should: [systemFacade 
			checkOutCartIdentifiedAs: cartId 
			withCreditCardNumbered: testObjectsFactory validCreditCardNumber 
			ownedBy: testObjectsFactory validOwnerName 
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assertMessageTextOf: anError is: systemFacade sessionHasExpiredErrorDescription.
			self assertThereAreNoPurchasesForValidUser ].

	! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HAW 7/23/2020 15:58:09'!
test08CanNotListCartOfInvalidCartId

	self 
		should: [systemFacade listCartIdentifiedAs: self invalidCartId] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assertMessageTextOf: anError is: systemFacade invalidCartIdErrorDescription ]
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HAW 7/23/2020 16:00:20'!
test09ListCartReturnsTheRightNumberOfItems

	| cartId cartContent |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade add: 2 of: self anotherValidBook toCartIdentifiedAs: cartId.
	cartContent := systemFacade listCartIdentifiedAs: cartId.
	
	self assert: 1 equals: (cartContent occurrencesOf: self validBook). 
	self assert: 2 equals: (cartContent occurrencesOf: self anotherValidBook).
	self assert: 3 equals: cartContent size
! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HAW 7/23/2020 16:10:25'!
test18CanNotListCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self advanceTime: (systemFacade sessionDuration + 1 minutes).
	 
	self 
		should: [systemFacade listCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assertMessageTextOf: anError is: systemFacade sessionHasExpiredErrorDescription ].

! !


!TusLibrosSystemFacadeTest methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:53'!
advanceTime: aDuration 
	
	clock advanceTime: aDuration ! !

!TusLibrosSystemFacadeTest methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 13:07'!
revertTime: aDuration 
	
	clock revertTime: aDuration ! !


!TusLibrosSystemFacadeTest methodsFor: 'assertions' stamp: 'HAW 7/23/2020 15:55:56'!
assertIsEmptyCartIdentifiedAs: cartId

	^ self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty! !

!TusLibrosSystemFacadeTest methodsFor: 'assertions' stamp: 'HAW 7/23/2020 15:54:17'!
assertMessageTextOf: anError is: anExpectedMessageText 
	
	self assert: anExpectedMessageText equals: anError messageText! !

!TusLibrosSystemFacadeTest methodsFor: 'assertions' stamp: 'HAW 7/23/2020 15:47:06'!
assertThereAreNoPurchasesForValidUser

	| purchases soldItems total |
	
	purchases := systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword.
	soldItems := purchases first.
	total := purchases second.

	self assert: soldItems isEmpty.
	self assert: 0 equals: total.! !

!TusLibrosSystemFacadeTest methodsFor: 'assertions' stamp: 'HAW 7/23/2020 16:03:38'!
assertValidUserBougthOnlyItemSellByTheStore
	
	| purchases soldItems total |
	purchases := systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword.
	soldItems := purchases first.
	total := purchases second.
	
	self assert: 1 equals: (soldItems at: self validBook).
	self assert: 1 equals: soldItems size.
	self assert: testObjectsFactory itemSellByTheStorePrice equals: total.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystemFacadeTest class' category: #'TusLibros-Tests'!
TusLibrosSystemFacadeTest class
	instanceVariableNames: ''!

!TusLibrosSystemFacadeTest class methodsFor: 'fileOut' stamp: 'HAW 5/6/2020 14:06:42'!
fileOut

	"self fileOut"

	DirectoryEntry smalltalkImageDirectory // 'TusLibros.st' writeStreamDo: [ :fileStream |
		SystemOrganization fileOutCategory: 'TusLibros-Model' on: fileStream initializing: true.
		SystemOrganization fileOutCategory: 'TusLibros-Test' on: fileStream initializing: true ]! !


!classDefinition: #StoreTestObjectsFactory category: #'TusLibros-Tests'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStore
	
	^'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStorePrice
	
	^15! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/22/2013 00:16'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HAW 7/22/2020 14:26:34'!
expiredCreditCard
	
	^CreditCard numbered: self validCreditCardNumber ownedBy: self validOwnerName expiringOn: self expiredMonthOfYear ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:24'!
expiredMonthOfYear 

	^ Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HAW 7/22/2020 14:26:34'!
notExpiredCreditCard
	
	^CreditCard numbered: self validCreditCardNumber ownedBy: self validOwnerName expiringOn: self notExpiredMonthOfYear! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredMonthOfYear

	^ Month month: today monthIndex year: today yearNumber + 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HAW 7/23/2020 15:25:37'!
validCreditCardNumber
	
	^'1234567890123456'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HAW 7/23/2020 15:25:51'!
validOwnerName
	
	^'Pepe Sanchez'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'customer' stamp: 'HernanWilkinson 6/22/2013 12:02'!
customer
	
	^'aCustomer'! !


!classDefinition: #ManualClock category: #'TusLibros-Tests'!
ProtoObject subclass: #ManualClock
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!ManualClock methodsFor: 'time change' stamp: 'HernanWilkinson 6/22/2013 12:54'!
advanceTime: aDuration 
	
	now := now + aDuration ! !

!ManualClock methodsFor: 'time change' stamp: 'HernanWilkinson 6/22/2013 13:08'!
revertTime: aDuration 
	
	now := now + aDuration negated ! !


!ManualClock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:56'!
now
	
	^ now! !

!ManualClock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:53'!
today
	
	^now date! !


!ManualClock methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:52'!
initializeNow: aTime 

	now := aTime ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ManualClock class' category: #'TusLibros-Tests'!
ManualClock class
	instanceVariableNames: ''!

!ManualClock class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:52'!
now: aTime 
	
	^self new initializeNow: aTime ! !
