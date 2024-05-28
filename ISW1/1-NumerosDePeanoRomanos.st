!classDefinition: #Tiempo category: #Parte2!
DenotativeObject subclass: #Tiempo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tiempo class' category: #Parte2!
Tiempo class
	instanceVariableNames: ''!

!Tiempo class methodsFor: 'as yet unclassified' stamp: 'Ok 4/4/2024 14:46:35'!
DoIt

(GregorianDateTime now next distanceFrom: GregorianDateTime now) convertTo: second.! !

!Tiempo class methodsFor: '-- all --' stamp: 'Ok 4/4/2024 15:13:42'!
TirandoCodigo
	FixedGregorianDate today day next: (7*day).
	TimeOfDay now next: (24*second).
	TimeOfDay now next: (TimeOfDay now distanceTo: TimeOfDay now next).
	TimeOfDay now next:(86400*second). "Invalido porque TimeOFDAy nos dice la hora de hoy +- offset, no sirve para otros dias".
	(April, 2024) year isLeap.
	TimeOfDay now next: (3600*second).
	
	! !


!Tiempo class methodsFor: 'as yet unclassified' stamp: 'Ok 4/4/2024 14:46:35'!
DoIt

(GregorianDateTime now next distanceFrom: GregorianDateTime now) convertTo: second.! !


!classDefinition: #bitcoin category: #Parte2!
DenotativeObject subclass: #bitcoin
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'bitcoin class' category: #Parte2!
bitcoin class
	instanceVariableNames: ''!

!bitcoin class methodsFor: '-- all --' stamp: 'Ok 4/4/2024 12:24:35'!
conversion
	|table unBitcoin bitcoinAPesos moneyConverter bitcoin unBitcoinMas10k|
	
	bitcoin := self createBitcoin.
	
	unBitcoin := SimpleMeasure amount: 1 unit: bitcoin.
	bitcoinAPesos := SimpleMeasure amount: 58237760.31 unit: peso.
	
	table := ConversionTable new.
	table measure: unBitcoin isEquivalentTo: bitcoinAPesos.
	
	moneyConverter := MeasureConverter on: table.
	
	"^(moneyConverter convert: unBitcoin to: peso)."
	
	unBitcoinMas10k := 10000*peso + unBitcoin.
	
	^(moneyConverter  convert: (unBitcoinMas10k) to: peso) ! !

!bitcoin class methodsFor: '-- all --' stamp: 'Ok 4/4/2024 11:27:52'!
createBitcoin
	^ BaseUnit named: 'bitcoin' sign: 'btc'! !


!classDefinition: #object category: #Parte2!
DenotativeObject subclass: #object
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'object class' category: #Parte2!
object class
	instanceVariableNames: 'aVar'!

!object class methodsFor: '-- all --' stamp: 'Ok 4/3/2024 05:31:42'!
array
	|x|
	"x := Array with: 5 with: 4 with: 3 with: 2."
	x := #(5 4 3 2).
	
	x at: 1 put: 42.
	x at: 5 put: 32.
	
	^ x.	! !

!object class methodsFor: '-- all --' stamp: 'Ok 4/3/2024 15:01:00'!
blocks
	| x y |
	x := [ y := 1.].
	x value.
	^y.! !

!object class methodsFor: '-- all --' stamp: 'Ok 4/3/2024 08:33:52'!
converts
	|x toOrdered toSet pair|
	x := #(5 4 3 2).
	
	toOrdered := x asOrderedCollection.
	toSet := x asSet.
	
	pair := toOrdered -> toSet .
	
	^ pair.	! !

!object class methodsFor: '-- all --' stamp: 'Ok 4/3/2024 08:38:05'!
dictionary
	|x y z w a b toArray pair|
	x := Dictionary new.
	x add: #a->4; add: #b->3; add: #c->1; add: #d->2; yourself.
	
	x add: #e->42.
	y := x size.
	z := x keys.
	w := x values.
	a := x at: #a.
	b := x includesKey: #z.
	x add: #z->18.
	b := (x includesKey: #z) ifTrue: 24.
	
	toArray := x asArray.
	
	pair := x->toArray .
	
	
	^pair.! !

!object class methodsFor: '-- all --' stamp: 'Ok 4/3/2024 11:51:44'!
dobles
	|elementos duplicados|
	
	elementos := # (1 2 5).
	duplicados := OrderedCollection new.
	
	1 to: (elementos size) do: [ :i |
		duplicados	 add: (elementos at: i) * 2. 
	].

	^duplicados .! !

!object class methodsFor: '-- all --' stamp: 'Ok 4/3/2024 11:55:50'!
doblesWhile
	|elementos duplicados index|
	
	elementos := # (1 2 5).
	duplicados := OrderedCollection new.
	
	index := 1.
	
	[index <= elementos size] whileTrue: [
		duplicados add: (elementos at: index) * 2.
		index := index + 1.
	].

	^duplicados .! !

!object class methodsFor: '-- all --' stamp: 'Ok 4/3/2024 08:39:22'!
impares
	| elements index odds |
	
	elements:= #(1 2 5 6 9).
	
	odds := OrderedCollection new.
	
	index := 1.
	
	[index <= elements size]
	
	whileTrue: [
		((elements at: index) odd) ifTrue: [odds add: (elements at: index)].
		index := index +1.
	].

	^odds! !

!object class methodsFor: '-- all --' stamp: 'Ok 4/3/2024 11:43:19'!
imparesForLoop
	| elements index odds |
	
	elements:= #(1 2 5 6 9 11).
	
	odds := OrderedCollection new.
	
	"index := 1.
	
	[index <= elements size]
	
	whileTrue: [
		((elements at: index) odd) ifTrue: [odds add: (elements at: index)].
		index := index +1.
	]."

	1 to: (elements size) do: [:i | 
		((elements at:i) odd) ifTrue: [odds add: (elements at:i)].
	].

	^odds! !

!object class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/4/2024 15:14:56'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	aVar := 42.! !

!object class methodsFor: '-- all --' stamp: 'Ok 4/3/2024 12:03:21'!
iterarSobreVectoresMasCompacto
	|elementos duplicados |
	
	elementos := # (1 2 5).
	duplicados := OrderedCollection new.

	elementos do: [:a | duplicados add: a * 2]. "Es un for each"

	^duplicados .! !

!object class methodsFor: '-- all --' stamp: 'Ok 4/3/2024 04:44:38'!
m1
	|b|
	
	b := 42.
	
	aVar := 1.
	
	^ self m2: b! !

!object class methodsFor: '-- all --' stamp: 'Ok 4/3/2024 04:45:07'!
m2: anotherValue
	|b|
	
	b := 24.
	
	aVar < 3 ifTrue: [ aVar := aVar + anotherValue].
	
	^ aVar + b! !

!object class methodsFor: '-- all --' stamp: 'Ok 4/3/2024 16:26:40'!
medida

	10 * peso + 10 * dollar.
	10 * peso +( 10 * dollar).
	10 * peso +( 10 * dollar) - (2 * dollar).
	10 * peso +( 10 * dollar) - (2 * dollar) - (8 * dollar).
	(10 * peso) amount.
	(10 * peso) unit.
	1 amount.
	1 unit.
	(10 * peso) + 1.
	1 + (10 * peso).
	(10 * peso) * 5.
	(10 * peso) * (5 * peso).
	peso := BaseUnit nameForOne: 'peso' nameForMany: 'pesos' sign: $$.
	
	! !

!object class methodsFor: '-- all --' stamp: 'Ok 4/3/2024 16:29:14'!
metros
	|x metros diezMetros|
	
	metros := BaseUnit nameForOne: 'metro' nameForMany: 'metros'.
	diezMetros := 10 * metros.
	^x.! !

!object class methodsFor: '-- all --' stamp: 'Ok 4/3/2024 05:35:50'!
orderedCollection
	|x|

	x := OrderedCollection with: 4 with: 3 with: 2 with: 1.
	
	x add: 42.
	
	x add: 2.
	
	^x.! !

!object class methodsFor: '-- all --' stamp: 'Ok 4/3/2024 12:25:30'!
primerNumeroPar
	|elementos firstEven index|
	
	elementos := OrderedCollection new.
	elementos add: 1; add: 5; add: 9; yourself.
	index := elementos findFirst: [:a | a \\ 2 == 0].
	firstEven := [elementos at: index] on: Error do: [^self error: 'No hay pares']. 
	^(firstEven value)! !

!object class methodsFor: '-- all --' stamp: 'Ok 4/3/2024 08:36:19'!
set
	|x toArray pair|
	
	x := Set with: 4 with: 3 with: 2 with: 1.
	
	x add: 42. 
	
	x add: 2.
	
	toArray  := x asArray.
	pair := x->toArray .
	
	^pair! !

!object class methodsFor: '-- all --' stamp: 'Ok 4/3/2024 14:21:39'!
suma
	|suma elementos index|
	
	elementos := # (1 5 9).

	index := 1.
	suma := 0.	
	[index <= elementos size] whileTrue: [
		suma := (elementos at: index) + suma.
		index := index + 1.
	].

	suma := 0.
	elementos do: [:a | suma := suma + a].

	suma := elementos inject: 0 into:[:a :c | a + c].

	^suma.! !

!object class methodsFor: '-- all --' stamp: 'Ok 4/3/2024 15:02:21'!
symbols
	| x y |
	x := #pepe.
	y := #pepe.
	x = y.
	
	#Hello , #World, #!!
	
	"Los simbolos son una concatenacion de objetos alfanumericos unicos en el sistema para representar nombres"! !

!object class methodsFor: '-- all --' stamp: 'Ok 4/3/2024 14:38:09'!
vocales
	|letras vocales|
	
	letras := 'abcdefguijp'.
	vocales := letras select: [:a | (a==$a) or: (a==$e) or: (a==$i) or: (a==$o) or: (a==$u)].
	
	^vocales.! !


!object class methodsFor: '--** private fileout/in **--' stamp: 'Ok 4/4/2024 15:14:56'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	aVar := 42.! !


!classDefinition: #temperaturas category: #Parte2!
DenotativeObject subclass: #temperaturas
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'temperaturas class' category: #Parte2!
temperaturas class
	instanceVariableNames: ''!

!temperaturas class methodsFor: '-- all --' stamp: 'Ok 4/4/2024 12:58:41'!
c
	^ NotProportionalDerivedUnit
		baseUnit: kelvin
		conversionBlock: [:celsius | celsius + (5463/20)] "C = 0 = 273.15K -> C = 10 = 283.15K"
		reciprocalConversionBlock: [:kelvin | kelvin - (5463/20)]
		named: 'celsius'
		sign: '°'! !

!temperaturas class methodsFor: '-- all --' stamp: 'Ok 4/4/2024 12:58:41'!
f
	^ NotProportionalDerivedUnit
		baseUnit: kelvin
		conversionBlock: [:fahrenheit | (fahrenheit-32)*(5/9) + (27315/100)] 
		reciprocalConversionBlock: [:kelvin | (kelvin - (27315/100))*(9/5)+32]
		named: 'fahrenheit'
		sign: 'F'! !

!temperaturas class methodsFor: '-- all --' stamp: 'Ok 4/4/2024 12:58:41'!
k
	^ BaseUnit named: 'kelvin' sign: 'K'.! !

!temperaturas class methodsFor: '-- all --' stamp: 'Ok 4/4/2024 12:58:41'!
sumar
	^ ( (30* (self k)) + (20* (self c)) + (10* (self f)) )! !

object initializeAfterFileIn!