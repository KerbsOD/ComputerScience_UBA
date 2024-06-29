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


!PersistentSet methodsFor: 'adding' stamp: 'OK 6/28/2024 14:23:25'!
addCustomer: newObject

	super addCustomer: newObject.
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


!classDefinition: #CustomerTest category: #CustomerImporter!
TestCase subclass: #CustomerTest
	instanceVariableNames: 'system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerTest methodsFor: 'tests' stamp: 'OK 6/29/2024 00:00:21'!
test01ValidDataIsImportedCorrectly

	CustomerImporter valueFrom: self validImportData into: system.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!CustomerTest methodsFor: 'tests' stamp: 'OK 6/28/2024 23:59:26'!
test02CanNotImportAddressWithoutCustomer

	self
		should: [ CustomerImporter valueFrom: self addressWithoutCustomerData into: ( system customerSystem). ]
		raise: Error - MessageNotUnderstood
		withMessageText: CustomerImporter canNotImportAddressWithoutCustomerErrorDescription

	! !

!CustomerTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test03DoesNotImportRecordsStartingWithCButMoreCharacters

	self
		shouldFailImporting: self invalidCustomerRecordStartData
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!CustomerTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:49:03'!
test04DoesNotImportRecordsStartingWithAButMoreCharacters

	self
		shouldFailImporting: self invalidAddressRecordStartData
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!CustomerTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:49:36'!
test05CanNotImportAddressRecordWithLessThanSixFields

	self
		shouldFailImporting: self addressRecordWithLessThanSixFields
		messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!CustomerTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:51:14'!
test06CanNotImportAddressRecordWithMoreThanSixFields

	self
		shouldFailImporting: self addressRecordWithMoreThanSixFields
		messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!CustomerTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test07CanNotImportCustomerRecordWithLessThanFiveFields

	self
		shouldFailImporting: self customerRecordWithLessThanFiveFields
		messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!CustomerTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test08CanNotImportCustomerRecordWithMoreThanFiveFields

	self
		shouldFailImporting: self customerRecordWithMoreThanFiveFields
		messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!CustomerTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 20:01:43'!
test09CannotImportEmptyLine

	self
		shouldFailImporting: self emptyLine
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !


!CustomerTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!CustomerTest methodsFor: 'assertions' stamp: 'OK 6/28/2024 23:59:26'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := ( system customerSystem) customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!CustomerTest methodsFor: 'assertions' stamp: 'OK 6/28/2024 23:59:26'!
assertImportedOneCustomerWithoutAddress

	| importedCustomer |

	self assert: 1 equals: ( system customerSystem) numberOfCustomers.
	importedCustomer := ( system customerSystem) customerWithIdentificationType: 'D' number: '22333444'.
	self assert: importedCustomer isAddressesEmpty
	! !

!CustomerTest methodsFor: 'assertions' stamp: 'OK 6/28/2024 23:59:26'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: ( system customerSystem) numberOfCustomers! !

!CustomerTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!CustomerTest methodsFor: 'assertions' stamp: 'OK 6/28/2024 23:59:26'!
assertNoCustomerWasImported

	^ self assert: 0 equals: ( system customerSystem) numberOfCustomers! !

!CustomerTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !

!CustomerTest methodsFor: 'assertions' stamp: 'OK 6/29/2024 00:00:45'!
shouldFailImporting: aReadStream messageText: anErrorMessageText asserting: anAssertionBlock

	self
		should: [ CustomerImporter valueFrom: aReadStream into: system. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anErrorMessageText equals: anError messageText.
			anAssertionBlock value ]

	! !


!CustomerTest methodsFor: 'setUp/tearDown' stamp: 'OK 6/28/2024 23:59:34'!
setUp

	system := Environment current createERPSystem.
	system start.
	system beginTransaction.
! !

!CustomerTest methodsFor: 'setUp/tearDown' stamp: 'OK 6/28/2024 23:59:37'!
tearDown

	system commit.
	system stop
	! !


!CustomerTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:41:20'!
addressRecordWithLessThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636'! !

!CustomerTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:51:35'!
addressRecordWithMoreThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,x'! !

!CustomerTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:14:13'!
addressWithoutCustomerData

	^ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !

!CustomerTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:53:41'!
customerRecordWithLessThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D'! !

!CustomerTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:55:59'!
customerRecordWithMoreThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444,x'! !

!CustomerTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 20:02:57'!
emptyLine

	^ReadStream on: '
'! !

!CustomerTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:34:25'!
invalidAddressRecordStartData

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
AA,San Martin,3322,Olivos,1636,BsAs'! !

!CustomerTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:22:55'!
invalidCustomerRecordStartData

	^ReadStream on: 'CC,Pepe,Sanchez,D,22333444'! !

!CustomerTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #SupplierTest category: #CustomerImporter!
TestCase subclass: #SupplierTest
	instanceVariableNames: 'system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!SupplierTest methodsFor: 'assertions' stamp: 'OK 6/28/2024 20:01:20'!
assertAddressOfSupplierWithIDType: aSupplierIDType withIDNumber: aSupplierIDNumber hasStreet: aStreetName withNumber: aStreetNumber inCity: aCityName withCP: aCP inProvince: aProvince      

	self assert: ( self 	isAddressOfSupplierWithIDType: aSupplierIDType withIDNumber: aSupplierIDNumber hasStreet: aStreetName withNumber: aStreetNumber inCity: aCityName withCP: aCP inProvince: aProvince ).    
! !

!SupplierTest methodsFor: 'assertions' stamp: 'OK 6/28/2024 23:55:36'!
assertCustomerOnImportedSupplierCustomers: aSupplierIDType withIDNumber: aSupplierIDNumber withCustomerIDType: aCustomerIDType withCustomerIDNumber: anIDNumber   

	| importedSupplier |

	importedSupplier := system supplierSystem supplierWithIdentificationType:aSupplierIDType number: aSupplierIDNumber.
	self assert: ( importedSupplier hasCustomerWithIDType: aCustomerIDType andIDNumber: anIDNumber )! !

!SupplierTest methodsFor: 'assertions' stamp: 'OK 6/28/2024 23:55:30'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := system customerSystem customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.
! !

!SupplierTest methodsFor: 'assertions' stamp: 'OK 6/28/2024 20:04:02'!
assertMaipuIsSupplier1sAddress

	^ self assertAddressOfSupplierWithIDType: 'D' withIDNumber: '123' hasStreet: 'Maipu' withNumber: 888 inCity: 'Florida' withCP: 1122 inProvince: 'BsAs'! !

!SupplierTest methodsFor: 'assertions' stamp: 'OK 6/28/2024 20:24:01'!
assertOctoKerbsIsSupplier1sCustomer

	^ self assertCustomerOnImportedSupplierCustomers: 'D' withIDNumber: '123' withCustomerIDType: 'D' withCustomerIDNumber: '43802396'! !

!SupplierTest methodsFor: 'assertions' stamp: 'OK 6/28/2024 17:47:34'!
assertPepeSanchezIsSupplier1sCustomer

	^ self assertCustomerOnImportedSupplierCustomers: 'D' withIDNumber: '123' withCustomerIDType: 'D' withCustomerIDNumber: '22333444'! !

!SupplierTest methodsFor: 'assertions' stamp: 'OK 6/28/2024 17:46:56'!
assertPepeSanchezWasImported

	^ self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'! !

!SupplierTest methodsFor: 'assertions' stamp: 'OK 6/28/2024 20:03:55'!
assertSanMartinIsSupplier1sAddress

	^ self assertAddressOfSupplierWithIDType: 'D' withIDNumber: '123' hasStreet: 'San Martin' withNumber: 3322 inCity: 'Olivos' withCP: 1636 inProvince: 'BsAs'! !

!SupplierTest methodsFor: 'assertions' stamp: 'OK 6/28/2024 17:45:55'!
assertSupplier1WasImported

	^ self assertSupplierWithName: 'Supplier1' withIDType: 'D' andIDNumber: '123'! !

!SupplierTest methodsFor: 'assertions' stamp: 'OK 6/28/2024 23:54:36'!
assertSupplierWithName: aName withIDType: anIdentificationType andIDNumber: anIdentificationNumber  

	| importedSupplier |

	importedSupplier := system supplierSystem supplierWithIdentificationType: anIdentificationType number: anIdentificationNumber.
	
	self assert: ( importedSupplier isNamed: aName ).
	self assert: ( importedSupplier hasIDType: anIdentificationType ).
	self assert: ( importedSupplier hasIDNumber: anIdentificationNumber )! !

!SupplierTest methodsFor: 'assertions' stamp: 'OK 6/28/2024 20:01:28'!
denyAddressOfSupplierWithIDType: aSupplierIDType withIDNumber: aSupplierIDNumber hasStreet: aStreetName withNumber: aStreetNumber inCity: aCityName withCP: aCP inProvince: aProvince      

	self deny: ( self 	isAddressOfSupplierWithIDType: aSupplierIDType withIDNumber: aSupplierIDNumber hasStreet: aStreetName withNumber: aStreetNumber inCity: aCityName withCP: aCP inProvince: aProvince ).    
! !

!SupplierTest methodsFor: 'assertions' stamp: 'OK 6/28/2024 20:30:18'!
denySanMartinIsFromSupplier1

	^ self denyAddressOfSupplierWithIDType: 'D' withIDNumber: '123' hasStreet: 'San Martin' withNumber: 3322 inCity: 'Olivos' withCP: 1636 inProvince: 'BsAs'! !

!SupplierTest methodsFor: 'assertions' stamp: 'OK 6/28/2024 23:54:45'!
isAddressOfSupplierWithIDType: aSupplierIDType withIDNumber: aSupplierIDNumber hasStreet: aStreetName withNumber: aStreetNumber inCity: aCityName withCP: aCP inProvince: aProvince      

	| importedSupplier |
	
	importedSupplier := system supplierSystem supplierWithIdentificationType: aSupplierIDType number: aSupplierIDNumber.
	
	^ importedSupplier hasAddressWithStreet: aStreetName withStreetNumber: aStreetNumber ! !


!SupplierTest methodsFor: 'test data' stamp: 'OK 6/28/2024 15:20:19'!
existingCustomerWithSupplier
	
	^ ReadStream on: 
'S,Supplier1,D,123
EC,D,5456774' ! !

!SupplierTest methodsFor: 'test data' stamp: 'OK 6/28/2024 19:12:21'!
invalidAddressFromSupplier

	^ ReadStream on: 
'S,Supplier1,D,123
A,Maipu,888,Florida,1122,BsAs, '! !

!SupplierTest methodsFor: 'test data' stamp: 'OK 6/28/2024 19:18:38'!
invalidFormat

	^ ReadStream on: 
'Supplier1,D,123'! !

!SupplierTest methodsFor: 'test data' stamp: 'OK 6/28/2024 14:36:50'!
newCustomerWithoutSupplier

	^ ReadStream on: 'NC,Pepe,Sanchez,D,22333444'! !

!SupplierTest methodsFor: 'test data' stamp: 'OK 6/28/2024 16:31:57'!
supplierWithNewCustomer

	^ReadStream on:  
'S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444'! !

!SupplierTest methodsFor: 'test data' stamp: 'OK 6/28/2024 17:44:24'!
supplierWithNewCustomerAndExistingCustomer

	^ReadStream on:  
'S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444
EC,D,43802396'! !

!SupplierTest methodsFor: 'test data' stamp: 'OK 6/28/2024 18:21:09'!
validAddressesFromSupplier

	^ ReadStream on: 
'S,Supplier1,D,123
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,BsAs'! !

!SupplierTest methodsFor: 'test data' stamp: 'OK 6/28/2024 17:35:09'!
validCustomer
	
	^ ReadStream on: 'C,Octo,Kerbs,D,43802396' ! !

!SupplierTest methodsFor: 'test data' stamp: 'OK 6/28/2024 14:37:19'!
validSupplier

	^ ReadStream on: 'S,Supplier1,D,123'! !


!SupplierTest methodsFor: 'testing' stamp: 'OK 6/28/2024 20:30:18'!
test01SupplierIsImportedCorrectly
	
	SupplierImporter valueFrom: self validSupplier into: system.
		
	self assertSupplier1WasImported.
	self denySanMartinIsFromSupplier1.! !

!SupplierTest methodsFor: 'testing' stamp: 'OK 6/28/2024 19:20:31'!
test02CanNotAddCustomerToEmptySupplier

	self should: [ SupplierImporter valueFrom: self newCustomerWithoutSupplier into: system. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: SupplierImporter canNotAddCustomerWithoutSupplierErrorDescription.
	
	

	! !

!SupplierTest methodsFor: 'testing' stamp: 'OK 6/28/2024 14:49:03'!
test03CanNotAddNonExistentCustomerToSupplier

	self should: [ SupplierImporter valueFrom: self existingCustomerWithSupplier into: system. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: SupplierImporter customerNotFoundOnCustomerSystemErrorDescription.
	
	

	! !

!SupplierTest methodsFor: 'testing' stamp: 'OK 6/28/2024 17:47:34'!
test04SuppliersNewCustomerIsAddedToCustomerSystem

	SupplierImporter valueFrom: self supplierWithNewCustomer into: system.
	
	self assertSupplier1WasImported.
	self assertPepeSanchezWasImported.
	self assertPepeSanchezIsSupplier1sCustomer.
	! !

!SupplierTest methodsFor: 'testing' stamp: 'OK 6/28/2024 17:47:57'!
test05NewCustomerAndExistingCustomerAreSuppliersCustomers

	CustomerImporter valueFrom: self validCustomer into: system.
	SupplierImporter valueFrom: self supplierWithNewCustomerAndExistingCustomer into: system.
	
	self assertSupplier1WasImported.
	self assertPepeSanchezWasImported.
	self assertPepeSanchezIsSupplier1sCustomer.
	self assertOctoKerbsIsSupplier1sCustomer.! !

!SupplierTest methodsFor: 'testing' stamp: 'OK 6/28/2024 18:36:50'!
test06AddressesAreImportedCorrectly
	
	SupplierImporter valueFrom: self validAddressesFromSupplier into: system.
	self assertSanMartinIsSupplier1sAddress.
	self assertMaipuIsSupplier1sAddress.
	
	! !

!SupplierTest methodsFor: 'testing' stamp: 'OK 6/28/2024 22:08:25'!
test07CanNotImportInvalidAddresses
	
	self should: [ SupplierImporter valueFrom: self invalidAddressFromSupplier into: system ]
		raise: Error - MessageNotUnderstood 
		withMessageText: SupplierImporter invalidAddressRecordErrorDescription.
	! !

!SupplierTest methodsFor: 'testing' stamp: 'OK 6/28/2024 22:08:28'!
test08InvalidRecordFormatShouldRiseError
	
	self should: [ SupplierImporter valueFrom: self invalidFormat into: system ]
		raise: Error - MessageNotUnderstood 
		withMessageText: SupplierImporter invalidRecordTypeErrorDescription.
	! !


!SupplierTest methodsFor: 'setup/teardown' stamp: 'OK 6/28/2024 23:47:26'!
setUp

	system := Environment current createERPSystem.
	
	system start.
	system beginTransaction.
! !

!SupplierTest methodsFor: 'setup/teardown' stamp: 'OK 6/28/2024 13:07:30'!
tearDown

	system commit.
	system stop
	! !


!classDefinition: #Address category: #CustomerImporter!
Object subclass: #Address
	instanceVariableNames: 'streetName streetNumber town zipCode province'
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


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

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


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: #CustomerImporter!
Object subclass: #Customer
	instanceVariableNames: 'firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'OK 6/28/2024 14:24:22'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 19:38:32'!
isAddressesEmpty

	^addresses isEmpty ! !


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


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerImporter category: #CustomerImporter!
Object subclass: #CustomerImporter
	instanceVariableNames: 'newCustomer record line readStream system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'OK 6/28/2024 23:35:20'!
initializeFrom: aReadStream into: anERPSystem

	readStream := aReadStream.
	system := anERPSystem ! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'OK 6/29/2024 00:43:35'!
importAddress

	| newAddress |
	
	self assertCustomerWasImported.
	self assertValidAddressRecord.

	newAddress := Address new.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth.
	
	newCustomer addAddress: newAddress.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'OK 6/29/2024 00:45:01'!
importCustomer
	
	self assertValidCustomerRecord.

	newCustomer := Customer new.
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identificationType: record fourth. 
	newCustomer identificationNumber: record fifth.
	
	system customerSystem add: newCustomer.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'OK 6/28/2024 22:07:09'!
value

	[ self hasLineToImport ] whileTrue: [
		self createRecord.
		self importRecord ].

	! !


!CustomerImporter methodsFor: 'customer' stamp: 'OK 6/29/2024 00:42:03'!
assertCustomerWasImported

	^ newCustomer ifNil: [ self error: self class canNotImportAddressWithoutCustomerErrorDescription ]! !

!CustomerImporter methodsFor: 'customer' stamp: 'OK 6/28/2024 22:05:32'!
assertValidCustomerRecord

	^ record size ~= 5 ifTrue: [ self error: self class invalidCustomerRecordErrorDescription ]! !

!CustomerImporter methodsFor: 'customer' stamp: 'OK 6/28/2024 14:00:15'!
isCustomerRecord

	^ record first = 'C'! !


!CustomerImporter methodsFor: 'address' stamp: 'OK 6/28/2024 22:05:25'!
assertValidAddressRecord

	^ record size ~= 6 ifTrue: [ self error: self class invalidAddressRecordErrorDescription ]! !

!CustomerImporter methodsFor: 'address' stamp: 'OK 6/28/2024 22:07:01'!
isAddressRecord

	^ record first = 'A'! !


!CustomerImporter methodsFor: 'evaluating - private' stamp: 'OK 6/28/2024 22:33:12'!
assertRecordNotEmpty

	record isEmpty ifTrue: [ self error: self class invalidRecordTypeErrorDescription ] ! !

!CustomerImporter methodsFor: 'evaluating - private' stamp: 'OK 6/28/2024 22:05:40'!
createRecord

	^ record := line findTokens: $,! !

!CustomerImporter methodsFor: 'evaluating - private' stamp: 'OK 6/28/2024 22:33:19'!
hasLineToImport

	line := readStream nextLine.
	^line notNil ! !

!CustomerImporter methodsFor: 'evaluating - private' stamp: 'OK 6/29/2024 00:45:26'!
importRecord

	self assertRecordNotEmpty.

	self isCustomerRecord ifTrue: [ ^self importCustomer ].
	self isAddressRecord ifTrue: [ ^self importAddress ].
	
	self error: self class invalidRecordTypeErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: #CustomerImporter!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'OK 6/28/2024 22:07:33'!
from: aReadStream into: aCustomerSystem

	^self new initializeFrom: aReadStream into: aCustomerSystem! !


!CustomerImporter class methodsFor: 'importing' stamp: 'OK 6/28/2024 22:08:00'!
valueFrom: aReadStream into: aCustomerSystem

	^(self from: aReadStream into: aCustomerSystem) value! !


!CustomerImporter class methodsFor: 'error messages' stamp: 'OK 6/28/2024 22:07:23'!
canNotImportAddressWithoutCustomerErrorDescription

	^'Cannot import address without customer'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'OK 6/28/2024 22:07:40'!
invalidAddressRecordErrorDescription

	^'Address record has to have six fields'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'OK 6/28/2024 22:07:46'!
invalidCustomerRecordErrorDescription

	^'Invalid Customer record'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'OK 6/28/2024 22:07:53'!
invalidRecordTypeErrorDescription

	^'Invalid record type'! !


!classDefinition: #CustomerSystem category: #CustomerImporter!
Object subclass: #CustomerSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerSystem methodsFor: 'customers' stamp: 'OK 6/28/2024 22:44:38'!
add: aCustomer

	self subclassResponsibility ! !

!CustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:18:38'!
customerWithIdentificationType: anIdType number: anIdNumber

	self subclassResponsibility ! !

!CustomerSystem methodsFor: 'customers' stamp: 'OK 6/29/2024 00:46:20'!
initialize

	self subclassResponsibility.! !

!CustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:18:51'!
numberOfCustomers

	self subclassResponsibility ! !





!classDefinition: #PersistentCustomerSystem category: #CustomerImporter!
CustomerSystem subclass: #PersistentCustomerSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentCustomerSystem methodsFor: 'customers' stamp: 'OK 6/28/2024 22:44:05'!
add: aCustomer

	^session persist: aCustomer ! !

!PersistentCustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:09:50'!
customerWithIdentificationType: anIdType number: anIdNumber

	^(session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !

!PersistentCustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:08:47'!
numberOfCustomers

	^(session selectAllOfType: Customer) size! !



!PersistentCustomerSystem methodsFor: 'system lifecycle' stamp: 'OK 6/28/2024 23:39:26'!
initialize

	session := DataBaseSession for: (Array with: Address with: Customer).
	! !



!classDefinition: #TransientCustomerSystem category: #CustomerImporter!
CustomerSystem subclass: #TransientCustomerSystem
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientCustomerSystem methodsFor: 'system lifecycle' stamp: 'OK 6/28/2024 23:38:35'!
initialize

	customers := OrderedCollection new.! !



!TransientCustomerSystem methodsFor: 'customers' stamp: 'OK 6/28/2024 22:44:18'!
add: aCustomer

	customers add: aCustomer ! !

!TransientCustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:22:52'!
customerWithIdentificationType: anIdType number: anIdNumber

	^customers detect: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]! !

!TransientCustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:21:43'!
numberOfCustomers

	^customers size! !


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


!DataBaseSession methodsFor: 'persistance' stamp: 'OK 6/28/2024 14:23:25'!
persist: anObject

	| table |

	self assertCanUseDatabase.
	self assertTypeIsPersisted: anObject class.
	self delay.
	
	table := self tableOfType: anObject class.
	self defineIdOf: anObject.
	table addCustomer: anObject.
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


!classDefinition: #ERPSystem category: #CustomerImporter!
Object subclass: #ERPSystem
	instanceVariableNames: 'customerSystem supplierSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ERPSystem methodsFor: 'system lifecycle' stamp: 'OK 6/29/2024 00:03:11'!
customerSystem

	self subclassResponsibility! !

!ERPSystem methodsFor: 'system lifecycle' stamp: 'OK 6/29/2024 00:03:16'!
start

	self subclassResponsibility! !

!ERPSystem methodsFor: 'system lifecycle' stamp: 'OK 6/29/2024 00:03:20'!
stop

	self subclassResponsibility! !

!ERPSystem methodsFor: 'system lifecycle' stamp: 'OK 6/29/2024 00:03:25'!
supplierSystem

	self subclassResponsibility! !


!ERPSystem methodsFor: 'transactions' stamp: 'OK 6/29/2024 00:02:59'!
beginTransaction

	self subclassResponsibility! !

!ERPSystem methodsFor: 'transactions' stamp: 'OK 6/29/2024 00:03:06'!
commit

	self subclassResponsibility! !


!classDefinition: #PersistentERPSystem category: #CustomerImporter!
ERPSystem subclass: #PersistentERPSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentERPSystem methodsFor: 'transactions' stamp: 'OK 6/29/2024 00:02:59'!
beginTransaction

	! !

!PersistentERPSystem methodsFor: 'transactions' stamp: 'OK 6/29/2024 00:03:06'!
commit

	! !


!PersistentERPSystem methodsFor: 'system lifecycle' stamp: 'OK 6/29/2024 00:03:11'!
customerSystem

	^ customerSystem.! !

!PersistentERPSystem methodsFor: 'system lifecycle' stamp: 'OK 6/29/2024 00:38:45'!
start
	
	customerSystem := PersistentCustomerSystem new.
	supplierSystem   := PersistentSupplierSystem new.! !

!PersistentERPSystem methodsFor: 'system lifecycle' stamp: 'OK 6/29/2024 00:03:20'!
stop

	customerSystem := nil.
	supplierSystem := nil.! !

!PersistentERPSystem methodsFor: 'system lifecycle' stamp: 'OK 6/29/2024 00:03:25'!
supplierSystem

	^ supplierSystem.! !


!classDefinition: #TransientERPSystem category: #CustomerImporter!
ERPSystem subclass: #TransientERPSystem
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientERPSystem methodsFor: 'system lifecycle' stamp: 'OK 6/29/2024 00:40:17'!
start
	
	customerSystem := TransientCustomerSystem new.
	supplierSystem   := TransientSupplierSystem new.! !

!TransientERPSystem methodsFor: 'system lifecycle' stamp: 'OK 6/29/2024 00:03:20'!
stop

	customerSystem := nil.
	supplierSystem := nil.! !


!TransientERPSystem methodsFor: 'provide-systems' stamp: 'OK 6/29/2024 00:03:11'!
customerSystem

	^ customerSystem.! !

!TransientERPSystem methodsFor: 'provide-systems' stamp: 'OK 6/29/2024 00:03:25'!
supplierSystem

	^ supplierSystem.! !


!TransientERPSystem methodsFor: 'transactions' stamp: 'OK 6/29/2024 00:02:59'!
beginTransaction

	! !

!TransientERPSystem methodsFor: 'transactions' stamp: 'OK 6/29/2024 00:03:06'!
commit

	! !


!classDefinition: #Environment category: #CustomerImporter!
Object subclass: #Environment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Environment methodsFor: 'customer system' stamp: 'OK 6/28/2024 23:32:30'!
createERPSystem

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Environment class' category: #CustomerImporter!
Environment class
	instanceVariableNames: ''!

!Environment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:37:10'!
current

	^(self subclasses detect: [ :anEnvironmentClass | anEnvironmentClass isCurrent ]) new! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:46'!
environmentKey

	^ #ENV! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:46'!
environmentVariable

	^ Smalltalk at: self environmentKey! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:09'!
identifier

	self subclassResponsibility! !

!Environment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:41:36'!
isCurrent

	self subclassResponsibility ! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:46:01'!
makeCurrent

	"
	Tener en cuenta que en Smalltalk se podría poner directamente la clase de environment,
	esto es DevelopmentEnvironment o IntegrationEnvironmet o hasta una instancia de ellas,
	pero se está simulando el hecho de que esto esté definido por fuera del sistema, como una
	variable del sistema operativo - Hernan"
	
	Smalltalk at: self environmentKey put: self identifier! !


!classDefinition: #DevelopmentEnvironment category: #CustomerImporter!
Environment subclass: #DevelopmentEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DevelopmentEnvironment methodsFor: 'customer system' stamp: 'OK 6/28/2024 23:32:57'!
createERPSystem
	
	^ TransientERPSystem new.! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DevelopmentEnvironment class' category: #CustomerImporter!
DevelopmentEnvironment class
	instanceVariableNames: ''!

!DevelopmentEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:42:50'!
identifier

	^ #DEV! !

!DevelopmentEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:43:52'!
isCurrent

	"
	self makeCurrent
	"
	^self environmentVariable = self identifier! !


!classDefinition: #IntegrationEnvironment category: #CustomerImporter!
Environment subclass: #IntegrationEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!IntegrationEnvironment methodsFor: 'customer system' stamp: 'OK 6/28/2024 23:33:11'!
createERPSystem

	^ PersistentERPSystem new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IntegrationEnvironment class' category: #CustomerImporter!
IntegrationEnvironment class
	instanceVariableNames: ''!

!IntegrationEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:43:07'!
identifier

	^ #INT! !

!IntegrationEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:04'!
isCurrent

	"
	self makeCurrent
	"
	^self environmentVariable = self identifier! !


!classDefinition: #Supplier category: #CustomerImporter!
Object subclass: #Supplier
	instanceVariableNames: 'name iDType iDNumber customers addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Supplier methodsFor: 'initialization' stamp: 'OK 6/28/2024 19:13:12'!
initializeWith: aName andIDType: anIDType andIDNumber: anIDNumber 
	
	name := aName.
	iDType := anIDType.
	iDNumber := anIDNumber.
	customers := OrderedCollection new.
	addresses := OrderedCollection new.! !


!Supplier methodsFor: 'customer' stamp: 'OK 6/28/2024 18:04:05'!
addCustomer: newCustomer 
	
	customers add: newCustomer.! !

!Supplier methodsFor: 'customer' stamp: 'OK 6/28/2024 20:21:02'!
hasCustomerWithIDType: anIDType andIDNumber: anIDNumber

	^ ( customers select: [ :aCustomer | aCustomer identificationType = anIDType and: [ aCustomer identificationNumber = anIDNumber ]] ) isEmpty = false.! !


!Supplier methodsFor: 'testing' stamp: 'OK 6/28/2024 17:31:45'!
hasIDNumber: anIDNumber 
	
	^ iDNumber = anIDNumber.! !

!Supplier methodsFor: 'testing' stamp: 'OK 6/28/2024 17:31:27'!
hasIDType: anIDType

	^ iDType = anIDType. 
	
	! !

!Supplier methodsFor: 'testing' stamp: 'OK 6/28/2024 17:31:34'!
isNamed: aName 
	
	^ name = aName.! !


!Supplier methodsFor: 'address' stamp: 'OK 6/28/2024 19:12:43'!
addAddress: newAddress 
	
	addresses add: newAddress.! !

!Supplier methodsFor: 'address' stamp: 'OK 6/28/2024 20:26:39'!
hasAddressWithStreet: aStreetName withStreetNumber: aNumber    
	
	^ ( addresses select: [ :anAddress | ( anAddress isAt: aStreetName ) and: ( anAddress streetNumber = aNumber)]) isEmpty = false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Supplier class' category: #CustomerImporter!
Supplier class
	instanceVariableNames: ''!

!Supplier class methodsFor: 'as yet unclassified' stamp: 'OK 6/28/2024 13:23:56'!
named: aName withIDType: anIDType withIDNumber: anIDNumber 
	
	^ self new initializeWith: aName andIDType: anIDType andIDNumber: anIDNumber.
	! !


!classDefinition: #SupplierImporter category: #CustomerImporter!
Object subclass: #SupplierImporter
	instanceVariableNames: 'newSupplier record line readStream system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!SupplierImporter methodsFor: 'supplier' stamp: 'OK 6/28/2024 14:17:57'!
isSupplierRecord
	
	^ record first = 'S'! !


!SupplierImporter methodsFor: 'assertions' stamp: 'OK 6/28/2024 22:32:28'!
assertRecordNotEmpty

	record isEmpty ifTrue: [ self error: self class invalidRecordTypeErrorDescription ]! !

!SupplierImporter methodsFor: 'assertions' stamp: 'OK 6/28/2024 14:16:54'!
assertSupplierWasImported

	^ newSupplier ifNil: [ self error: self class canNotAddCustomerWithoutSupplierErrorDescription ]! !

!SupplierImporter methodsFor: 'assertions' stamp: 'OK 6/28/2024 22:05:25'!
assertValidAddressRecord

	^ record size ~= 6 ifTrue: [ self error: self class invalidAddressRecordErrorDescription ]! !

!SupplierImporter methodsFor: 'assertions' stamp: 'OK 6/28/2024 22:05:32'!
assertValidCustomerRecord

	^ record size ~= 5 ifTrue: [ self error: self class invalidCustomerRecordErrorDescription ]! !

!SupplierImporter methodsFor: 'assertions' stamp: 'OK 6/28/2024 14:32:08'!
assertValidSupplierRecord

	^ record size ~= 4 ifTrue: [ self error: self class invalidSupplierRecordErrorDescription ].! !


!SupplierImporter methodsFor: 'address' stamp: 'OK 6/28/2024 22:07:02'!
isAddressRecord

	^ record first = 'A'! !


!SupplierImporter methodsFor: 'record' stamp: 'OK 6/28/2024 22:32:33'!
createRecord

	^ record := line findTokens: $, ! !

!SupplierImporter methodsFor: 'record' stamp: 'OK 6/28/2024 22:32:36'!
hasLineToImport

	line := readStream nextLine.
	^line notNil ! !


!SupplierImporter methodsFor: 'customer' stamp: 'OK 6/28/2024 14:10:09'!
isExistingCustomerRecord
	
	^ record first = 'EC'! !

!SupplierImporter methodsFor: 'customer' stamp: 'OK 6/28/2024 14:01:33'!
isNewCustomerRecord
	
	^ record first = 'NC'! !


!SupplierImporter methodsFor: 'evaluating' stamp: 'OK 6/29/2024 00:48:55'!
importAddress

	| newAddress |
	
	self assertSupplierWasImported.
	self assertValidAddressRecord.

	newAddress := Address new.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth.
	
	newSupplier addAddress: newAddress.! !

!SupplierImporter methodsFor: 'evaluating' stamp: 'OK 6/29/2024 00:54:14'!
importCustomer

	| newCustomer |
	
	self assertSupplierWasImported.
	self assertValidCustomerRecord.

	newCustomer := Customer new.
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identificationType: record fourth.
	newCustomer identificationNumber: record fifth. 
	
	system customerSystem add: newCustomer.
	
	newSupplier addCustomer: newCustomer.! !

!SupplierImporter methodsFor: 'evaluating' stamp: 'OK 6/28/2024 23:56:36'!
importExistingCustomer
	
	| existingCustomer |
	self assertSupplierWasImported.
	
	[ existingCustomer := system customerSystem customerWithIdentificationType: record second number: record third ] on: Error 
	do: [self error: self class customerNotFoundOnCustomerSystemErrorDescription].
	
	newSupplier addCustomer: existingCustomer.! !

!SupplierImporter methodsFor: 'evaluating' stamp: 'OK 6/29/2024 00:55:01'!
importRecord

	self assertRecordNotEmpty.
	
	self isSupplierRecord ifTrue: [ ^self importSupplier ].
	self isNewCustomerRecord ifTrue: [ ^self importCustomer ].
	self isExistingCustomerRecord ifTrue: [ ^self importExistingCustomer ].
	self isAddressRecord ifTrue: [ ^self importAddress ].
	
	self error: self class invalidRecordTypeErrorDescription.! !

!SupplierImporter methodsFor: 'evaluating' stamp: 'OK 6/28/2024 23:47:49'!
importSupplier
	
	self assertValidSupplierRecord.

	newSupplier := Supplier 
		named: record second 
		withIDType: record third 
		withIDNumber: record fourth.
	
	system supplierSystem add: newSupplier.! !

!SupplierImporter methodsFor: 'evaluating' stamp: 'OK 6/28/2024 22:07:09'!
value

	[ self hasLineToImport ] whileTrue: [
		self createRecord.
		self importRecord ].

	! !


!SupplierImporter methodsFor: 'initialization' stamp: 'OK 6/28/2024 22:06:54'!
initializeFrom: aReadStream into: aCustomerSystem

	readStream := aReadStream.
	system := aCustomerSystem ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SupplierImporter class' category: #CustomerImporter!
SupplierImporter class
	instanceVariableNames: ''!

!SupplierImporter class methodsFor: 'as yet unclassified' stamp: 'OK 6/28/2024 14:16:26'!
canNotAddCustomerWithoutSupplierErrorDescription
	
	^ 'Can not add customer without the supplier'.! !

!SupplierImporter class methodsFor: 'as yet unclassified' stamp: 'OK 6/28/2024 14:49:51'!
customerNotFoundOnCustomerSystemErrorDescription
	
	^ 'The customer can not be found on customer system :('! !

!SupplierImporter class methodsFor: 'as yet unclassified' stamp: 'OK 6/28/2024 18:43:13'!
invalidAddressFormatErrorDescription
	
	^'Address format is invalid!!'.! !


!SupplierImporter class methodsFor: 'error messages' stamp: 'OK 6/28/2024 22:07:23'!
canNotImportAddressWithoutCustomerErrorDescription

	^'Cannot import address without customer'! !

!SupplierImporter class methodsFor: 'error messages' stamp: 'OK 6/28/2024 22:07:40'!
invalidAddressRecordErrorDescription

	^'Address record has to have six fields'! !

!SupplierImporter class methodsFor: 'error messages' stamp: 'OK 6/28/2024 22:07:46'!
invalidCustomerRecordErrorDescription

	^'Invalid Customer record'! !

!SupplierImporter class methodsFor: 'error messages' stamp: 'OK 6/28/2024 22:07:53'!
invalidRecordTypeErrorDescription

	^'Invalid record type'! !


!SupplierImporter class methodsFor: 'instance creation' stamp: 'OK 6/28/2024 22:07:33'!
from: aReadStream into: aCustomerSystem

	^self new initializeFrom: aReadStream into: aCustomerSystem! !


!SupplierImporter class methodsFor: 'importing' stamp: 'OK 6/28/2024 22:08:00'!
valueFrom: aReadStream into: aCustomerSystem

	^(self from: aReadStream into: aCustomerSystem) value! !


!classDefinition: #SupplierSystem category: #CustomerImporter!
Object subclass: #SupplierSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!SupplierSystem methodsFor: 'customers' stamp: 'OK 6/28/2024 22:41:05'!
add: aSupplier

	self subclassResponsibility! !




!SupplierSystem methodsFor: 'suppliers' stamp: 'OK 6/28/2024 23:49:05'!
initialize! !

!SupplierSystem methodsFor: 'suppliers' stamp: 'OK 6/28/2024 22:39:41'!
supplierWithIdentificationType: anIDType number: anIDNumber

	self subclassResponsibility! !


!classDefinition: #PersistentSupplierSystem category: #CustomerImporter!
SupplierSystem subclass: #PersistentSupplierSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!



!PersistentSupplierSystem methodsFor: 'suppliers' stamp: 'OK 6/28/2024 22:41:05'!
add: aSupplier

	^ session persist: aSupplier ! !

!PersistentSupplierSystem methodsFor: 'suppliers' stamp: 'OK 6/28/2024 23:48:52'!
initialize! !

!PersistentSupplierSystem methodsFor: 'suppliers' stamp: 'OK 6/28/2024 22:39:54'!
supplierWithIdentificationType: anIDType number: anIDNumber 
	
	^ Supplier named: 'Supplier1' withIDType: 'D' withIDNumber: '123'.! !


!classDefinition: #TransientSupplierSystem category: #CustomerImporter!
SupplierSystem subclass: #TransientSupplierSystem
	instanceVariableNames: 'suppliers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientSupplierSystem methodsFor: 'system lifecycle' stamp: 'OK 6/28/2024 23:48:12'!
initialize

	suppliers  := OrderedCollection new.! !



!TransientSupplierSystem methodsFor: 'suppliers' stamp: 'OK 6/28/2024 22:41:05'!
add: aSupplier

	suppliers add: aSupplier ! !

!TransientSupplierSystem methodsFor: 'suppliers' stamp: 'OK 6/28/2024 22:40:17'!
supplierWithIdentificationType: anIDType number: anIDNumber 
	
	^ suppliers detect: [ :aSupplier | ( aSupplier hasIDType: anIDType ) and: [ aSupplier hasIDNumber: anIDNumber ]]! !
