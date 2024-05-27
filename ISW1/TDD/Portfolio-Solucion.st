!classDefinition: #PortfolioTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 12:44:47'!
test00EmptyReceptiveAccountDisplaysZeroBalance
	
	| accountA summary| 
	
	accountA := ReceptiveAccount new.
	
	summary := AccountSummary of: accountA.
	
	self assert: summary = (OrderedCollection with: 'Balance = 0').! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 12:47:13'!
test01DepositOnReceptiveAccountDisplaysCorrectly
	
	| accountA summary| 
	
	accountA := ReceptiveAccount new.
	
	Deposit register: 100 on: accountA.
	
	summary := AccountSummary of: accountA.
	
	self assert: summary = (OrderedCollection with: 'Deposito por 100.' with: 'Balance = 100').! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 12:47:09'!
test02ExtractionOnReceptiveAccountDisplaysCorrectly
	
	| accountA summary| 
	
	accountA := ReceptiveAccount new.
	
	Deposit register: 100 on: accountA.
	Withdraw register: 50 on: accountA.
	
	summary := AccountSummary of: accountA.
	
	self assert: summary = (OrderedCollection with: 'Deposito por 100.' with: 'Extraccion por 50.' with: 'Balance = 50').! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 12:46:54'!
test03WithdrawTransferOnReceptiveAccountDisplaysCorrectly
	
	| accountA accountB summaryA summaryB| 
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	
	Deposit register: 100 on: accountA.
	Withdraw register: 50 on: accountA.
	
	WireTransfer from: accountA to: accountB byAmount: 20.
	
	summaryA := AccountSummary of: accountA.
	summaryB := AccountSummary of: accountB.
	
	self assert: summaryA = (OrderedCollection with: 'Deposito por 100.' with: 'Extraccion por 50.' with: 'Salida por transferencia de 20.' with: 'Balance = 30').
	self assert: summaryB = (OrderedCollection with: 'Entrada por transferencia de 20.' with: 'Balance = 20').! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 12:48:11'!
test04DepositTransferOnReceptiveAccountDisplaysCorrectly
	
	| accountA accountB summaryA summaryB| 
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	
	Deposit register: 100 on: accountA.
	Withdraw register: 50 on: accountA.
	
	WireTransfer from: accountA to: accountB byAmount: 20.
	WireTransfer from: accountB to: accountA byAmount: 30.
	
	summaryA := AccountSummary of: accountA.
	summaryB := AccountSummary of: accountB.
	
	self assert: summaryA = (OrderedCollection with: 'Deposito por 100.' with: 'Extraccion por 50.' with: 'Salida por transferencia de 20.' with: 'Entrada por transferencia de 30.' with: 'Balance = 60').
	self assert: summaryB = (OrderedCollection with: 'Entrada por transferencia de 20.' with: 'Salida por transferencia de 30.' with: 'Balance = -10').
	
	
	
	! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 07:35:02'!
test05TransferNetOnReceptiveAccountDisplaysCorrectly
	
	| accountA accountB | 
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	
	Deposit register: 100 on: accountA.
	Withdraw register: 50 on: accountA.
	
	WireTransfer from: accountA to: accountB byAmount: 20.
	WireTransfer from: accountB to: accountA byAmount: 30.
	
	self assert: (TransferNet of: accountA) = 10.
	self assert: (TransferNet of: accountB) = -10.
	
	
	
	! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 11:53:33'!
test06TransferNetOnPortfolioAccountDisplaysCorrectly
	
	| accountA accountB portfolio | 
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	
	portfolio := Portfolio new.
	
	Deposit register: 100 on: accountA.
	Withdraw register: 50 on: accountA.
	
	WireTransfer from: accountA to: accountB byAmount: 20.
	WireTransfer from: accountB to: (ReceptiveAccount new) byAmount: 30.
	
	portfolio add: accountA.
	portfolio add: accountB.
	
	self assert: (TransferNet of: portfolio) = -30.
	
	
	
	
	! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 12:48:35'!
test07EmptyPortfolioTree
	
	| portfolioFamilia treeStructure |
	
	portfolioFamilia := Portfolio named: 'Portfolio de la familia.'.
	
	treeStructure := PortfolioStructure of: portfolioFamilia.
	
	self assert: treeStructure = (OrderedCollection with: 'Portfolio de la familia.').
	
	 
	
	
	
	
	
	
	! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 12:48:49'!
test08PortfolioTreeWithOneAccount
	
	| familyPortfolio myAccount treeStructure |
	
	myAccount := ReceptiveAccount named: 'Cuenta mia.'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia.' with: myAccount.
	
	
	treeStructure := PortfolioStructure of: familyPortfolio.
	
	self assert: treeStructure = (OrderedCollection with: 'Portfolio de la familia.' with: 'Cuenta mia.').
	
	 
	
	
	
	
	
	
	! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 13:01:16'!
test09PortfolioTreeWithWholeFamily
	
	| familyPortfolio myAccount treeStructure johnsAccount angiesAccount childrenPortfolio|
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan.'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles.'.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos.' with: johnsAccount with: angiesAccount.
	myAccount := ReceptiveAccount named: 'Cuenta Mia.'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia.' with: myAccount with: childrenPortfolio.
	
	treeStructure := PortfolioStructure of: familyPortfolio.
	
	self assert: treeStructure = (OrderedCollection with:'Portfolio de la familia.' with: 'Cuenta Mia.' with: 'Portfolio de hijos.' with: 'Cuenta de Juan.' with: 'Cuenta de Angeles.').
	
	 
	
	
	
	
	
	
	! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 13:02:06'!
test10EmptyPortfolioHasBalanceOfZero
	
	| familyPortfolio treeStructure |
	
	familyPortfolio := Portfolio named: 'Portfolio de la familia.'.
	
	treeStructure := PortfolioTransactions of: familyPortfolio.
	
	self assert: treeStructure = (OrderedCollection with: 'Portfolio de la familia.' with: 'Balance = 0').
	
	 
	
	
	
	
	
	
	! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 13:02:11'!
test11PortfolioWithEmptyAccountDisplaysAccountName
	
	| familyPortfolio myAccount treeStructure |
	
	myAccount := ReceptiveAccount named: 'Cuenta Mia.'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia.' with: myAccount.
	
	treeStructure := PortfolioTransactions of: familyPortfolio.
	
	self assert: treeStructure = (OrderedCollection with: 'Portfolio de la familia.' with: 'Cuenta Mia.' with: 'Balance = 0' with: 'Balance = 0')
	
	 
	
	
	
	
	
	
	! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 13:02:16'!
test12PortfolioWithAccountDisplaysAccountSummary
	
	| familyPortfolio myAccount treeStructure |
	
	myAccount := ReceptiveAccount named: 'Cuenta Mia.'.
	
	Deposit register: 100 on: myAccount.
	Withdraw register: 50 on: myAccount.
	
	familyPortfolio := Portfolio named: 'Portfolio de la familia.' with: myAccount.
	
	treeStructure := PortfolioTransactions of: familyPortfolio.
	
	self assert: treeStructure = (OrderedCollection with: 'Portfolio de la familia.' with: 'Cuenta Mia.' with: 'Deposito por 100.' with: 'Extraccion por 50.' with: 'Balance = 50' with: 'Balance = 50').
	
	 
	
	
	
	
	
	
	! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 13:02:22'!
test13PortfolioWithAnotherPortfolioDisplaysAccountsSummar
	
	| johnsAccount angiesAccount childrenPortfolio myAccount familyPortfolio treeStructure expected|
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan.'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles.'.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos.' with: johnsAccount with: angiesAccount.
	
	myAccount := ReceptiveAccount named: 'Cuenta Mia.'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia.' with: myAccount with: childrenPortfolio.
	
	Deposit register: 100 on: myAccount.
	Withdraw register: 50 on: myAccount.
	
	Deposit register: 200 on: johnsAccount.
	Withdraw register: 70 on: johnsAccount.
	
	WireTransfer from: angiesAccount to: (ReceptiveAccount new) byAmount: 20.
	
	treeStructure := PortfolioTransactions of: familyPortfolio.
	
	expected := OrderedCollection new.
	expected add: 'Portfolio de la familia.'.
	expected add: 'Cuenta Mia.'.
	expected add: 'Deposito por 100.'.
	expected add:  'Extraccion por 50.'.
	expected add: 'Balance = 50'.
	expected add: 'Portfolio de hijos.'.
	expected add: 'Cuenta de Juan.'.
	expected add: 'Deposito por 200.'.
	expected add: 'Extraccion por 70.'.
	expected add: 'Balance = 130'.
	expected add: 'Cuenta de Angeles.'.
	expected add: 'Salida por transferencia de 20.'.
	expected add: 'Balance = -20'.
	expected add: 'Balance = 110'.
	expected add: 'Balance = 160'.
	
	self assert: treeStructure equals: expected.
	
	
	 
	
	
	
	
	
	
	! !


!classDefinition: #WireTransferTest category: #'Portfolio-Solucion'!
TestCase subclass: #WireTransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WireTransferTest methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 10:24:34'!
test01TransferingAffectsAccountsBalancesCorrectly

	|accountA accountB|
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	
	Deposit register: 200 on: accountA.
	Deposit register: 100 on: accountB.
	
	WireTransfer from: accountA to: accountB byAmount: 100.
	
	self assert: accountA balance = 100.
	self assert: accountB balance = 200.! !

!WireTransferTest methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 10:25:16'!
test02CanNotTransferNegativeAmountOfMoney

	|accountA accountB|
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	
	self
		should: [WireTransfer from: accountA to: accountB byAmount: -100]
		raise: Error 
		withExceptionDo: [:anError |
			self assert: WireTransfer negativeAmountOfMoneyInTransferErrorDescription equals: anError messageText
		].
		 
	
	! !

!WireTransferTest methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 10:25:34'!
test03CanNotTransferToItself

	|accountA |
	
	accountA := ReceptiveAccount new.
	
	self
		should: [WireTransfer from: accountA to: accountA byAmount: 100]
		raise: Error 
		withExceptionDo: [:anError |
			self assert: WireTransfer transferingToItselfErrorDescription equals: anError messageText
		].
		 
	
	! !

!WireTransferTest methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 10:26:29'!
test04BothAccountsHaveRegisteredTheTransfer

	| accountA accountB wireTransfer anotherWireTransfer|
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	
	wireTransfer := WireTransfer from: accountA to: accountB byAmount: 100.
	anotherWireTransfer := WireTransfer from: ( ReceptiveAccount new ) to: ( ReceptiveAccount new ) byAmount: 100.
	
	self assert: ( wireTransfer sourceLegIsRegisteredOn: accountA andDestinationLegIsRegisteredOn: accountB ).
	self deny:   ( anotherWireTransfer sourceLegIsRegisteredOn: accountA andDestinationLegIsRegisteredOn: accountB ).
	! !

!WireTransferTest methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 10:38:40'!
test05CanNavigateFromSourceLegToTransferToDestinationLegAndInReverse

	| accountA accountB wireTransfer |
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	
	wireTransfer := WireTransfer from: accountA to: accountB byAmount: 100.
	
	self assert: ( wireTransfer withdrawLegGetTransfer = wireTransfer ).
	self assert: ( wireTransfer depositLegGetTransfer = wireTransfer ).
	! !


!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'OK 5/27/2024 09:28:53'!
name

	^name.! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: #'Portfolio-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 08:14:35'!
named: aName

	^self new initializeWith: aName.! !


!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'OK 5/27/2024 07:22:34'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'OK 5/27/2024 07:21:55'!
initializeWith: aName

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := aName.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'report' stamp: 'OK 5/27/2024 12:06:33'!
doReportOverAccountsWith: aReporter 

	accounts do: [ :anAccount | anAccount doReportWith: aReporter ].! !

!Portfolio methodsFor: 'report' stamp: 'OK 5/27/2024 11:42:06'!
doReportWith: aReporter 
	
	aReporter doReportForPortfolio: self.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 07:47:32'!
named: aName with: anAccount

	^(self new initializeWith: aName) 
		add: anAccount; 
		yourself.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 07:47:27'!
named: aName with: anAccount with: anotherAccount

	^(self new initializeWith: aName) 
		add: anAccount;
		add: anotherAccount;
		yourself.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'OK 5/27/2024 07:24:36'!
initializeWith: aName

	transactions := OrderedCollection new.
	name := aName.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'report' stamp: 'OK 5/27/2024 12:06:13'!
doReportOverTransactionsWith: aReporter
	
	transactions do: [ :aTransaction | aTransaction doReportWith: aReporter ].
	
! !

!ReceptiveAccount methodsFor: 'report' stamp: 'OK 5/27/2024 11:41:13'!
doReportWith: aReporter

	aReporter doReportForReceptiveAccount: self.

	
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'OK 5/26/2024 19:51:56'!
doReportWith: aReporter

	aReporter doReportForDeposit: value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'OK 5/26/2024 19:51:51'!
doReportWith: aReporter

	aReporter doReportForWithdraw: value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: #'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 20:43:27'!
doReportForDeposit: anAmountOfMoney
	
	self subclassResponsibility ! !

!Report methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 20:43:43'!
doReportForDepositLeg: anAmountOfMoney
	
	self subclassResponsibility ! !

!Report methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 08:08:13'!
doReportForPortfolio: aPortfolioName
	
	self subclassResponsibility ! !

!Report methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 08:08:17'!
doReportForReceptiveAccount: aReceptiveAccountName
	
	self subclassResponsibility ! !

!Report methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 20:43:33'!
doReportForWithdraw: anAmountOfMoney
	
	self subclassResponsibility ! !

!Report methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 20:43:38'!
doReportForWithdrawLeg: anAmountOfMoney
	
	self subclassResponsibility ! !

!Report methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 08:09:41'!
initializeFor: anAccount 
	
	self subclassResponsibility ! !

!Report methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 20:44:11'!
report
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: #'Portfolio-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 07:37:19'!
of: anAccount 
	
	^self new initializeFor: anAccount. ! !


!classDefinition: #AccountSummary category: #'Portfolio-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: 'account summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'private - report' stamp: 'OK 5/27/2024 12:34:27'!
report

	account doReportWith: self.
	^summary.! !


!AccountSummary methodsFor: 'initialization' stamp: 'OK 5/27/2024 12:59:28'!
doReportForDeposit: anAmountOfMoney
	
	summary add: 'Deposito por ', anAmountOfMoney asString, '.'.! !

!AccountSummary methodsFor: 'initialization' stamp: 'OK 5/27/2024 12:59:23'!
doReportForDepositLeg: anAmountOfMoney

	summary add: 'Entrada por transferencia de ', anAmountOfMoney asString, '.'.! !

!AccountSummary methodsFor: 'initialization' stamp: 'OK 5/27/2024 09:30:39'!
doReportForPortfolio: aPortfolio
	! !

!AccountSummary methodsFor: 'initialization' stamp: 'OK 5/27/2024 12:59:13'!
doReportForReceptiveAccount: aReceptiveAccount
	
	aReceptiveAccount doReportOverTransactionsWith: self.
	summary add: 'Balance = ',(account balance asString).! !

!AccountSummary methodsFor: 'initialization' stamp: 'OK 5/27/2024 12:59:06'!
doReportForWithdraw: anAmountOfMoney

	summary add: 'Extraccion por ', anAmountOfMoney asString, '.'.! !

!AccountSummary methodsFor: 'initialization' stamp: 'OK 5/27/2024 12:58:57'!
doReportForWithdrawLeg: anAmountOfMoney

	summary add: 'Salida por transferencia de ',anAmountOfMoney asString, '.'.! !

!AccountSummary methodsFor: 'initialization' stamp: 'OK 5/27/2024 12:58:40'!
initializeFor: anAccount 
	
	account := anAccount.
	summary := OrderedCollection new.
	
	^self report.! !


!classDefinition: #PortfolioStructure category: #'Portfolio-Solucion'!
Report subclass: #PortfolioStructure
	instanceVariableNames: 'tree account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioStructure methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 08:08:37'!
doReportForDeposit: anAmountOfMoney! !

!PortfolioStructure methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 08:08:50'!
doReportForDepositLeg: anAmountOfMoney! !

!PortfolioStructure methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 13:00:46'!
doReportForPortfolio: aPortfolio
	
	tree add: aPortfolio name.
	aPortfolio doReportOverAccountsWith: self.! !

!PortfolioStructure methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 13:00:37'!
doReportForReceptiveAccount: aReceptiveAccount
	
	tree add: aReceptiveAccount name
! !

!PortfolioStructure methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 08:09:06'!
doReportForWithdraw: anAmountOfMoney! !

!PortfolioStructure methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 08:09:19'!
doReportForWithdrawLeg: anAmountOfMoney! !

!PortfolioStructure methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 13:00:21'!
initializeFor: anAccount 
	
	account := anAccount.
	tree := OrderedCollection new.
	
	^ self report	
! !

!PortfolioStructure methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 12:07:53'!
report
	
	account doReportWith: self.
	^ tree.
	! !


!classDefinition: #PortfolioTransactions category: #'Portfolio-Solucion'!
Report subclass: #PortfolioTransactions
	instanceVariableNames: 'accountDetails account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTransactions methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 09:48:50'!
doReportForDeposit: anAmountOfMoney

	! !

!PortfolioTransactions methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 09:48:55'!
doReportForDepositLeg: anAmountOfMoney

	! !

!PortfolioTransactions methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 13:03:43'!
doReportForPortfolio: aPortfolio
	
	accountDetails add: aPortfolio name.
	aPortfolio doReportOverAccountsWith: self.
	accountDetails add: 'Balance = ',(aPortfolio balance) asString.! !

!PortfolioTransactions methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 13:07:10'!
doReportForReceptiveAccount: aReceptiveAccount

	accountDetails add: aReceptiveAccount name.
	accountDetails := accountDetails,(AccountSummary of: aReceptiveAccount)! !

!PortfolioTransactions methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 09:49:00'!
doReportForWithdraw: anAmountOfMoney

! !

!PortfolioTransactions methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 09:49:04'!
doReportForWithdrawLeg: anAmountOfMoney

	! !

!PortfolioTransactions methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 13:02:54'!
initializeFor: anAccount 

	account := anAccount.
	accountDetails := OrderedCollection new.
	
	^ self report	
! !

!PortfolioTransactions methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 12:09:23'!
report
	
	account doReportWith: self.
	
	^ accountDetails.! !


!classDefinition: #TransferNet category: #'Portfolio-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: 'account transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 20:22:17'!
doReportForDeposit: anAmountOfMoney
	! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 20:22:33'!
doReportForDepositLeg: anAmountOfMoney

	transferNet := transferNet + anAmountOfMoney.! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 12:06:33'!
doReportForPortfolio: aPortfolio

	aPortfolio doReportOverAccountsWith: self.! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 12:06:13'!
doReportForReceptiveAccount: aReceptiveAccount
	
	aReceptiveAccount doReportOverTransactionsWith: self.! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 20:13:52'!
doReportForWithdraw: anAmountOfMoney! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 20:22:42'!
doReportForWithdrawLeg: anAmountOfMoney

	transferNet := transferNet - anAmountOfMoney.! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'OK 5/27/2024 07:36:51'!
initializeFor: anAccount 
	
	account := anAccount.
	transferNet := 0.
	
	^ self report.
! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 20:24:45'!
report
	
	account doReportWith: self.
	^ transferNet.! !


!classDefinition: #WireTransfer category: #'Portfolio-Solucion'!
Object subclass: #WireTransfer
	instanceVariableNames: 'value sourceLeg destinationLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WireTransfer methodsFor: 'testing' stamp: 'OK 5/26/2024 10:33:51'!
depositLegGetTransfer
	
	^ destinationLeg getTransfer.! !

!WireTransfer methodsFor: 'testing' stamp: 'OK 5/26/2024 10:34:01'!
withdrawLegGetTransfer
	
	^ destinationLeg getTransfer.! !


!WireTransfer methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 16:39:08'!
initializeFor: aSourceLeg and: aDestinationLeg byAmount: anAmountOfMoney
	
	sourceLeg := aSourceLeg.
	destinationLeg := aDestinationLeg.
	value := anAmountOfMoney.
	! !

!WireTransfer methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 10:17:32'!
initializeFor: aSourceAccount transferingTo: aDestinationAccount byAmount: anAmountOfMoney
	
	sourceLeg := WithdrawLeg for: self onAccount: aSourceAccount.
	destinationLeg := DepositLeg for: self onAccount: aDestinationAccount.
	value := anAmountOfMoney.
	! !

!WireTransfer methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 09:59:19'!
sourceLegIsRegisteredOn: accountA andDestinationLegIsRegisteredOn: accountB
	
	^ ( accountA hasRegistered: sourceLeg ) and: ( accountB hasRegistered: destinationLeg )! !

!WireTransfer methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 10:22:23'!
value

	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WireTransfer class' category: #'Portfolio-Solucion'!
WireTransfer class
	instanceVariableNames: ''!

!WireTransfer class methodsFor: 'instance creation' stamp: 'OK 5/26/2024 09:36:09'!
assertAmountOfMoneyIsPositive: anAmountOfMoney
	
	( anAmountOfMoney >= 0 ) ifFalse: [ self signalNegativeAmountOfMoneyInTransfer ].! !

!WireTransfer class methodsFor: 'instance creation' stamp: 'OK 5/26/2024 09:42:09'!
assertTransferingFrom: aSourceAccount isDifferentFrom: aDestinationAccount
	
	( aSourceAccount = aDestinationAccount ) ifTrue: [ self signalTransferingToItself ].! !

!WireTransfer class methodsFor: 'instance creation' stamp: 'OK 5/26/2024 16:40:56'!
from: aSourceAccount to: aDestinationAccount byAmount: anAmountOfMoney 

	self assertAmountOfMoneyIsPositive: anAmountOfMoney.
	self assertTransferingFrom: aSourceAccount isDifferentFrom: aDestinationAccount.
	
	^ self new initializeFor: aSourceAccount transferingTo: aDestinationAccount byAmount: anAmountOfMoney.! !

!WireTransfer class methodsFor: 'instance creation' stamp: 'OK 5/26/2024 09:33:02'!
negativeAmountOfMoneyInTransferErrorDescription
	^ 'Can not transfer a negative amount of money!!'.! !

!WireTransfer class methodsFor: 'instance creation' stamp: 'OK 5/26/2024 09:34:40'!
signalNegativeAmountOfMoneyInTransfer
	self error: self negativeAmountOfMoneyInTransferErrorDescription.! !

!WireTransfer class methodsFor: 'instance creation' stamp: 'OK 5/26/2024 09:40:25'!
signalTransferingToItself
	self error: self transferingToItselfErrorDescription.! !

!WireTransfer class methodsFor: 'instance creation' stamp: 'OK 5/26/2024 09:39:59'!
transferingToItselfErrorDescription
	^ 'The destination account can not be the source account!!'! !


!classDefinition: #WireTransferLeg category: #'Portfolio-Solucion'!
Object subclass: #WireTransferLeg
	instanceVariableNames: 'transfer account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WireTransferLeg methodsFor: 'testing' stamp: 'OK 5/26/2024 10:34:33'!
getTransfer
	
	^ transfer! !


!WireTransferLeg methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 10:43:30'!
affectBalance: currentBalance 
	
	self subclassResponsibility.! !

!WireTransferLeg methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 10:19:19'!
initializeFor: aWireTransfer onAccount: aReceptiveAccount
	
	transfer := aWireTransfer.
	account := aReceptiveAccount.
	
	aReceptiveAccount register: self.! !

!WireTransferLeg methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 19:50:43'!
value
	
	^ transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WireTransferLeg class' category: #'Portfolio-Solucion'!
WireTransferLeg class
	instanceVariableNames: ''!

!WireTransferLeg class methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 10:13:54'!
for: aWireTransfer onAccount: aReceptiveAccount
	
	^self new initializeFor: aWireTransfer onAccount: aReceptiveAccount.! !


!classDefinition: #DepositLeg category: #'Portfolio-Solucion'!
WireTransferLeg subclass: #DepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DepositLeg methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 10:22:10'!
affectBalance: currentBalance 
	^ currentBalance + transfer value.! !

!DepositLeg methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 19:49:28'!
doReportWith: aReporter

	aReporter doReportForDepositLeg: self value.! !


!classDefinition: #WithdrawLeg category: #'Portfolio-Solucion'!
WireTransferLeg subclass: #WithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WithdrawLeg methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 10:21:58'!
affectBalance: currentBalance 
	^ currentBalance - transfer value.! !

!WithdrawLeg methodsFor: 'as yet unclassified' stamp: 'OK 5/26/2024 19:50:18'!
doReportWith: aReporter

	aReporter doReportForWithdrawLeg: self value.! !
