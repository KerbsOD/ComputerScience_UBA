!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'OK 5/16/2024 21:26:15'!
test01EmptyPortfolioHasABalanceOfZero

	|portfolio|
	
	portfolio := Portfolio new.
		
	self assert: portfolio balance = 0.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'OK 5/16/2024 21:26:15'!
test02PortfolioWith1AccountHasThatAccountBalance
	
	|portfolio account1|
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1.
	
	portfolio addAccount: account1.
		
	self assert: 100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'OK 5/16/2024 21:26:15'!
test03PortfolioWith2AccountsHaveSumOfBothBalances
	
	|portfolio account1 account2|
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1.
	
	Deposit register: 200 on: account2.
	
	portfolio addAccount: account1.
	portfolio addAccount: account2.
		
	self assert: 300 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'OK 5/16/2024 21:26:15'!
test04PortfolioWithoutAccountsDoesNotKnowTransactions
	
	|portfolio deposit|
	
	portfolio := Portfolio new.
	
	deposit := Deposit for: 200.
		
	self deny: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'OK 5/16/2024 21:26:15'!
test05PortfolioWithAccountKnowsAboutItsTransactions
	
	|portfolio account1 deposit|
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account1.
	
	portfolio addAccount: account1.
		
	self assert: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'OK 5/16/2024 21:26:15'!
test06PortfolioWith2AccountsKnowsAllTransactions
	
	|portfolio account1 account2 deposit1 withdraw1 deposit2 transactions portfolioTransactions|
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	withdraw1 := Withdraw register: 150 on: account2.
	
	portfolio addAccount: account1.
	portfolio addAccount: account2.
		
	transactions := OrderedCollection	 with: deposit1  with: deposit2 with: withdraw1.
	portfolioTransactions := portfolio transactions.
		
	self assert: portfolioTransactions = transactions .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'OK 5/16/2024 21:26:15'!
test07AddEmptyPortfolioToEmptyPortfolio
	
	|portfolio1 portfolio2 portfolios|
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	portfolio1 addPortfolio: portfolio2.
	
	portfolios := OrderedCollection with: portfolio2.
	
	self assert: (portfolio1 hasPortfolios: portfolios).! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'OK 5/16/2024 21:25:47'!
modifyBalance: aBalance
	^ aBalance + value.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'OK 5/16/2024 21:25:37'!
modifyBalance: aBalance
	^ aBalance - value.! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Accounts category: #'Portfolio-Ejercicio'!
Object subclass: #Accounts
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Accounts subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialize' stamp: 'OK 5/16/2024 12:00:09'!
initialize
	accounts := OrderedCollection new.
	portfolios := OrderedCollection new.! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'OK 5/16/2024 14:40:02'!
addAccount: anAccount
	accounts add: anAccount.
	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'OK 5/16/2024 21:33:02'!
balance
	^ accounts sum: [:account | account balance].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'OK 5/16/2024 21:32:04'!
hasRegistered: aTransaction

	accounts do: [:account | (account hasRegistered: aTransaction) ifTrue: [^true]].
	
	^false.
	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'OK 5/16/2024 21:31:08'!
transactions
	
	|allTransactions|
	
	allTransactions := OrderedCollection new.
	
	accounts do: [:account | allTransactions := allTransactions,(account transactions)].
	
	^allTransactions.! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Accounts subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'OK 5/16/2024 21:37:45'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'OK 5/16/2024 21:37:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'OK 5/16/2024 21:36:57'!
balance
	
	|balance|
	
	balance := 0.
	
	transactions do: [:aTransaction | balance := aTransaction modifyBalance: balance]. 
	
	^balance.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


