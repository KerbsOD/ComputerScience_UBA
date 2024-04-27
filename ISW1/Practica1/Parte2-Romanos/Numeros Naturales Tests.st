!classDefinition: #NumerosNaturalesTest category: 'Numeros Naturales Tests'!
DenotativeObject subclass: #NumerosNaturalesTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales Tests'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NumerosNaturalesTest class' category: 'Numeros Naturales Tests'!
NumerosNaturalesTest class
	instanceVariableNames: ''!

!NumerosNaturalesTest class methodsFor: 'tests' stamp: 'ARM 3/26/2018 12:51:26'!
test01UnoMasUnSumandoEsElProximoDelSumando

	Assert that: I + II isEqualTo: II next.! !

!NumerosNaturalesTest class methodsFor: 'tests' stamp: 'ARM 4/6/2021 14:37:43'!
test02NumerosMayoresaUnoSumanBien

	Assert that: II + II isEqualTo: IIII.
! !

!NumerosNaturalesTest class methodsFor: 'tests' stamp: 'ARM 3/26/2018 13:12:19'!
test03UnNumeroMenosUnoEsElPrevioDelNumero

	Assert that: II - I isEqualTo: II previous.! !

!NumerosNaturalesTest class methodsFor: 'tests' stamp: 'ARM 4/6/2021 14:37:48'!
test04NumerosMayoresaUnoRestanBien

	Assert that: IIII - II isEqualTo: II.! !

!NumerosNaturalesTest class methodsFor: 'tests' stamp: 'ARM 3/26/2018 12:51:02'!
test05RestaNoSoportaNumerosNegativos

	Assert should: [ I - II ] signal: Error withDescription: I descripcionDeErrorDeNumerosNegativosNoSoportados.
! !

!NumerosNaturalesTest class methodsFor: 'tests' stamp: 'ARM 3/26/2018 13:15:53'!
test06UnNumeroMultiplicadoPorUnoEsIgualAlNumero

	Assert that: II * I isEqualTo: II.! !

!NumerosNaturalesTest class methodsFor: 'tests' stamp: 'ARM 4/6/2021 14:37:51'!
test07NumerosMayoresaUnoMultiplicanBien

	Assert that: II * II isEqualTo: IIII.! !

!NumerosNaturalesTest class methodsFor: 'tests' stamp: 'ARM 3/26/2018 13:16:46'!
test08UnoMultiplicadoUnoEsIgualAUno

	Assert that: I * I isEqualTo: I.! !

!NumerosNaturalesTest class methodsFor: 'tests' stamp: 'ARM 4/6/2021 14:37:53'!
test09NumerosMayoresaUnoDividenBien

	Assert that: IIII / II isEqualTo: II.! !

!NumerosNaturalesTest class methodsFor: 'tests' stamp: 'ARM 3/26/2018 13:17:28'!
test10UnNumeroDivididoUnoEsIgualAlNumero

	Assert that: II / I isEqualTo: II.! !

!NumerosNaturalesTest class methodsFor: 'tests' stamp: 'ARM 3/26/2018 13:17:38'!
test11UnoDivididoUnoEsIgualAUno

	Assert that: I / I isEqualTo: I.! !

!NumerosNaturalesTest class methodsFor: 'tests' stamp: 'ARM 4/6/2021 14:37:57'!
test12DivisionNoSoportaDividirPorUnNumeroMayor

	Assert should: [ III /  IIII ] signal: Error withDescription: II descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.

	Assert should: [ I /  II] signal: Error withDescription: I descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
! !
