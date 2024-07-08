!classDefinition: #EnteroSubclassTest category: #'Numero-Exercise'!
TestCase subclass: #EnteroSubclassTest
	instanceVariableNames: 'zero one two three four five six seven eight nine ten negativeOne negativeTwo negativeThree oneHalf oneFifth twoFifth twoTwentyfifth fiveHalfs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroSubclassTest methodsFor: 'setUp' stamp: 'Ok 4/18/2024 07:38:27'!
setUp
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	negativeThree := Entero with: -3.
	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	
	
	
	! !


!EnteroSubclassTest methodsFor: 'tests' stamp: 'Ok 4/18/2024 05:19:50'!
test01IntegersMatchesTheirSubtype
	self assert: (negativeOne isKindOf: Negativo).
	self assert: (negativeTwo isKindOf: Negativo).
	self assert: (zero isKindOf: Cero).
	self assert: (one isKindOf: Uno).
	self assert: (two isKindOf: PositivoDistintoDeUno ).
	self assert: (three isKindOf: PositivoDistintoDeUno ).
	self assert: (four isKindOf: PositivoDistintoDeUno ).
	self assert: (five isKindOf: PositivoDistintoDeUno ).
	self assert: (eight isKindOf: PositivoDistintoDeUno ).! !

!EnteroSubclassTest methodsFor: 'tests' stamp: 'Ok 4/18/2024 06:52:27'!
test02FractionsMatchesTheirSubtype
	self assert: (oneHalf isKindOf: Fraccion).
	self assert: (oneFifth isKindOf: Fraccion).
	self assert: (twoFifth isKindOf: Fraccion).
	self assert: (twoTwentyfifth isKindOf: Fraccion).
	self assert: (fiveHalfs isKindOf: Fraccion).
! !

!EnteroSubclassTest methodsFor: 'tests' stamp: 'Ok 4/18/2024 07:19:18'!
test03NegativeOneTimesZeroEqualsZero
	self assert: (negativeOne *zero isKindOf: Cero).
	self assert: (zero*negativeOne isKindOf: Cero).! !

!EnteroSubclassTest methodsFor: 'tests' stamp: 'Ok 4/18/2024 07:18:50'!
test04ZeroTimesZeroEqualsZero
	self assert: (zero*zero isKindOf: Cero).
	! !

!EnteroSubclassTest methodsFor: 'tests' stamp: 'Ok 4/18/2024 07:18:31'!
test05OneTimesZeroEqualsZero
	self assert: (one *zero isKindOf: Cero).
	self assert: (zero*one isKindOf: Cero).
	! !

!EnteroSubclassTest methodsFor: 'tests' stamp: 'Ok 4/18/2024 07:18:02'!
test06FiveTimesZeroEqualsZero
	self assert: (five*zero isKindOf: Cero ).
	self assert: (zero*five isKindOf: Cero ).! !

!EnteroSubclassTest methodsFor: 'tests' stamp: 'Ok 4/18/2024 07:17:28'!
test07twoFifthTimesZeroEqualsZero
	self assert: (twoFifth *zero isKindOf: Cero).
	self assert: (zero*twoFifth isKindOf: Cero).
	! !

!EnteroSubclassTest methodsFor: 'tests' stamp: 'Ok 4/18/2024 07:25:19'!
test08ZeroPlusNegativeTwoEqualsNegativeTwo
	self assert: (negativeTwo+zero isKindOf: Negativo).
	self assert: (zero+negativeTwo isKindOf: Negativo).
	
	self assert: negativeTwo+zero = negativeTwo.
	self assert: zero+negativeTwo = negativeTwo.! !

!EnteroSubclassTest methodsFor: 'tests' stamp: 'Ok 4/18/2024 07:22:41'!
test09ZeroPlusZeroEqualsZero
	self assert: (zero+zero isKindOf: Cero).
	self assert: zero+zero = zero.! !

!EnteroSubclassTest methodsFor: 'tests' stamp: 'Ok 4/18/2024 07:24:01'!
test10ZeroPlusOneEqualsOne
	self assert: (zero+one isKindOf: Uno).
	self assert: (one+zero isKindOf: Uno).
	
	self assert: zero+one = one.
	self assert: one+zero = one.! !

!EnteroSubclassTest methodsFor: 'tests' stamp: 'Ok 4/18/2024 07:27:59'!
test11ZeroPlusTwoEqualsTwo
	self assert: (two+zero isKindOf: PositivoDistintoDeUno).
	self assert: (zero+two isKindOf: PositivoDistintoDeUno).
	
	self assert: zero+two = two.
	self assert: two+zero = two.! !

!EnteroSubclassTest methodsFor: 'tests' stamp: 'Ok 4/18/2024 07:29:08'!
test12NegativeOnePlusOneEqualsZero
	self assert: (negativeOne +one isKindOf: Cero).
	self assert: (one+negativeOne isKindOf: Cero).
	
	self assert: negativeOne +one = zero.
	self assert: negativeOne +one = zero.! !

!EnteroSubclassTest methodsFor: 'tests' stamp: 'Ok 4/18/2024 07:38:45'!
test13NegativeTwoPlusNegativeOneEqualsNegativeThree
	self assert: (negativeTwo +negativeOne isKindOf: Negativo).
	self assert: (negativeOne +negativeTwo isKindOf: Negativo).
	
	self assert: negativeTwo +negativeOne = negativeThree .
	self assert: negativeOne +negativeTwo = negativeThree .! !

!EnteroSubclassTest methodsFor: 'tests' stamp: 'Ok 4/18/2024 07:40:55'!
test14NegativeTwoPlusThreeEqualsOne
	self assert: (negativeTwo + three isKindOf: Uno).
	self assert: (three +negativeTwo isKindOf: Uno).
	
	self assert: negativeTwo +three = one .
	self assert: three +negativeTwo = one .! !

!EnteroSubclassTest methodsFor: 'tests' stamp: 'Ok 4/18/2024 10:17:34'!
test15OneTimeTwoFifthEqualsTwoFifth
	self assert: (one * twoFifth isKindOf: Fraccion).
	self assert: (twoFifth * one isKindOf: Fraccion).
	
	self assert: one * twoFifth = twoFifth .
	self assert: twoFifth * one = twoFifth .! !


!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!
!NumeroTest commentStamp: '<historical>' prior: 0!
one + oneFifth!


!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'Ok 4/18/2024 19:38:25'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)
	
	" 1 + 1/5"! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !


!Numero methodsFor: 'nueva?' stamp: 'Ok 4/18/2024 20:09:44'!
m! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 09:37:28'!
* aMultiplier 
	self subclassResponsibility 
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 09:37:33'!
+ anAdder 
	self subclassResponsibility ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 09:37:38'!
- aSubtrahend 
	self subclassResponsibility ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 09:37:42'!
/ aDivisor 
	self subclassResponsibility 
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 09:37:46'!
// aDivisor 	
	self subclassResponsibility ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 09:37:51'!
fibonacci

	self subclassResponsibility 
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 09:37:55'!
greatestCommonDivisorWith: anEntero 
	
	self subclassResponsibility ! !


!Entero methodsFor: 'comparing' stamp: 'Ok 4/18/2024 09:38:01'!
= anObject
	self subclassResponsibility ! !

!Entero methodsFor: 'comparing' stamp: 'Ok 4/18/2024 09:38:06'!
hash
	self subclassResponsibility ! !


!Entero methodsFor: 'initialization' stamp: 'Ok 4/18/2024 03:12:31'!
initalizeWith: aValue 
	self subclassResponsibility ! !


!Entero methodsFor: 'value' stamp: 'Ok 4/18/2024 09:38:27'!
integerValue
	self subclassResponsibility ! !


!Entero methodsFor: 'printing' stamp: 'Ok 4/18/2024 09:38:34'!
printOn: aStream
	self subclassResponsibility ! !


!Entero methodsFor: 'testing' stamp: 'Ok 4/18/2024 09:38:42'!
isNegative
	self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'Ok 4/18/2024 09:38:46'!
isOne
	
	self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'Ok 4/18/2024 09:38:50'!
isZero
	
	self subclassResponsibility ! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'Ok 4/18/2024 03:28:12'!
with: aValue 
	
	|integerObject|
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	(aValue < 0) ifTrue: [integerObject := Negativo with: aValue].
	(aValue = 0) ifTrue: [integerObject := Cero new].
	(aValue = 1) ifTrue: [integerObject := Uno new].
	(aValue > 1) ifTrue: [integerObject := PositivoDistintoDeUno with: aValue].
	
	^integerObject.
	
	! !


!Entero class methodsFor: 'as yet unclassified' stamp: 'Ok 4/18/2024 10:01:57'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !


!classDefinition: #Cero category: #'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 03:44:28'!
* aMultiplier 
	^self.
	! !

!Cero methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 03:46:24'!
+ anAdder 
	^anAdder.! !

!Cero methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 03:51:30'!
- aSubtrahend 
	^aSubtrahend negated.! !

!Cero methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 03:46:38'!
/ aDivisor 
	^self.
! !

!Cero methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 03:46:47'!
// aDivisor 	
	^self.! !

!Cero methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 03:50:32'!
fibonacci
	^​ Entero with: 1.
	
		! !

!Cero methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 04:30:24'!
greatestCommonDivisorWith: anEntero 
	^Entero with: (0 gcd: anEntero integerValue)! !


!Cero methodsFor: 'value' stamp: 'Ok 4/18/2024 04:30:35'!
integerValue
	^0! !


!Cero methodsFor: 'printing' stamp: 'Ok 4/18/2024 04:30:51'!
printOn: aStream
	aStream print: 0 ! !


!Cero methodsFor: 'comparing' stamp: 'Ok 4/18/2024 03:47:22'!
= anObject
	^ anObject isKindOf: Cero.! !

!Cero methodsFor: 'comparing' stamp: 'Ok 4/18/2024 04:30:28'!
hash
	^0 hash! !


!Cero methodsFor: 'arithmetic operations - private' stamp: 'Ok 4/18/2024 07:14:16'!
addToCero: anInteger
	^ self.! !

!Cero methodsFor: 'arithmetic operations - private' stamp: 'Ok 4/18/2024 07:14:10'!
addToFraccion: aFraccion
	^ aFraccion .! !

!Cero methodsFor: 'arithmetic operations - private' stamp: 'Ok 4/18/2024 07:14:27'!
addToNegativo: aNegativo
	^ aNegativo .! !

!Cero methodsFor: 'arithmetic operations - private' stamp: 'Ok 4/18/2024 07:14:36'!
addToPositivoDistintoDeUno: aPositivo
	^ aPositivo .! !

!Cero methodsFor: 'arithmetic operations - private' stamp: 'Ok 4/18/2024 07:14:57'!
addToUno: anInteger
	^ Uno new.! !

!Cero methodsFor: 'arithmetic operations - private' stamp: 'Ok 4/18/2024 09:14:58'!
divideToCero: anInteger
	self error: Numero canNotDivideByZeroErrorDescription.! !

!Cero methodsFor: 'arithmetic operations - private' stamp: 'Ok 4/18/2024 09:14:53'!
divideToFraccion: anInteger
	self error: Numero canNotDivideByZeroErrorDescription.! !

!Cero methodsFor: 'arithmetic operations - private' stamp: 'Ok 4/18/2024 09:14:49'!
divideToNegativo: anInteger
	self error: Numero canNotDivideByZeroErrorDescription.! !

!Cero methodsFor: 'arithmetic operations - private' stamp: 'Ok 4/18/2024 09:14:45'!
divideToPositivosDistintosDeCeroYUno: anInteger
	self error: Numero canNotDivideByZeroErrorDescription.! !

!Cero methodsFor: 'arithmetic operations - private' stamp: 'Ok 4/18/2024 09:12:38'!
divideToUno: anInteger
	self error: Numero canNotDivideByZeroErrorDescription.! !

!Cero methodsFor: 'arithmetic operations - private' stamp: 'Ok 4/18/2024 05:22:36'!
multiplyToCero: anInteger
	^ self .! !

!Cero methodsFor: 'arithmetic operations - private' stamp: 'Ok 4/18/2024 05:27:18'!
multiplyToFraccion: anInteger
	^ self .! !

!Cero methodsFor: 'arithmetic operations - private' stamp: 'Ok 4/18/2024 05:22:54'!
multiplyToNegativo: anInteger
	^ self .! !

!Cero methodsFor: 'arithmetic operations - private' stamp: 'Ok 4/18/2024 07:03:37'!
multiplyToPositivoDistintoDeUno: anInteger
	^ self.! !

!Cero methodsFor: 'arithmetic operations - private' stamp: 'Ok 4/18/2024 05:23:01'!
multiplyToUno: anInteger
	^ self .! !


!Cero methodsFor: 'testing' stamp: 'Ok 4/18/2024 04:30:40'!
isNegative
	^false! !

!Cero methodsFor: 'testing' stamp: 'Ok 4/18/2024 04:30:44'!
isOne
	^false! !

!Cero methodsFor: 'testing' stamp: 'Ok 4/18/2024 04:30:47'!
isZero
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: #'Numero-Exercise'!
Cero class
	instanceVariableNames: ''!

!Cero class methodsFor: 'as yet unclassified' stamp: 'Ok 4/18/2024 05:53:45'!
dividingANumberByZero
	^ ' No se puede dividir por cero pedazo de troglodita!!!!!!'! !


!classDefinition: #Negativo category: #'Numero-Exercise'!
Entero subclass: #Negativo
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Negativo methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 04:14:05'!
* aMultiplier 
	^aMultiplier multiplyToNegativo: self.
	! !

!Negativo methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 04:14:11'!
+ anAdder 
	^anAdder addToNegativo: self.! !

!Negativo methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 04:14:20'!
- aSubtrahend 
	^aSubtrahend substractToNegativo: self.! !

!Negativo methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 04:14:26'!
/ aDivisor 
	^aDivisor divideToNegativo: self.
! !

!Negativo methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 04:14:32'!
// aDivisor 	
	^aDivisor wholeDivideToNegativo: self.! !

!Negativo methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 04:16:44'!
fibonacci
	self error: Negativo negativeFibonacciErrorDescription
		! !

!Negativo methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 01:37:08'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !


!Negativo methodsFor: 'comparing' stamp: 'Ok 4/18/2024 04:14:39'!
= anObject
	^ anObject compareToNegativo: self.! !

!Negativo methodsFor: 'comparing' stamp: 'Ok 4/18/2024 01:37:12'!
hash

	^value hash! !


!Negativo methodsFor: 'initialization' stamp: 'Ok 4/18/2024 03:30:57'!
initializeWith: aValue 
	
	value := aValue! !


!Negativo methodsFor: 'printing' stamp: 'Ok 4/18/2024 01:37:54'!
printOn: aStream

	aStream print: value ! !


!Negativo methodsFor: 'testing' stamp: 'Ok 4/18/2024 04:13:23'!
isNegative
	
	^true! !

!Negativo methodsFor: 'testing' stamp: 'Ok 4/18/2024 04:13:18'!
isOne
	
	^false! !

!Negativo methodsFor: 'testing' stamp: 'Ok 4/18/2024 04:13:28'!
isZero
	
	^false! !


!Negativo methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 08:47:10'!
addToCero: aZero
	^ self.! !

!Negativo methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 05:00:47'!
addToFraccion: aFraccion
	^ self * aFraccion denominator + aFraccion numerator  / aFraccion denominator .! !

!Negativo methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 08:46:44'!
addToNegativo: anInteger
	^ Negativo with: value + anInteger integerValue.! !

!Negativo methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 08:46:34'!
addToPositivoDistintoDeUno: aPositivo
	^ Entero with: value + aPositivo integerValue.! !

!Negativo methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 07:31:32'!
addToUno: aOne
	^ Entero with: value + 1.! !

!Negativo methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 01:36:49'!
compareToFraccion: aFraccion
	^false! !

!Negativo methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 04:09:42'!
compareToNegativo: anEntero
	^ value = anEntero integerValue! !

!Negativo methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 01:36:57'!
divideToFraccion: aFraccion
	^ aFraccion numerator / (aFraccion denominator * (self class with: value)).
	! !

!Negativo methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 09:30:21'!
divideToNegativo: anInteger
	^ Fraccion with: anInteger negated over: self negated.! !

!Negativo methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 09:37:00'!
divideToUno: aOne
	^ Fraccion with: (Negativo with: -1) over: self negated .! !

!Negativo methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 01:37:21'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !

!Negativo methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 05:50:20'!
multiplyToCero: anInteger
	^ Cero new.! !

!Negativo methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 05:05:16'!
multiplyToFraccion: aFraccion
	^ (self class with: value) * aFraccion numerator  / aFraccion denominator .! !

!Negativo methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 05:28:22'!
multiplyToNegativo: anInteger
	^ PositivoDistintoDeUno with: value * anInteger integerValue .! !

!Negativo methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 06:24:52'!
multiplyToPositivoDistintoDeUno: anInteger
	^ self class with: value * anInteger integerValue.! !

!Negativo methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 05:23:57'!
multiplyToUno: anInteger
	^ self.! !

!Negativo methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 01:38:02'!
substractToFraccion: aFraccion
	^aFraccion + self negated.! !

!Negativo methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 05:06:45'!
substractToNegativo: anEntero
	^ Entero with: (anEntero integerValue - value).! !

!Negativo methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 05:07:21'!
wholeDivideToNegativo: anInteger
	^ Entero with: (anInteger integerValue) // value.
! !

!Negativo methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 09:21:19'!
wholeDivideToPositivoDistintoDeUno: anInteger
	^ Entero with: (anInteger integerValue) // value.
! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Negativo class' category: #'Numero-Exercise'!
Negativo class
	instanceVariableNames: ''!

!Negativo class methodsFor: 'as yet unclassified' stamp: 'Ok 4/18/2024 05:52:56'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Negativo class methodsFor: 'as yet unclassified' stamp: 'Ok 4/18/2024 03:30:13'!
with: aValue
	^self new initializeWith: aValue.! !


!classDefinition: #PositivoDistintoDeUno category: #'Numero-Exercise'!
Entero subclass: #PositivoDistintoDeUno
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!PositivoDistintoDeUno methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 04:21:58'!
* aMultiplier 
	^aMultiplier multiplyToPositivoDistintoDeUno: self.
	! !

!PositivoDistintoDeUno methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 04:22:07'!
+ anAdder 
	^anAdder addToPositivoDistintoDeUno: self.! !

!PositivoDistintoDeUno methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 04:22:18'!
- aSubtrahend 
	^aSubtrahend substractToPositivoDistintoDeUno: self.! !

!PositivoDistintoDeUno methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 04:22:24'!
/ aDivisor 
	^aDivisor divideToPositivoDistintoDeUno: self.
! !

!PositivoDistintoDeUno methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 04:22:30'!
// aDivisor 	
	^aDivisor wholeDivideToPositivoDistintoDeUno: self.! !

!PositivoDistintoDeUno methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 04:24:25'!
fibonacci
	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci
		! !

!PositivoDistintoDeUno methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 01:39:58'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !


!PositivoDistintoDeUno methodsFor: 'comparing' stamp: 'Ok 4/18/2024 04:22:36'!
= anObject
	^ anObject compareToPositivoDistintoDeUno: self.! !

!PositivoDistintoDeUno methodsFor: 'comparing' stamp: 'Ok 4/18/2024 01:40:02'!
hash

	^value hash! !


!PositivoDistintoDeUno methodsFor: 'initialization' stamp: 'Ok 4/18/2024 03:31:12'!
initializeWith: aValue 
	value := aValue! !


!PositivoDistintoDeUno methodsFor: 'printing' stamp: 'Ok 4/18/2024 01:40:51'!
printOn: aStream

	aStream print: value ! !


!PositivoDistintoDeUno methodsFor: 'testing' stamp: 'Ok 4/18/2024 04:29:05'!
isNegative
	
	^false! !

!PositivoDistintoDeUno methodsFor: 'testing' stamp: 'Ok 4/18/2024 04:28:55'!
isOne
	
	^false! !

!PositivoDistintoDeUno methodsFor: 'testing' stamp: 'Ok 4/18/2024 04:29:00'!
isZero
	
	^false! !


!PositivoDistintoDeUno methodsFor: 'value' stamp: 'Ok 4/18/2024 01:40:20'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!PositivoDistintoDeUno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 05:14:13'!
addToFraccion: aFraccion
	^  aFraccion numerator  + self * aFraccion denominator / aFraccion denominator .! !

!PositivoDistintoDeUno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 08:44:48'!
addToNegativo: anInteger
	^ Entero with: value + anInteger integerValue.! !

!PositivoDistintoDeUno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 04:20:01'!
addToPositivoDistintoDeUno: anInteger
	^ self class with: value + anInteger integerValue.! !

!PositivoDistintoDeUno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 07:46:24'!
addToUno: anInteger
	^ self class with: value + 1.! !

!PositivoDistintoDeUno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 07:46:07'!
addToZero: anInteger
	^ self.! !

!PositivoDistintoDeUno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 01:39:39'!
compareToFraccion: aFraccion
	^false! !

!PositivoDistintoDeUno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 04:20:23'!
compareToPositivoDistintoDeUno: anEntero
	^ value = anEntero integerValue! !

!PositivoDistintoDeUno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 05:50:53'!
divideToCero: aCero
	^ Cero new.
	! !

!PositivoDistintoDeUno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 01:39:47'!
divideToFraccion: aFraccion
	^ aFraccion numerator / (aFraccion denominator * (self class with: value)).
	! !

!PositivoDistintoDeUno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 05:42:34'!
divideToNegativo: aNegativeNumber
	^ Fraccion with: aNegativeNumber over: self.! !

!PositivoDistintoDeUno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 05:16:17'!
divideToPositivoDistintoDeUno: anInteger
	^ Fraccion with: anInteger over: self.! !

!PositivoDistintoDeUno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 05:51:01'!
divideToUno: aOne
	^ Fraccion with: Uno new over: self
	! !

!PositivoDistintoDeUno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 05:51:19'!
multiplyToCero: anInteger
	^ Cero new.! !

!PositivoDistintoDeUno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 01:40:47'!
multiplyToFraccion: aFraccion
	^ (self class with: value) * aFraccion numerator  / aFraccion denominator .! !

!PositivoDistintoDeUno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 05:29:27'!
multiplyToNegativo: anInteger
	^ Negativo with: value * anInteger integerValue .! !

!PositivoDistintoDeUno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 04:20:42'!
multiplyToPositivoDistintoDeUno: anInteger
	^ self class with: value * anInteger integerValue .! !

!PositivoDistintoDeUno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 05:24:20'!
multiplyToUno: anInteger
	^ self.! !

!PositivoDistintoDeUno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 01:41:08'!
substractToFraccion: aFraccion
	^aFraccion + self negated.! !

!PositivoDistintoDeUno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 05:18:00'!
substractToPositivoDistintoDeUno: anEntero
	^ Entero with: (anEntero integerValue - value).! !

!PositivoDistintoDeUno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 08:58:48'!
wholeDivideToPositivoDistintoDeUno: anInteger
	^ Entero with: (anInteger integerValue) // value.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PositivoDistintoDeUno class' category: #'Numero-Exercise'!
PositivoDistintoDeUno class
	instanceVariableNames: ''!

!PositivoDistintoDeUno class methodsFor: 'as yet unclassified' stamp: 'Ok 4/18/2024 03:27:47'!
with: aValue
	^self new initializeWith: aValue! !


!classDefinition: #Uno category: #'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 04:25:18'!
* aMultiplier 
	^aMultiplier.
	! !

!Uno methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 04:46:08'!
+ anAdder 
	^anAdder addToUno: self.! !

!Uno methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 04:46:18'!
- aSubtrahend 
	^aSubtrahend substractToUno: self.! !

!Uno methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 04:46:23'!
/ aDivisor 
	^aDivisor divideToUno: self.
! !

!Uno methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 04:46:28'!
// aDivisor 	
	^aDivisor wholeDivideToUno: self.! !

!Uno methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 04:54:04'!
fibonacci
	^​ self.
	! !

!Uno methodsFor: 'arithmetic operations' stamp: 'Ok 4/18/2024 04:28:13'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (1 gcd: anEntero integerValue)! !


!Uno methodsFor: 'comparing' stamp: 'Ok 4/18/2024 04:26:19'!
= anObject
	^ anObject isKindOf: Uno.! !

!Uno methodsFor: 'comparing' stamp: 'Ok 4/18/2024 04:28:30'!
hash

	^1 hash! !


!Uno methodsFor: 'printing' stamp: 'Ok 4/18/2024 04:30:57'!
printOn: aStream

	aStream print: 1 ! !


!Uno methodsFor: 'testing' stamp: 'Ok 4/18/2024 04:28:38'!
isNegative
	
	^false! !

!Uno methodsFor: 'testing' stamp: 'Ok 4/18/2024 04:28:42'!
isOne
	
	^true! !

!Uno methodsFor: 'testing' stamp: 'Ok 4/18/2024 04:28:48'!
isZero
	
	^false! !


!Uno methodsFor: 'value' stamp: 'Ok 4/18/2024 04:28:33'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^1! !


!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 04:33:56'!
addToFraccion: aFraccion
	^ aFraccion denominator + aFraccion numerator  / aFraccion denominator .! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 07:30:51'!
addToNegativo: aNegativo
	^ Entero with: (1 + aNegativo integerValue).! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 09:03:51'!
addToPositivoDistintoDeUno: aPositivo
	^ Entero with: (1 + aPositivo integerValue).! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 04:41:14'!
addToUno: anInteger
	^ Entero with: 2.! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 01:42:59'!
compareToFraccion: aFraccion
	^false! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 04:41:32'!
compareToUno: anEntero
	^ true! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 06:23:33'!
divideToCero: anInteger
	^ anInteger.
! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 04:35:49'!
divideToFraccion: aFraccion
	^ aFraccion numerator / (aFraccion denominator).
	! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 06:23:52'!
divideToNegativo: anInteger
	^ anInteger.
! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 06:24:11'!
divideToPositivoDistintoDeUno: anInteger
	^ anInteger.
! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 04:53:49'!
divideToUno: anInteger
	^ self.! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 05:49:29'!
multiplyToCero: anInteger
	^ Cero new.! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 04:54:31'!
multiplyToFraccion: aFraccion
	^ aFraccion numerator  / aFraccion denominator .! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 05:30:03'!
multiplyToNegativo: anInteger
	^ anInteger.! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 05:29:57'!
multiplyToPositivo: anInteger
	^ anInteger.! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 07:04:01'!
multiplyToPositivoDistintoDeUno: anInteger
	^ anInteger.! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 05:24:41'!
multiplyToUno: anInteger
	^ self.! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 01:43:56'!
substractToFraccion: aFraccion
	^aFraccion + self negated.! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 09:16:22'!
substractToPositivoDistintoDeUno: aPositivo
	^aPositivo + self negated.! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 05:49:45'!
substractToUno: anEntero
	^ Cero new.! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 06:21:54'!
wholeDivideToCero: anInteger
	^ anInteger.
! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 06:21:58'!
wholeDivideToFraccion: anInteger
	^ anInteger.
! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 06:21:39'!
wholeDivideToNegativo: anInteger
	^ anInteger.
! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 06:21:26'!
wholeDivideToPositivoDistintoDeUno: anInteger
	^ anInteger.
! !

!Uno methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 04:57:32'!
wholeDivideToUno: anInteger
	^ self.
! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Ok 4/17/2024 06:35:05'!
* aMultiplier 
	^aMultiplier multiplyToFraccion: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Ok 4/17/2024 04:23:38'!
+ anAdder 	
	^ anAdder addToFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Ok 4/17/2024 05:04:53'!
- aSubtrahend 
	^ aSubtrahend substractToFraccion: self.
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Ok 4/17/2024 07:02:01'!
/ aDivisor 
	^ aDivisor divideToFraccion: self.! !


!Fraccion methodsFor: 'comparing' stamp: 'Ok 4/17/2024 07:23:14'!
= anObject
	^ anObject compareToFraccion: self.! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'Ok 4/18/2024 16:56:07'!
initializeWith: aNumerator over: aDenominator
	numerator := aNumerator.
	denominator := aDenominator. 
	
	
	! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !



!Fraccion methodsFor: 'arithmetic interface' stamp: 'Ok 4/17/2024 05:27:35'!
addToEntero: anInteger
	^ anInteger * denominator + numerator / denominator .
	! !

!Fraccion methodsFor: 'arithmetic interface' stamp: 'Ok 4/17/2024 04:23:38'!
addToFraccion: aFraccion
	|newNumerator newDenominator|
	
	newNumerator := (numerator * aFraccion denominator) + (denominator * aFraccion numerator).
	newDenominator := denominator * aFraccion denominator.
	
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 09:03:01'!
addToUno: aOne
		^  denominator +  numerator  /  denominator .
	! !

!Fraccion methodsFor: 'arithmetic interface' stamp: 'Ok 4/17/2024 07:20:56'!
compareToEntero: anEntero
	^ false! !

!Fraccion methodsFor: 'arithmetic interface' stamp: 'Ok 4/17/2024 07:22:37'!
compareToFraccion: aFraccion
	^(numerator * aFraccion denominator) = (denominator * aFraccion numerator).! !

!Fraccion methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 09:32:47'!
compareToNegativo: aNegativo
	^ false! !

!Fraccion methodsFor: 'arithmetic interface' stamp: 'Ok 4/17/2024 07:55:20'!
divideToEntero: anInteger
	^ anInteger * denominator / numerator .! !

!Fraccion methodsFor: 'arithmetic interface' stamp: 'Ok 4/17/2024 07:55:26'!
divideToFraccion: aFraccion
	^ aFraccion numerator  * denominator / aFraccion denominator * numerator.! !

!Fraccion methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 09:08:21'!
divideToUno: aOne
	^ denominator / numerator .! !

!Fraccion methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 10:15:45'!
multiplyToCero: anInteger
	^ Cero new.
	! !

!Fraccion methodsFor: 'arithmetic interface' stamp: 'Ok 4/17/2024 06:40:17'!
multiplyToFraccion: aFraccion
	^ (aFraccion numerator * numerator)  / (aFraccion denominator * denominator) .
	! !

!Fraccion methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 05:31:39'!
multiplyToNegativo: anInteger
	^ anInteger * numerator / denominator.
	! !

!Fraccion methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 09:06:31'!
multiplyToPositivoDistintoDeUno: anInteger
	^ anInteger * numerator / denominator.
	! !

!Fraccion methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 10:15:55'!
multiplyToUno: anInteger
	^ Uno new.
	! !

!Fraccion methodsFor: 'arithmetic interface' stamp: 'Ok 4/17/2024 05:25:55'!
substractToFraccion: aFraccion
	^ aFraccion + ( numerator negated / denominator ).! !

!Fraccion methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 09:23:50'!
substractToPositivoDistintoDeUno: anInteger
	^ anInteger + ( numerator negated / denominator )! !

!Fraccion methodsFor: 'arithmetic interface' stamp: 'Ok 4/18/2024 09:27:17'!
substractToUno: aOne
	^  denominator - numerator / denominator ! !

!Fraccion methodsFor: 'arithmetic interface' stamp: 'Ok 4/17/2024 07:54:01'!
wholeDivideToEntero: anInteger
	^ Entero with: (anInteger * denominator) / numerator.! !


!Fraccion methodsFor: 'nuevaaaa' stamp: 'Ok 4/18/2024 20:09:10'!
m! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'Ok 4/25/2024 09:46:07'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	
	"buscar donde se implementa with over. La idea es que en Entero, cuando dividis, invertis el mensaje. SI el denominador es 0 devolver error. Y lo mismo con otros pasos"
	! !
