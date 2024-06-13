!classDefinition: #TusLibrosClientTestWindowView category: #TusLibrosREST!
SystemWindow subclass: #TusLibrosClientTestWindowView
	instanceVariableNames: 'cartIdsListMorph booksCatalogListMorph cartContentListMorph addToCartButtonMorph listCartButtonMorph selectedCartLabelMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosREST'!

!TusLibrosClientTestWindowView methodsFor: 'events' stamp: 'NR 6/13/2022 07:06:24'!
informBook: bookIsbn addedToCart: cartId

	self inform: bookIsbn,' added to CartId: ', cartId asString
	
! !

!TusLibrosClientTestWindowView methodsFor: 'events' stamp: 'OK 6/13/2024 14:01:32'!
informError: anError

	self inform: 'Server error: ', ( anError asString )! !

!TusLibrosClientTestWindowView methodsFor: 'events' stamp: 'NR 6/13/2022 07:06:29'!
refreshCartButtonsLabels: anIndex

	self refreshButton: listCartButtonMorph withLabel: 'List CartId: '  onIndex: anIndex.
	self refreshButton: addToCartButtonMorph withLabel: 'Add to CartId: '  onIndex: anIndex.
	
	
	! !

!TusLibrosClientTestWindowView methodsFor: 'events' stamp: 'NR 6/13/2022 07:06:35'!
refreshCurrentSelectedCartContent: cartId

	cartContentListMorph updateList.
	selectedCartLabelMorph contents: 'Books in CartId: ', cartId
	
	
	! !

!TusLibrosClientTestWindowView methodsFor: 'events' stamp: 'OK 6/13/2024 08:00:22'!
refreshListOfCartIds

	cartIdsListMorph updateList.
	! !


!TusLibrosClientTestWindowView methodsFor: 'private' stamp: 'NR 6/10/2024 08:14:51'!
refreshButton: aButton withLabel: aLabel onIndex: anIndex

	| newLabel height |

	newLabel := aLabel.
	height := aButton morphHeight.
	(anIndex ~= 0) ifTrue: [newLabel := newLabel,  (self model cartIds at: anIndex) asString].
	aButton label: newLabel.
	aButton morphHeight: height. 
	aButton redrawNeeded 
	
	! !


!TusLibrosClientTestWindowView methodsFor: 'GUI building' stamp: 'NR 6/13/2022 07:05:51'!
build1stRow

	| createCartButtonMorph firstRowLayoutMorph |
	
	createCartButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #createCart label: 'Create Cart'.	
	addToCartButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #addToCart label: 'Add To Cart'.	
	
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: createCartButtonMorph;
	addMorph: self build2ndColumn1stRow;
	addMorph: self build3rdColumn1stRow;
	addMorph:  addToCartButtonMorph.
	
	
	^firstRowLayoutMorph.! !

!TusLibrosClientTestWindowView methodsFor: 'GUI building' stamp: 'NR 6/10/2024 07:22:55'!
build2ndColumn1stRow

	| secondColumnLayoutMorphOfFirstRow height rect width |
	
	rect := self allowedArea.
	width := ((rect corner x - rect origin x) / 5) rounded.
	height := ((rect corner y - rect origin y) / 5.5) rounded.
	
	cartIdsListMorph := PluggableListMorph model: self model listGetter: #cartIds indexGetter: #cartIdsIndex indexSetter: #cartIdsIndex:.
	cartIdsListMorph  borderColor: Color lightBlue; borderWidth: 1; morphHeight: height.
		
	secondColumnLayoutMorphOfFirstRow := LayoutMorph newColumn.
	secondColumnLayoutMorphOfFirstRow separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Carts Created');
	addMorph: cartIdsListMorph.
	
	secondColumnLayoutMorphOfFirstRow layoutSpec fixedWidth: width.
	cartIdsListMorph layoutSpec proportionalWidth: 1.
	cartIdsListMorph layoutSpec proportionalHeight: 1.
		
	^secondColumnLayoutMorphOfFirstRow.! !

!TusLibrosClientTestWindowView methodsFor: 'GUI building' stamp: 'NR 6/10/2024 07:22:51'!
build2ndColumn2ndRow

	| secondColumnLayoutMorphOfSecondRow height rect width |

	rect := self allowedArea.
	width := ((rect corner x - rect origin x) / 5) rounded.
	height := ((rect corner y - rect origin y) / 5.5) rounded.
	
	cartContentListMorph := PluggableListMorph model: self model listGetter: #cartContent indexGetter: nil indexSetter: nil.
	cartContentListMorph  borderColor: Color lightBlue; borderWidth: 1; morphHeight: height.
	
	selectedCartLabelMorph := LabelMorph contents:'Books in CartId: '.
		
	secondColumnLayoutMorphOfSecondRow := LayoutMorph newColumn.
	secondColumnLayoutMorphOfSecondRow separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: selectedCartLabelMorph;
	addMorph: cartContentListMorph.
	
	secondColumnLayoutMorphOfSecondRow layoutSpec fixedWidth: width.
	cartContentListMorph layoutSpec proportionalWidth: 1.
	cartContentListMorph layoutSpec proportionalHeight: 1.
		
	^secondColumnLayoutMorphOfSecondRow.! !

!TusLibrosClientTestWindowView methodsFor: 'GUI building' stamp: 'NR 6/13/2022 07:06:04'!
build2ndRow

	| secondRowLayoutMorph |

	listCartButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #listCart label: 'List CartId: '.	
	
	secondRowLayoutMorph := LayoutMorph newRow.
	secondRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: listCartButtonMorph;
	addMorph: self build2ndColumn2ndRow.
	
	^secondRowLayoutMorph

		! !

!TusLibrosClientTestWindowView methodsFor: 'GUI building' stamp: 'NR 6/10/2024 07:22:59'!
build3rdColumn1stRow

	| thirdColumnLayoutMorphOfFirstRow height rect width |
	
	rect := self allowedArea.
	width := ((rect corner x - rect origin x) / 5) rounded.
	height := ((rect corner y - rect origin y) / 5.5) rounded.
	
	booksCatalogListMorph := PluggableListMorph model: self model listGetter: #booksCatalog indexGetter: #booksCatalogIndex indexSetter: #booksCatalogIndex:.
	booksCatalogListMorph borderColor: Color lightBlue; borderWidth: 1; morphWidth: width; morphHeight: height.
		
	thirdColumnLayoutMorphOfFirstRow  := LayoutMorph newColumn.
	thirdColumnLayoutMorphOfFirstRow  separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Book Catalog');
	addMorph: booksCatalogListMorph.
	
	thirdColumnLayoutMorphOfFirstRow layoutSpec fixedWidth: width.
		
	^thirdColumnLayoutMorphOfFirstRow.! !

!TusLibrosClientTestWindowView methodsFor: 'GUI building' stamp: 'NR 6/10/2024 07:04:09'!
buildMorphicWindow

	self layoutMorph beColumn;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: self build1stRow;
	addMorph: self build2ndRow.
	! !

!TusLibrosClientTestWindowView methodsFor: 'GUI building' stamp: 'NR 6/10/2024 08:19:45'!
defaultExtent

	| height rect width |
	
	"^ 1035@485"
	
	rect := self allowedArea.
	width := ((rect corner x - rect origin x) / 1.5) rounded.
	height := ((rect corner y - rect origin y) / 1.6) rounded.
	
	^ (width@height)
	! !


!TusLibrosClientTestWindowView methodsFor: 'initialization' stamp: 'OK 6/13/2024 13:16:03'!
initializeWith: aTitle

	self setLabel: aTitle.
	self model: (TusLibrosClientTestWindowModel new).
	self buildMorphicWindow.
	self openInWorld.
	self morphExtent: (self defaultExtent).
		
	self model when: #newCartIdArrived send: #refreshListOfCartIds to: self.		
	self model when: #selectedCartChanged send: #refreshCartButtonsLabels: to: self.	
	self model when: #bookAddedToCart send: #informBook:addedToCart: to: self.
	self model when: #newCurrentSelectedCartContentArrived send: #refreshCurrentSelectedCartContent: to: self.
	
	self model when: #serverError send: #informError: to: self. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientTestWindowView class' category: #TusLibrosREST!
TusLibrosClientTestWindowView class
	instanceVariableNames: ''!

!TusLibrosClientTestWindowView class methodsFor: 'instance creation' stamp: 'NR 6/9/2022 02:07:29'!
open
	
	^self new initializeWith: 'TusLibros Client Test Window'.! !


!classDefinition: #TusLibrosTest category: #TusLibrosREST!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosREST'!

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'OK 6/13/2024 07:46:49'!
test01
	
	WebServer reset.
	TusLibrosServerRestInterface installForDefaultSystem.
	TusLibrosClientTestWindowView open.
	
	
	! !


!classDefinition: #ParallelProcess category: #TusLibrosREST!
Object subclass: #ParallelProcess
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosREST'!

!ParallelProcess methodsFor: 'as yet unclassified' stamp: 'OK 6/13/2024 14:48:15'!
initializeWith: aBlock

	aBlock fork! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ParallelProcess class' category: #TusLibrosREST!
ParallelProcess class
	instanceVariableNames: ''!

!ParallelProcess class methodsFor: 'as yet unclassified' stamp: 'OK 6/13/2024 14:45:24'!
run: aBlock

	^ self new initializeWith: aBlock! !


!classDefinition: #TusLibrosClientRestInterface category: #TusLibrosREST!
Object subclass: #TusLibrosClientRestInterface
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosREST'!

!TusLibrosClientRestInterface methodsFor: 'requests' stamp: 'OK 6/13/2024 13:04:00'!
add: quantity of: bookIsbn toCartIdentifiedAs: cartId

	^ self sendRequestTo: '/addToCart' withArguments: {'cartId'. cartId. 'bookIsbn'. bookIsbn. 'bookQuantity'. quantity}! !

!TusLibrosClientRestInterface methodsFor: 'requests' stamp: 'OK 6/13/2024 13:04:05'!
createCartFor: aUser password: aPassword

	^ self sendRequestTo: '/createCart' withArguments: {'clientId'. aUser. 'password'. aPassword}! !

!TusLibrosClientRestInterface methodsFor: 'requests' stamp: 'OK 6/13/2024 13:04:10'!
listCart: cartId

	^ self sendRequestTo: '/listCart' withArguments: {'cartId'. cartId. }
	! !

!TusLibrosClientRestInterface methodsFor: 'requests' stamp: 'OK 6/13/2024 14:24:24'!
sendRequestTo: anEndpoint withArguments: aSetOfPairs

	| fieldDict resp |

	fieldDict := Dictionary newFromPairs: aSetOfPairs.			
	resp := WebClient htmlSubmit: (self url,anEndpoint) fields: fieldDict.
		
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream))] 
		ifFalse:[ ^ self error: resp content]! !


!TusLibrosClientRestInterface methodsFor: 'initialization' stamp: 'NR 6/9/2022 08:11:33'!
port

	^port ifNil: [port:=9999].! !

!TusLibrosClientRestInterface methodsFor: 'initialization' stamp: 'NR 6/9/2022 08:11:37'!
url

	^'http://localhost:', self port asString! !


!classDefinition: #TusLibrosClientTestWindowModel category: #TusLibrosREST!
Object subclass: #TusLibrosClientTestWindowModel
	instanceVariableNames: 'cartIds selectedCartIdsIndex selectedBookCatalogIndex currentSelectedCartContent restInterface intermediary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosREST'!

!TusLibrosClientTestWindowModel methodsFor: 'accessing' stamp: 'NR 6/13/2022 07:09:38'!
selectedBook

	^self booksCatalog at: selectedBookCatalogIndex! !

!TusLibrosClientTestWindowModel methodsFor: 'accessing' stamp: 'NR 6/13/2022 07:09:42'!
selectedCartId

	^self cartIds at: selectedCartIdsIndex! !


!TusLibrosClientTestWindowModel methodsFor: 'testing' stamp: 'NR 6/13/2022 07:09:49'!
areCartIdAndBookSelected

	^selectedCartIdsIndex  ~= 0 and: [selectedBookCatalogIndex  ~= 0]! !

!TusLibrosClientTestWindowModel methodsFor: 'testing' stamp: 'NR 6/13/2022 07:09:52'!
isCartIdSelected

	^selectedCartIdsIndex ~= 0! !


!TusLibrosClientTestWindowModel methodsFor: 'listSelectors' stamp: 'NR 6/13/2022 07:10:01'!
booksCatalog

	^self defaultCatalog keys! !

!TusLibrosClientTestWindowModel methodsFor: 'listSelectors' stamp: 'NR 6/9/2022 08:12:38'!
booksCatalogIndex

	^selectedBookCatalogIndex! !

!TusLibrosClientTestWindowModel methodsFor: 'listSelectors' stamp: 'NR 6/9/2022 08:12:41'!
booksCatalogIndex: anIndex

	selectedBookCatalogIndex  := anIndex! !

!TusLibrosClientTestWindowModel methodsFor: 'listSelectors' stamp: 'NR 6/9/2022 08:12:45'!
cartContent

	^currentSelectedCartContent! !

!TusLibrosClientTestWindowModel methodsFor: 'listSelectors' stamp: 'NR 6/9/2022 08:12:57'!
cartIds

	^cartIds! !

!TusLibrosClientTestWindowModel methodsFor: 'listSelectors' stamp: 'NR 6/13/2022 07:10:15'!
cartIdsIndex

	^selectedCartIdsIndex! !

!TusLibrosClientTestWindowModel methodsFor: 'listSelectors' stamp: 'NR 6/13/2022 07:10:19'!
cartIdsIndex: anIndex

	selectedCartIdsIndex  := anIndex. 
		
	self triggerEvent: #selectedCartChanged with: selectedCartIdsIndex
	! !


!TusLibrosClientTestWindowModel methodsFor: 'buttonSelectors' stamp: 'OK 6/13/2024 14:53:56'!
addToCart

		| cartId bookIsbn |

		(self areCartIdAndBookSelected) ifTrue:[
			cartId := self selectedCartId. 
			bookIsbn := self selectedBook. 
			self 
				requestOnParallel: [ restInterface add: 1 of: bookIsbn toCartIdentifiedAs: cartId ] 
				onSuccesDo:   [ self triggerEvent: #bookAddedToCart withArguments: (Array with: bookIsbn with: cartId) ].
		].
	
	

	! !

!TusLibrosClientTestWindowModel methodsFor: 'buttonSelectors' stamp: 'OK 6/13/2024 14:53:56'!
createCart

	| newCartId  |
	self 
		requestOnParallel: [ newCartId := restInterface createCartFor: 'hernan' password: 'smalltalk' ] 
		onSuccesDo:  [ cartIds add: newCartId. self triggerEvent: #newCartIdArrived ].
	
	
	
	! !

!TusLibrosClientTestWindowModel methodsFor: 'buttonSelectors' stamp: 'OK 6/13/2024 14:53:56'!
listCart
	
	| cartId  |

	(self isCartIdSelected) ifTrue: [
		cartId := self selectedCartId.
		self 
			requestOnParallel: [currentSelectedCartContent := restInterface listCart: cartId ] 
			onSuccesDo:   [ self triggerEvent: #newCurrentSelectedCartContentArrived with: cartId ].
	]
	

	! !

!TusLibrosClientTestWindowModel methodsFor: 'buttonSelectors' stamp: 'OK 6/13/2024 14:53:56'!
requestOnParallel: aBlock onSuccesDo: anotherBlock
	
	| isSuccess |
	
	isSuccess := true.

	ParallelProcess run: [
		aBlock on: Error do: [ :anError | self triggerEvent: #serverError with: anError. isSuccess := false ].
		isSuccess ifTrue: anotherBlock.
	]! !


!TusLibrosClientTestWindowModel methodsFor: 'initialization' stamp: 'NR 6/9/2022 08:13:11'!
defaultCatalog 

	^Dictionary new
		at: 'GreenBook' put: 10*dollar;
		at: 'BlueBook' put: 15*dollar;
		at: 'MartinFierro' put: 350*peso;
		yourself! !

!TusLibrosClientTestWindowModel methodsFor: 'initialization' stamp: 'OK 6/13/2024 10:28:12'!
initialize

	cartIds := OrderedCollection new.
	currentSelectedCartContent := OrderedCollection new.
	selectedCartIdsIndex := 0.
	selectedBookCatalogIndex := 0.
	restInterface := TusLibrosClientRestInterface new.
! !


!classDefinition: #TusLibrosServerRestInterface category: #TusLibrosREST!
Object subclass: #TusLibrosServerRestInterface
	instanceVariableNames: 'systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosREST'!

!TusLibrosServerRestInterface methodsFor: 'initialization' stamp: 'HAW 5/5/2020 17:18:31'!
initializeOn: aTusLibrosSystemFacade 
	
	systemFacade := aTusLibrosSystemFacade.! !


!TusLibrosServerRestInterface methodsFor: 'request' stamp: 'NR 6/10/2024 08:32:07'!
answer: aBlock to: aRequest 

	| response |
	
	[ response := aBlock value.
	aRequest send200Response: (WebUtils jsonEncode: (response))]
		on: Error
		do: [ :anError | aRequest send500Response: anError messageText ]! !

!TusLibrosServerRestInterface methodsFor: 'request' stamp: 'NR 11/7/2022 07:07:51'!
bookIsbnFrom: requestFields

	^ requestFields at: 'bookIsbn'! !

!TusLibrosServerRestInterface methodsFor: 'request' stamp: 'NR 11/7/2022 07:07:47'!
bookQuantityFrom: requestFields

	^ (requestFields at: 'bookQuantity') asNumber! !

!TusLibrosServerRestInterface methodsFor: 'request' stamp: 'HAW 7/23/2020 16:18:57'!
cartIdFrom: requestFields

	^ (requestFields at: 'cartId') asNumber! !

!TusLibrosServerRestInterface methodsFor: 'request' stamp: 'HAW 7/23/2020 16:20:08'!
clientIdFrom: requestFields

	^ requestFields at: 'clientId'! !

!TusLibrosServerRestInterface methodsFor: 'request' stamp: 'HAW 7/23/2020 16:20:19'!
passwordFrom: requestFields

	^ requestFields at: 'password'! !

!TusLibrosServerRestInterface methodsFor: 'request' stamp: 'NR 11/7/2022 07:07:39'!
withFieldsOf: aRequest do: aBlock

	[ aBlock value: aRequest fields ]
		on: Error
		do: [ :anError | aRequest 
			sendResponseCode: 400 
			content: ('Invalid request: ', anError messageText) asUtf8Bytes
			type: 'text/plain; charset=utf-8'
			close: true ]! !


!TusLibrosServerRestInterface methodsFor: 'rest interface' stamp: 'OK 6/12/2024 21:47:25'!
addToCart: aRequest

	| bookIsbn cartId quantity |

	(Delay forSeconds: 3) wait.
	
	self withFieldsOf: aRequest do: [ :requestFields |
		cartId := self cartIdFrom: requestFields.
		bookIsbn := self bookIsbnFrom: requestFields.
		quantity := self bookQuantityFrom: requestFields].
		
	self 
		answer: [
			systemFacade add: quantity of: bookIsbn toCartIdentifiedAs: cartId.
			'OK' ]
		to: aRequest 
	! !

!TusLibrosServerRestInterface methodsFor: 'rest interface' stamp: 'HAW 7/23/2020 16:19:16'!
checkOutCart: aRequest

	| cartId creditCardNumber creditCardOwner creditCartExpirationDate creditCartExpirationDateString transactionId |
	
	self withFieldsOf: aRequest do: [ :requestFields |
		cartId := self cartIdFrom: requestFields.
		creditCardNumber := requestFields at: 'ccn'.
		creditCartExpirationDateString := requestFields at: 'cced'.
		creditCartExpirationDate := Month 
			month: (creditCartExpirationDateString first: 2) asNumber 
			year: (creditCartExpirationDateString last: 4) asNumber.
		creditCardOwner := requestFields at: 'cco' ].
	
	self 
		answer: [
			transactionId := systemFacade 
					checkOutCartIdentifiedAs: cartId 
					withCreditCardNumbered: creditCardNumber 
					ownedBy: creditCardOwner 
					expiringOn: creditCartExpirationDate. 
			transactionId printString ]
		to: aRequest ! !

!TusLibrosServerRestInterface methodsFor: 'rest interface' stamp: 'OK 6/12/2024 21:47:17'!
createCart: aRequest

	| clientId password |

		(Delay forSeconds: 1) wait.
	
		self withFieldsOf: aRequest do: [ :requestFields |
			clientId := self clientIdFrom: requestFields.
			password := self passwordFrom: requestFields ].
	
		self 
			answer: [ | cartId | 
				cartId := systemFacade createCartFor: clientId authenticatedWith: password.
				cartId printString ]
			to: aRequest 
! !

!TusLibrosServerRestInterface methodsFor: 'rest interface' stamp: 'OK 6/12/2024 21:47:08'!
listCart: aRequest

	| cartId |

	(Delay forSeconds: 10) wait.
	
	self withFieldsOf: aRequest do: [ :requestFields |
		cartId := self cartIdFrom: requestFields ].
	
	self 
		answer: [(systemFacade listCartIdentifiedAs: cartId) asArray]
		to: aRequest 
	! !

!TusLibrosServerRestInterface methodsFor: 'rest interface' stamp: 'HAW 7/23/2020 16:20:19'!
listPurchases: aRequest

	| clientId password purchases response |
	
	self withFieldsOf: aRequest do: [ :requestFields |
		clientId := self clientIdFrom: requestFields.
		password := self passwordFrom: requestFields ].
	
	self 
		answer: [ | soldItems total |
			purchases := systemFacade listPurchasesOf: clientId authenticatingWith: password.
			soldItems := purchases first.
			total := purchases second.
			response := String streamContents: [:stream | 
				soldItems keysAndValuesDo: [ :isbn :amount |
					stream nextPutAll: isbn; nextPut: $|; print: amount; nextPut: $| ].
				stream print: total ].
			response ]
		to: aRequest ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosServerRestInterface class' category: #TusLibrosREST!
TusLibrosServerRestInterface class
	instanceVariableNames: ''!

!TusLibrosServerRestInterface class methodsFor: 'default objects' stamp: 'HAW 5/5/2020 17:11:42'!
createSalesBook
	
	^OrderedCollection new! !

!TusLibrosServerRestInterface class methodsFor: 'default objects' stamp: 'HAW 5/5/2020 17:47:11'!
defaultCatalog 
	
	^Dictionary new
		at: 'GreenBook' put: 10*dollar;
		at: 'BlueBook' put: 15*dollar;
		at: 'MartinFierro' put: 350*peso;
		yourself! !

!TusLibrosServerRestInterface class methodsFor: 'default objects' stamp: 'HAW 5/5/2020 17:13:55'!
defaultMerchantProcessor 
	
	^DefaultMerchantProcessor new! !

!TusLibrosServerRestInterface class methodsFor: 'default objects' stamp: 'HAW 5/5/2020 17:13:46'!
defaultSystem

	| clock systemFacade |
	
	clock := RealTimeClock new.
	systemFacade := TusLibrosSystemFacade 
		authenticatingWith: self validUsersAndPasswords 
		acceptingItemsOf: self defaultCatalog 
		registeringOn: self createSalesBook
		debitingThrought: self defaultMerchantProcessor 
		measuringTimeWith: clock.

	^systemFacade ! !

!TusLibrosServerRestInterface class methodsFor: 'default objects' stamp: 'HAW 5/5/2020 17:10:11'!
validUsersAndPasswords 
	
	^Dictionary new
		at: 'hernan' put: 'smalltalk';
		at: 'maximo' put: 'ruby';
		yourself! !


!TusLibrosServerRestInterface class methodsFor: 'instance creation' stamp: 'HAW 5/5/2020 17:18:06'!
on: aTusLibrosSystemFacade 

	^self new initializeOn: aTusLibrosSystemFacade ! !


!TusLibrosServerRestInterface class methodsFor: 'installation' stamp: 'OK 6/12/2024 21:28:17'!
installForDefaultSystem

	"self installForDefaultSystem"
	
	| server port interface |
	
	interface := self on: self defaultSystem.
	
	"Esto es para poder acceder a la interface de manera global - Hernan"
	Smalltalk at: #CurrentTusLibrosRestInterface put: interface.
	
	port := 9999.
	server := WebServer reset default.
	server listenOn: port.
	server 
		addService: '/createCart' 
		action: [:request |  interface createCart: request  ].
	server 
		addService: '/addToCart' 
		action: [:request | interface addToCart: request ].
	server
		addService: '/listCart' 
		action: [:request | interface listCart: request ].
	server
		addService: '/checkOutCart' 
		action: [:request | interface checkOutCart: request ].
	server
		addService: '/listPurchases' 
		action: [:request | interface listPurchases: request ].
	server useDebugErrorHandler ! !


!classDefinition: #DefaultMerchantProcessor category: #TusLibrosREST!
ProtoObject subclass: #DefaultMerchantProcessor
	instanceVariableNames: 'transactionId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosREST'!

!DefaultMerchantProcessor methodsFor: 'debit' stamp: 'HAW 5/5/2020 17:13:16'!
debit: anAmount from: aCreditCard 

	transactionId := transactionId + 1.
	^transactionId! !


!DefaultMerchantProcessor methodsFor: 'initialization' stamp: 'HAW 5/5/2020 17:13:31'!
initialize

	super initialize.
	transactionId := 0! !


!classDefinition: #RealTimeClock category: #TusLibrosREST!
ProtoObject subclass: #RealTimeClock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosREST'!

!RealTimeClock methodsFor: 'time' stamp: 'HAW 5/5/2020 17:07:39'!
now

	^DateAndTime now! !

!RealTimeClock methodsFor: 'time' stamp: 'HAW 5/5/2020 17:07:48'!
today

	^Date today! !
