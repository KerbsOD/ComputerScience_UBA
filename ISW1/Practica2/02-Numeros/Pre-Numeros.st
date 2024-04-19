!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo negativeOneHalf'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:08:06'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:48'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:55'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:04'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:25'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'Ok 4/13/2024 17:32:45'!
test07FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := Fraccion with: (Entero with: 7) over: (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:11:26'!
test08FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'Ok 4/13/2024 17:33:01'!
test09AparentFraccionesAreEqual

	self assert: oneHalf equals: (Fraccion with: two over: four)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:12:46'!
test10AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:26:23'!
test11MultiplyingFraccionesCanReturnAnEntero

	self assert: (twoFifth) * (fiveHalfs) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:21'!
test12AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:30'!
test13AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:14:16'!
test14NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/24/2020 02:23:47'!
test15NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'Ok 4/13/2024 17:33:12'!
test16SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (Fraccion with: negativeOne over: negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'Ok 4/13/2024 17:33:15'!
test17SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (Fraccion with: one over: negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'Ok 4/13/2024 17:28:03'!
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
	
	oneHalf := Fraccion with: one over: two.
	oneFifth := Fraccion with: one over: five.
	twoFifth := Fraccion with: two over: five.
	twoTwentyfifth := Fraccion with: two over: (Entero with: 25).
	fiveHalfs := Fraccion with: five over: two.
	negativeOneHalf := Fraccion with: negativeOne over: two
	! !


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'Ok 4/13/2024 17:23:29'!
* aMultiplier 

	self subclassResponsibility 
	! !

!Numero methodsFor: 'arithmetic operations' stamp: 'Ok 4/13/2024 17:23:36'!
+ anAdder 
	
	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'Ok 4/13/2024 17:23:39'!
// aDivisor 
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:49:48'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !


!Numero class methodsFor: 'instance creation' stamp: 'NR 9/8/2019 20:46:40'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^self new initializeWith: aValue! !

!Numero class methodsFor: 'instance creation' stamp: 'NR 9/8/2019 23:20:40'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue: [ ^self with: aDividend negated over: aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'valueEntero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'Comparision' stamp: 'Ok 4/13/2024 16:56:23'!
= anObject
	^ (anObject isKindOf: self class) and: [valueEntero = anObject integerValue ]! !

!Entero methodsFor: 'Comparision' stamp: 'Ok 4/13/2024 16:56:08'!
hash
	^valueEntero hash
	! !


!Entero methodsFor: 'Testing' stamp: 'Ok 4/13/2024 17:04:21'!
isNegative
		^ valueEntero < 0! !

!Entero methodsFor: 'Testing' stamp: 'Ok 4/13/2024 17:03:16'!
isOne
	^ valueEntero = 1 ! !

!Entero methodsFor: 'Testing' stamp: 'Ok 4/13/2024 17:03:29'!
isZero
	^ valueEntero = 0 ! !


!Entero methodsFor: 'Operations' stamp: 'Ok 4/13/2024 06:05:11'!
* aMultiplier
	^self class with: valueEntero * aMultiplier integerValue.! !

!Entero methodsFor: 'Operations' stamp: 'Ok 4/13/2024 06:05:18'!
+ anAdder
	^self class with: valueEntero + anAdder integerValue.! !

!Entero methodsFor: 'Operations' stamp: 'Ok 4/13/2024 06:07:07'!
// aDivisor
	^self class with: valueEntero // aDivisor integerValue.! !

!Entero methodsFor: 'Operations' stamp: 'Ok 4/13/2024 16:56:13'!
greatestCommonDivisorWith: anEntero
	^self class with: (valueEntero gcd: anEntero integerValue)! !

!Entero methodsFor: 'Operations' stamp: 'Ok 4/13/2024 17:03:44'!
negated
	^self * (self class with: -1) ! !


!Entero methodsFor: 'Initialize' stamp: 'Ok 4/13/2024 17:02:45'!
initializeWith: aValue
	valueEntero := aValue! !


!Entero methodsFor: 'Value' stamp: 'Ok 4/13/2024 17:10:54'!
integerValue
	^valueEntero! !


!Entero methodsFor: 'Printing' stamp: 'Ok 4/13/2024 17:04:02'!
printOn: aStream
	aStream print: valueEntero ! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numeratorFraction denominatorFraction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'Operators' stamp: 'Ok 4/13/2024 17:20:50'!
* aMultiplier 
	^self class with: (numeratorFraction * aMultiplier numerator) over: (denominatorFraction * aMultiplier denominator) 
		
	! !

!Fraccion methodsFor: 'Operators' stamp: 'Ok 4/13/2024 17:21:19'!
+ anAdder 
	| newNumerator newDenominator |
		
	newNumerator := (numeratorFraction * anAdder denominator) + (denominatorFraction * anAdder numerator).
	newDenominator := denominatorFraction * anAdder denominator.
		
	^ self class with: newNumerator over: newDenominator 
	

	! !

!Fraccion methodsFor: 'Operators' stamp: 'Ok 4/13/2024 17:45:14'!
negated
	
	^self class with: numeratorFraction * (Entero with: -1) over: denominatorFraction ! !


!Fraccion methodsFor: 'Initialize' stamp: 'Ok 4/13/2024 17:22:54'!
initializeWith: aNumerator over: aDenominator

	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numeratorFraction := aNumerator.
	denominatorFraction := aDenominator ! !


!Fraccion methodsFor: 'value' stamp: 'Ok 4/13/2024 17:22:15'!
denominator

	^denominatorFraction! !

!Fraccion methodsFor: 'value' stamp: 'Ok 4/13/2024 17:25:10'!
numerator

	^numeratorFraction! !


!Fraccion methodsFor: 'Comparison' stamp: 'Ok 4/13/2024 17:22:07'!
= anObject

	^(numeratorFraction * anObject denominator) = (denominatorFraction * anObject numerator) ! !

!Fraccion methodsFor: 'Comparison' stamp: 'Ok 4/13/2024 17:22:33'!
hash
	^(numeratorFraction hash / denominatorFraction hash) hash ! !


!Fraccion methodsFor: 'Testing' stamp: 'Ok 4/13/2024 17:24:37'!
isNegative
	
	^denominatorFraction < 0 ! !

!Fraccion methodsFor: 'Testing' stamp: 'Ok 4/13/2024 17:24:48'!
isOne

	^false ! !

!Fraccion methodsFor: 'Testing' stamp: 'Ok 4/13/2024 17:24:56'!
isZero

	^false ! !


!Fraccion methodsFor: 'Printing' stamp: 'Ok 4/13/2024 17:26:38'!
printOn: aStream
		
	aStream 
		print: numeratorFraction;
		nextPut: $/;
		print: denominatorFraction.! !
