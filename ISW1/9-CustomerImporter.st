!classDefinition: #PersistentSet category: #CustomerImporter!
Set subclass: #PersistentSet
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentSet methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:25:31'!
initializeOn: aSession from: aNonPersistentSet

	session := aSession.
	self addAll: aNonPersistentSet ! !


!PersistentSet methodsFor: 'adding' stamp: 'HAW 11/14/2023 08:23:40'!
add: newObject

	super add: newObject.
	session persist: newObject.
	
	^newObject! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PersistentSet class' category: #CustomerImporter!
PersistentSet class
	instanceVariableNames: ''!

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:24:32'!
on: aSession

	^self on: aSession from: #()! !

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:25:00'!
on: aSession from: aNonPersistentSet

	^self new initializeOn: aSession from: aNonPersistentSet
! !


!classDefinition: #ImportTest category: #CustomerImporter!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session lastPersistedCustomer stream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'database' stamp: 'OK 6/14/2024 19:57:12'!
databaseCustomers

	^ session selectAllOfType: Customer! !

!ImportTest methodsFor: 'database' stamp: 'OK 6/14/2024 20:00:25'!
numberOfCustomers

	^ self databaseCustomers size! !

!ImportTest methodsFor: 'database' stamp: 'OK 6/15/2024 02:21:13'!
parsedLine

	^ stream parsedLineData ! !

!ImportTest methodsFor: 'database' stamp: 'OK 6/15/2024 02:49:45'!
persistNewAddressToLastCustomer

	lastPersistedCustomer addAddress: 
	( Address 
		street: self parsedLine second
		atNumber: self parsedLine third asNumber
		atCity:  self parsedLine fourth
		withZipCode:  self parsedLine fifth asNumber
		onProvince: self parsedLine sixth )! !

!ImportTest methodsFor: 'database' stamp: 'OK 6/15/2024 02:42:42'!
persistNewCustomer

	lastPersistedCustomer := Customer 
		firstName: self parsedLine second 
		lastName:  self parsedLine third 
		identificationType:  self parsedLine fourth 
		identificationNumber: self parsedLine fifth .

	session persist: lastPersistedCustomer
	
	! !

!ImportTest methodsFor: 'database' stamp: 'OK 6/15/2024 02:32:55'!
requestAddressWithStreet: aStreet atNumber: aStreetNumber andZipCode: aZipCode 

	^ self requestObjectThatMeets: [ :anAddress | 
		anAddress streetName = aStreet 
		and: [ anAddress streetNumber = aStreetNumber ] 
		and: [ anAddress zipCode = aZipCode]
		] ofType: Address! !

!ImportTest methodsFor: 'database' stamp: 'OK 6/15/2024 02:33:17'!
requestCustomerWithIdentificationType: anIdentificationType andNumber: anIdentificationNumber

	^ self requestObjectThatMeets: [ :aCustomer | 
		aCustomer identificationType = anIdentificationType 
		and: [ aCustomer identificationNumber = anIdentificationNumber ] 
		] ofType: Customer
	
	! !

!ImportTest methodsFor: 'database' stamp: 'OK 6/15/2024 02:30:31'!
requestObjectThatMeets: aBlock ofType: aType

	^ ( session select: [ :anObject | aBlock value: anObject ] ofType: aType ) anyOne! !


!ImportTest methodsFor: 'assertions' stamp: 'OK 6/14/2024 21:33:32'!
assertCustomer: aCustomer hasStreet: aStreet atNumber: aStreetNumber andZipCode: aZipCode   

	^ self assert: aCustomer addresses includes: ( self requestAddressWithStreet: aStreet atNumber: aStreetNumber andZipCode: aZipCode )! !

!ImportTest methodsFor: 'assertions' stamp: 'OK 6/14/2024 21:28:30'!
assertCustomer: aCustomer name: aName andLastName: aLastName   

	self assert: aCustomer firstName = aName.
	self assert: aCustomer lastName = aLastName! !

!ImportTest methodsFor: 'assertions' stamp: 'OK 6/14/2024 20:00:34'!
assertNumberOfCustomers: aQuantity

	^ self assert: self numberOfCustomers = aQuantity! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'OK 6/15/2024 01:46:53'!
setUp
	
	self startDatabaseSession.
	self importStream. 
	! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'OK 6/14/2024 19:30:51'!
startDatabaseSession

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'OK 6/15/2024 01:22:24'!
tearDown

	self terminateDatabaseSession.
	! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'OK 6/14/2024 19:36:27'!
terminateDatabaseSession

	session commit.
	session close! !


!ImportTest methodsFor: 'dataStream' stamp: 'OK 6/15/2024 01:14:31'!
dataStream

	^ 
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'dataStream' stamp: 'OK 6/15/2024 02:03:07'!
importStream

	stream := InputStream forResource: self dataStream.! !

!ImportTest methodsFor: 'dataStream' stamp: 'OK 6/15/2024 01:20:11'!
jumpToNextLine

	^ stream nextLine! !

!ImportTest methodsFor: 'dataStream' stamp: 'OK 6/15/2024 01:25:11'!
lineRepresentsAddress

	^ stream line beginsWith: 'A'.! !

!ImportTest methodsFor: 'dataStream' stamp: 'OK 6/15/2024 01:25:39'!
lineRepresentsCustomer

	^ stream line beginsWith: 'C'.! !

!ImportTest methodsFor: 'dataStream' stamp: 'OK 6/15/2024 02:22:30'!
processLineAndPersistOnDatabase

	self lineRepresentsCustomer ifTrue: [ self persistNewCustomer ].
	self lineRepresentsAddress    ifTrue: [ self persistNewAddressToLastCustomer ]! !

!ImportTest methodsFor: 'dataStream' stamp: 'OK 6/15/2024 01:20:59'!
readableLine

	^ stream readableLine! !


!ImportTest methodsFor: 'test' stamp: 'OK 6/15/2024 01:20:59'!
importCustomers

	[ self readableLine ] whileTrue: [
		self processLineAndPersistOnDatabase.
		self jumpToNextLine.
	].

! !

!ImportTest methodsFor: 'test' stamp: 'OK 6/14/2024 22:20:28'!
test01Import

	| customer1 customer2 |
	
	self importCustomers.
	
	customer1 := self requestCustomerWithIdentificationType: 'D' andNumber: '22333444'.
	customer2 := self requestCustomerWithIdentificationType: 'C' andNumber: '23-25666777-9'.
	
	self assertNumberOfCustomers: 2.
	
	self assertCustomer: customer1 name: 'Pepe' andLastName: 'Sanchez'.
	self assertCustomer: customer1 hasStreet: 'San Martin' atNumber: 3322 andZipCode: 1636.
	self assertCustomer: customer1 hasStreet: 'Maipu' atNumber: 888 andZipCode: 1122.
	
	self assertCustomer: customer2 name: 'Juan' andLastName: 'Perez'.
	self assertCustomer: customer2 hasStreet: 'Alem' atNumber: 1122 andZipCode: 1001.
	! !


!classDefinition: #Address category: #CustomerImporter!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'initialize' stamp: 'OK 6/15/2024 02:46:40'!
initializeWith: aStreetName atNumber: aStreetNumber atCity: aCityName withZipCode: aZipCode onProvince: aProvinceName

	streetName := aStreetName.
	streetNumber  := aStreetNumber.
	town  := aCityName.
	zipCode  := aZipCode.
	province := aProvinceName.! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Address class' category: #CustomerImporter!
Address class
	instanceVariableNames: ''!

!Address class methodsFor: 'as yet unclassified' stamp: 'OK 6/15/2024 02:45:18'!
street: aStreetName atNumber: aStreetNumber atCity: aCityName withZipCode: aZipCode onProvince: aProvinceName

	^ self new initializeWith: aStreetName atNumber: aStreetNumber atCity: aCityName withZipCode: aZipCode onProvince: aProvinceName! !


!classDefinition: #Customer category: #CustomerImporter!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:25:42'!
initialize

	super initialize.
	addresses := Set new.! !

!Customer methodsFor: 'initialization' stamp: 'OK 6/15/2024 02:38:54'!
initializeWith: aName lastName: aLastName identificationType: anIdentificationType identificationNumber: anIdentificationNumber

	super initialize.
	firstName := aName.
	lastName := aLastName.
	identificationType := anIdentificationType.
	identificationNumber := anIdentificationNumber.
	addresses := Set new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: #CustomerImporter!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'as yet unclassified' stamp: 'OK 6/15/2024 02:35:56'!
firstName: aName lastName: aLastName identificationType: anIdentificationType identificationNumber: anidentificationNumber

	^ self new initializeWith: aName lastName: aLastName identificationType: anIdentificationType identificationNumber: anidentificationNumber! !


!classDefinition: #DataBaseSession category: #CustomerImporter!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id inTransaction closed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:25'!
beginTransaction

	inTransaction := true.! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:18'!
commit

	inTransaction := false.! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 11/14/2023 08:52:30'!
close

	closed := true.! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:49:30'!
assertCanUseDatabase

	self assertIsOpen.
	self assertInTransaction ! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:43'!
assertInTransaction

	inTransaction ifFalse: [ self error: 'Not in transaction' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:16'!
assertIsOpen

	closed ifTrue: [ self error: 'Connection with database closed' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:09:07'!
assertTypeIsPersisted: aType

	(configuration includes: aType) ifFalse: [ self error: 'Object of type ', aType name, ' are not configured to be persisted' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
isRelationToPersist: possibleRelation

	^ possibleRelation class = Set! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
persistPossibleRelationOf: anObject at: anInstVarOffset

	| possibleRelation |
		
	possibleRelation := anObject instVarAt: anInstVarOffset.
	(self isRelationToPersist: possibleRelation) ifTrue: [ self persistRelationOf: anObject at: anInstVarOffset with: possibleRelation ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:03'!
persistRelationOf: anObject at: anInstVarOffset with: aRelation

	| persistentRelation |
	
	persistentRelation := PersistentSet on: self from: aRelation.
	anObject instVarAt: anInstVarOffset put: persistentRelation! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:34'!
persistRelationsOf: anObject

	anObject class instVarNamesAndOffsetsDo: [ :anInstVarName :anInstVarOffset | self persistPossibleRelationOf: anObject at: anInstVarOffset]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:06:24'!
tableOfType: aType

	^ tables at: aType ifAbsentPut: [ Set new ]! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:44:19'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.
	inTransaction := false.
	closed := false.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 11/14/2023 09:06:24'!
persist: anObject

	| table |

	self assertCanUseDatabase.
	self assertTypeIsPersisted: anObject class.
	self delay.
	
	table := self tableOfType: anObject class.
	self defineIdOf: anObject.
	table add: anObject.
	self persistRelationsOf: anObject.
! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:06:56'!
select: aCondition ofType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:07:12'!
selectAllOfType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: #CustomerImporter!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !


!classDefinition: #InputStream category: #CustomerImporter!
Object subclass: #InputStream
	instanceVariableNames: 'stream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!


!InputStream methodsFor: 'as yet unclassified' stamp: 'OK 6/15/2024 01:38:17'!
line

	self subclassResponsibility.! !

!InputStream methodsFor: 'as yet unclassified' stamp: 'OK 6/15/2024 01:10:26'!
nextLine

	self subclassResponsibility ! !

!InputStream methodsFor: 'as yet unclassified' stamp: 'OK 6/15/2024 02:20:09'!
parsedLineData

	self subclassResponsibility! !

!InputStream methodsFor: 'as yet unclassified' stamp: 'OK 6/15/2024 01:10:20'!
readableLine

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InputStream class' category: #CustomerImporter!
InputStream class
	instanceVariableNames: ''!

!InputStream class methodsFor: 'as yet unclassified' stamp: 'OK 6/15/2024 01:59:05'!
canHandle

	self subclassResponsibility! !

!InputStream class methodsFor: 'as yet unclassified' stamp: 'OK 6/15/2024 01:59:22'!
for: aDataStream

	^ self new initializeWith: aDataStream ! !

!InputStream class methodsFor: 'as yet unclassified' stamp: 'OK 6/15/2024 02:04:26'!
forResource: aDataStream

	^ (self subclasses detect: [:aDataStreamClass | aDataStreamClass canHandle: aDataStream ]) for: aDataStream! !


!classDefinition: #TextStream category: #CustomerImporter!
InputStream subclass: #TextStream
	instanceVariableNames: 'lineIndex'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TextStream methodsFor: 'as yet unclassified' stamp: 'OK 6/15/2024 01:40:57'!
initializeWith: aDataStream

	stream := aDataStream.
	lineIndex := 1.! !

!TextStream methodsFor: 'as yet unclassified' stamp: 'OK 6/15/2024 01:39:28'!
line

	^ stream lineNumber: lineIndex! !

!TextStream methodsFor: 'as yet unclassified' stamp: 'OK 6/15/2024 01:39:46'!
nextLine

	lineIndex := lineIndex + 1.! !

!TextStream methodsFor: 'as yet unclassified' stamp: 'OK 6/15/2024 02:19:45'!
parsedLineData

	^ ( self line ) findTokens: $,! !

!TextStream methodsFor: 'as yet unclassified' stamp: 'OK 6/15/2024 01:40:41'!
readableLine
	
	^ lineIndex <= stream lineCount! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TextStream class' category: #CustomerImporter!
TextStream class
	instanceVariableNames: ''!

!TextStream class methodsFor: 'as yet unclassified' stamp: 'OK 6/15/2024 02:05:40'!
canHandle: aDataStream

	^ aDataStream isString.! !


!classDefinition: #UniFiLeStream category: #CustomerImporter!
InputStream subclass: #UniFiLeStream
	instanceVariableNames: 'line'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!UniFiLeStream methodsFor: 'as yet unclassified' stamp: 'OK 6/15/2024 01:55:30'!
initializeWith: aDataStream

	stream := UniFileStream new open: 'input.txt' forWrite: false.
	line := stream nextLine. ! !

!UniFiLeStream methodsFor: 'as yet unclassified' stamp: 'OK 6/15/2024 01:56:25'!
line

	^ line! !

!UniFiLeStream methodsFor: 'as yet unclassified' stamp: 'OK 6/15/2024 01:56:36'!
nextLine

	line := stream nextLine.! !

!UniFiLeStream methodsFor: 'as yet unclassified' stamp: 'OK 6/15/2024 02:19:56'!
parsedLineData

	^ ( self line ) findTokens: $,! !

!UniFiLeStream methodsFor: 'as yet unclassified' stamp: 'OK 6/15/2024 01:56:53'!
readableLine
	
	^ line notNil! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UniFiLeStream class' category: #CustomerImporter!
UniFiLeStream class
	instanceVariableNames: ''!

!UniFiLeStream class methodsFor: 'as yet unclassified' stamp: 'OK 6/15/2024 02:06:49'!
canHandle: aDataStream

	^ aDataStream isFile.! !
