!classDefinition: #LogTest category: #'MarsRover-WithHeading'!
TestCase subclass: #LogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!LogTest methodsFor: 'as yet unclassified' stamp: 'OK 5/30/2024 11:47:34'!
test01
	
	| marsRover log|
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := Log new.
	
	marsRover registerHeadingObserver: log.
	
	marsRover process: ''.
	
	self assert: log print = OrderedCollection new.! !

!LogTest methodsFor: 'as yet unclassified' stamp: 'OK 5/30/2024 11:47:45'!
test02
	
	| marsRover log|
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := Log new.
	
	marsRover registerPositionObserver: log.
	
	marsRover process: 'f'.
	
	self assert: log print = (OrderedCollection with: '1@2').! !

!LogTest methodsFor: 'as yet unclassified' stamp: 'OK 5/30/2024 11:47:45'!
test03
	
	| marsRover log|
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := Log new.
	
	marsRover registerPositionObserver: log.
	
	marsRover process: 'b'.
	
	
	self assert: log print = (OrderedCollection with: '1@0').! !

!LogTest methodsFor: 'as yet unclassified' stamp: 'OK 5/30/2024 11:47:34'!
test04
	
	| marsRover log|
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := Log new.
	
	marsRover registerHeadingObserver: log.
	
	marsRover process: 'r'.
	
	self assert: log print = (OrderedCollection with: 'East').! !

!LogTest methodsFor: 'as yet unclassified' stamp: 'OK 5/30/2024 11:47:34'!
test05
	
	| marsRover log|
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := Log new.
	
	marsRover registerHeadingObserver: log.
	
	marsRover process: 'l'.
	
	self assert: log print = (OrderedCollection with: 'West').! !

!LogTest methodsFor: 'as yet unclassified' stamp: 'OK 5/30/2024 11:47:45'!
test06
	
	| marsRover log|
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := Log new.
	
	marsRover registerPositionObserver: log.
	
	marsRover process: 'ff'.
	
	self assert: log print = (OrderedCollection with: '1@2' with: '1@3').! !

!LogTest methodsFor: 'as yet unclassified' stamp: 'OK 5/30/2024 11:47:34'!
test07
	
	| marsRover log|
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := Log new.
	
	marsRover registerHeadingObserver: log.
	
	marsRover process: 'ff'.
	
	self assert: log print = (OrderedCollection new).! !

!LogTest methodsFor: 'as yet unclassified' stamp: 'OK 5/30/2024 11:47:45'!
test08
	
	| marsRover log|
	
	marsRover := MarsRover at: 1@1 heading: #East.
	log := Log new.
	
	marsRover registerPositionObserver: log.
	marsRover registerHeadingObserver: log.
	marsRover process: 'f'.
	
	self assert: log print = (OrderedCollection with: '2@1').! !

!LogTest methodsFor: 'as yet unclassified' stamp: 'OK 5/30/2024 11:47:34'!
test09
	
	| marsRover log|
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := Log new.
	
	marsRover registerHeadingObserver: log.
	
	marsRover process: 'rl'.
	
	self assert: log print = (OrderedCollection with: 'East' with: 'North').! !

!LogTest methodsFor: 'as yet unclassified' stamp: 'OK 5/30/2024 11:47:45'!
test10
	
	| marsRover log|
	
	marsRover := MarsRover at: 1@1 heading: #North.
	log := Log new.
	
	marsRover registerPositionObserver: log.
	marsRover registerHeadingObserver: log.
	
	marsRover process: 'fr'.
	
	self assert: log print = (OrderedCollection with: '1@2' with: 'East').! !


!classDefinition: #MarsRoverTest category: #'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:26'!
test01

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: ''.
	
	self assert: (marsRover isAt: 1@2 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:31'!
test02

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@3 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:34'!
test03

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@1 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:38'!
test04

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:45'!
test05

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #West)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:50'!
test06

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: #North) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:54'!
test07

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'ff'.
	
	self assert: (marsRover isAt: 1@4 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:59'!
test08

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 2@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:06'!
test09

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 0@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:12'!
test10

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #South)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:20'!
test11

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:25'!
test12

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #South.
	
	marsRover process: 'ffbr'.
	
	self assert: (marsRover isAt: 1@1 heading: #West)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:29'!
test13

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #South.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:33'!
test14

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #West.
	
	marsRover process: 'ffbr'.
	
	self assert: (marsRover isAt: 0@2 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:37'!
test15

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #West.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #South)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/2/2018 16:27:43'!
test16

	self 
		should: [MarsRover at: 1@2 heading: #X ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: MarsRover invalidCardinalPointErrorDescription equals: anError messageText ]! !


!classDefinition: #WindowTest category: #'MarsRover-WithHeading'!
TestCase subclass: #WindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!WindowTest methodsFor: 'as yet unclassified' stamp: 'OK 5/30/2024 11:47:45'!
test01
	
	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	window := Window new.
	
	marsRover registerPositionObserver: window.
	marsRover process: 'f'.
	
	self assert: window position = (1@2).
	self assert: window heading = ''.! !

!WindowTest methodsFor: 'as yet unclassified' stamp: 'OK 5/30/2024 11:47:45'!
test02
	
	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	window := Window new.
	
	marsRover registerPositionObserver: window.
	marsRover registerHeadingObserver: window.
	marsRover process: 'fr'.
	
	self assert: window position = (1@2).
	self assert: window heading = 'Apuntando al Este'.! !

!WindowTest methodsFor: 'as yet unclassified' stamp: 'OK 5/30/2024 11:47:45'!
test03
	
	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	window := Window new.
	
	marsRover registerPositionObserver: window.
	marsRover registerHeadingObserver: window.
	marsRover process: 'frf'.
	
	self assert: window position = (2@2).
	self assert: window heading = 'Apuntando al Este'.! !

!WindowTest methodsFor: 'as yet unclassified' stamp: 'OK 5/30/2024 11:47:45'!
test04
	
	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	window := Window new.
	
	marsRover registerPositionObserver: window.
	marsRover process: 'frf'.
	
	self assert: window position = (2@2).
	self assert: window heading = ''.! !

!WindowTest methodsFor: 'as yet unclassified' stamp: 'OK 5/30/2024 11:47:34'!
test05
	
	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	window := Window new.
	
	marsRover registerHeadingObserver: window.
	marsRover process: 'frrf'.
	
	self assert: window position = nil.
	self assert: window heading = 'Apuntando al Sur'.! !

!WindowTest methodsFor: 'as yet unclassified' stamp: 'OK 5/30/2024 11:47:34'!
test06
	
	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	window := Window new.
	
	marsRover registerHeadingObserver: window.
	marsRover process: 'frrf'.
	
	self assert: window position = nil.
	self assert: window heading = 'Apuntando al Sur'.! !


!classDefinition: #Log category: #'MarsRover-WithHeading'!
Object subclass: #Log
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Log methodsFor: 'testing' stamp: 'OK 5/28/2024 09:42:02'!
print
	
	^ log.! !


!Log methodsFor: 'initialization' stamp: 'OK 5/28/2024 16:59:02'!
initialize

	log := OrderedCollection new.
	
	! !


!Log methodsFor: 'update' stamp: 'OK 5/28/2024 17:00:58'!
updateHeading: aDirection
	
	log add: aDirection asString 
	

	

	! !

!Log methodsFor: 'update' stamp: 'OK 5/28/2024 17:01:06'!
updatePosition: aPosition
	
	log add: aPosition asString 
	

	

	! !


!classDefinition: #MarsRover category: #'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'OK 5/30/2024 11:37:09'!
initializeAt: aPosition heading: aHeading 

	position := aPosition.
	head := aHeading.
	observers := MarsRoverChangeManager new.! !


!MarsRover methodsFor: 'observers' stamp: 'OK 5/30/2024 11:47:34'!
registerHeadingObserver: anObserver

	observers registerHeadingObserver: anObserver.! !

!MarsRover methodsFor: 'observers' stamp: 'OK 5/30/2024 11:47:45'!
registerPositionObserver: anObserver

	observers registerPositionObserver: anObserver.! !


!MarsRover methodsFor: 'heading' stamp: 'OK 5/30/2024 10:32:23'!
headEast
	
	self updateHeading: MarsRoverHeadingEast new.! !

!MarsRover methodsFor: 'heading' stamp: 'OK 5/30/2024 10:32:27'!
headNorth
	
	self updateHeading: MarsRoverHeadingNorth new! !

!MarsRover methodsFor: 'heading' stamp: 'OK 5/30/2024 10:32:31'!
headSouth
	
	self updateHeading: MarsRoverHeadingSouth new! !

!MarsRover methodsFor: 'heading' stamp: 'OK 5/30/2024 10:32:35'!
headWest
	
	self updateHeading: MarsRoverHeadingWest new! !

!MarsRover methodsFor: 'heading' stamp: 'OK 5/30/2024 08:44:39'!
rotateLeft
	
	head rotateLeft: self.! !

!MarsRover methodsFor: 'heading' stamp: 'OK 5/30/2024 08:44:34'!
rotateRight
	
	head rotateRight: self.! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 8/22/2019 12:00:30'!
isAt: aPosition heading: aCardinalPoint

	^position = aPosition and: [ head isHeading: aCardinalPoint ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'OK 5/30/2024 08:44:11'!
moveBackward
	
	head moveBackward: self.! !

!MarsRover methodsFor: 'moving' stamp: 'OK 5/30/2024 10:31:06'!
moveEast

	self updatePosition: ( position + (1@0) ).
	! !

!MarsRover methodsFor: 'moving' stamp: 'OK 5/30/2024 08:44:18'!
moveForward
	
	head moveForward: self.! !

!MarsRover methodsFor: 'moving' stamp: 'OK 5/30/2024 10:30:45'!
moveNorth
		
	self updatePosition: ( position + (0@1) ).! !

!MarsRover methodsFor: 'moving' stamp: 'OK 5/30/2024 10:31:21'!
moveSouth
	
	self updatePosition: ( position + (0@-1) ).
	! !

!MarsRover methodsFor: 'moving' stamp: 'OK 5/30/2024 10:31:33'!
moveWest
	
	self updatePosition: ( position + (-1@0) ).
	! !


!MarsRover methodsFor: 'update internal colaborators' stamp: 'OK 5/30/2024 11:34:03'!
updateHeading: aHeading

	head := aHeading.
	observers notifyHeadingUpdate: ( head asCardinalText ).! !

!MarsRover methodsFor: 'update internal colaborators' stamp: 'OK 5/30/2024 11:34:07'!
updatePosition: aPosition

	position := aPosition.
	observers notifyPositionUpdate: position.! !


!MarsRover methodsFor: 'command processing' stamp: 'OK 5/30/2024 10:27:41'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [ :aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'OK 5/28/2024 11:12:47'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.
	
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 8/22/2019 12:01:48'!
at: aPosition heading: aCardinalPoint
	
	^self new initializeAt: aPosition heading: (MarsRoverHeading heading: aCardinalPoint)! !

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 7/2/2018 16:26:14'!
invalidCardinalPointErrorDescription
	
	^'Invalid cardinal point'! !


!classDefinition: #MarsRoverChangeManager category: #'MarsRover-WithHeading'!
Object subclass: #MarsRoverChangeManager
	instanceVariableNames: 'positionObservers headingObservers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverChangeManager methodsFor: 'add observers' stamp: 'OK 5/30/2024 11:47:34'!
registerHeadingObserver: anObserver

	headingObservers add: anObserver.! !

!MarsRoverChangeManager methodsFor: 'add observers' stamp: 'OK 5/30/2024 11:47:45'!
registerPositionObserver: anObserver

	positionObservers add: anObserver.! !


!MarsRoverChangeManager methodsFor: 'initialize' stamp: 'OK 5/30/2024 10:24:26'!
initialize
	
	headingObservers := OrderedCollection new.
	positionObservers := OrderedCollection new.! !


!MarsRoverChangeManager methodsFor: 'notify observers' stamp: 'OK 5/30/2024 10:25:15'!
notifyHeadingUpdate: aHeading

	headingObservers do: [ :anObserver | anObserver updateHeading: aHeading ].! !

!MarsRoverChangeManager methodsFor: 'notify observers' stamp: 'OK 5/30/2024 10:25:25'!
notifyPositionUpdate: aPosition

	positionObservers do: [ :anObserver | anObserver updatePosition: aPosition ].! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverChangeManager class' category: #'MarsRover-WithHeading'!
MarsRoverChangeManager class
	instanceVariableNames: ''!

!MarsRoverChangeManager class methodsFor: 'as yet unclassified' stamp: 'OK 5/30/2024 08:51:23'!
with: aDictionaryOfStates

	^ self new initializeWith: aDictionaryOfStates.! !


!classDefinition: #MarsRoverHeading category: #'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:06:17'!
rotateLeft: aMarsRover

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:08:23'!
rotateRight: aMarsRover

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'OK 5/28/2024 11:22:12'!
asCardinalText
	
	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 7/2/2018 19:07:42'!
isHeading: aCardinalPoint

	^self class isFor: aCardinalPoint! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:20'!
moveBackward: aMarsRover

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:54'!
moveForward: aMarsRover

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: #'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'cardinal point' stamp: 'HAW 7/2/2018 19:07:01'!
cardinalPoint

	self subclassResponsibility ! !


!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 8/22/2019 12:02:00'!
heading: aCardinalPoint

	^self subclasses 
		detect: [ :aMarsRoverPositionClass | aMarsRoverPositionClass isFor: aCardinalPoint ]
		ifFound: [ :aMarsRoverPositionClass | aMarsRoverPositionClass new ]
		ifNone: [ self error: MarsRover invalidCardinalPointErrorDescription ]! !


!MarsRoverHeading class methodsFor: 'testing' stamp: 'HAW 7/2/2018 17:01:33'!
isFor: aCardinalPoint

	^self cardinalPoint = aCardinalPoint ! !


!classDefinition: #MarsRoverHeadingEast category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:09:19'!
moveBackward: aMarsRover
	
	^aMarsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:09:28'!
moveForward: aMarsRover
	
	^aMarsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:09:42'!
rotateLeft: aMarsRover
	
	^aMarsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:09:54'!
rotateRight: aMarsRover
	
	^aMarsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'as yet unclassified' stamp: 'OK 5/28/2024 11:22:12'!
asCardinalText
	
	^ #East! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingEast class' category: #'MarsRover-WithHeading'!
MarsRoverHeadingEast class
	instanceVariableNames: ''!

!MarsRoverHeadingEast class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:01:53'!
cardinalPoint

	^#East! !


!classDefinition: #MarsRoverHeadingNorth category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'OK 5/28/2024 11:22:12'!
asCardinalText
	
	^ #North! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:10:12'!
moveBackward: aMarsRover
	
	^aMarsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:10:23'!
moveForward: aMarsRover
	
	^aMarsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:10:40'!
rotateLeft: aMarsRover
	
	^aMarsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:10:51'!
rotateRight: aMarsRover
	
	^aMarsRover headEast! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingNorth class' category: #'MarsRover-WithHeading'!
MarsRoverHeadingNorth class
	instanceVariableNames: ''!

!MarsRoverHeadingNorth class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:11'!
cardinalPoint

	^#North! !


!classDefinition: #MarsRoverHeadingSouth category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'OK 5/28/2024 11:22:12'!
asCardinalText
	
	^ #South! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:11:15'!
moveBackward: aMarsRover
	
	^aMarsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:11:25'!
moveForward: aMarsRover
	
	^aMarsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:11:55'!
rotateLeft: aMarsRover
	
	^aMarsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:11:50'!
rotateRight: aMarsRover
	
	^aMarsRover headWest! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingSouth class' category: #'MarsRover-WithHeading'!
MarsRoverHeadingSouth class
	instanceVariableNames: ''!

!MarsRoverHeadingSouth class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:17'!
cardinalPoint

	^#South! !


!classDefinition: #MarsRoverHeadingWest category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'OK 5/28/2024 11:22:12'!
asCardinalText
	
	^ #West! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:12:07'!
moveBackward: aMarsRover

	^aMarsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:12:15'!
moveForward: aMarsRover
	
	^aMarsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:12:26'!
rotateLeft: aMarsRover
	
	^aMarsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:12:41'!
rotateRight: aMarsRover
	
	^aMarsRover headNorth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingWest class' category: #'MarsRover-WithHeading'!
MarsRoverHeadingWest class
	instanceVariableNames: ''!

!MarsRoverHeadingWest class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:23'!
cardinalPoint

	^#West! !


!classDefinition: #Window category: #'MarsRover-WithHeading'!
Object subclass: #Window
	instanceVariableNames: 'position head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Window methodsFor: 'update' stamp: 'OK 5/28/2024 17:42:06'!
updateHeading: aDirection

	( aDirection = #East ) ifTrue: [ 	head := 'Apuntando al Este' ].
	( aDirection = #South ) ifTrue: [ 	head := 'Apuntando al Sur' ].
	( aDirection = #North ) ifTrue: [ 	head := 'Apuntando al Norte' ].
	( aDirection = #West ) ifTrue: [ 	head := 'Apuntando al Oeste' ].! !

!Window methodsFor: 'update' stamp: 'OK 5/28/2024 17:00:00'!
updatePosition: aPosition

	position := aPosition ! !


!Window methodsFor: 'testing' stamp: 'OK 5/28/2024 17:41:56'!
heading

	^ head.! !

!Window methodsFor: 'testing' stamp: 'OK 5/28/2024 12:33:40'!
position
	
	^ position.! !


!Window methodsFor: 'initialization' stamp: 'OK 5/28/2024 17:41:45'!
initialize

	position := nil.
	head := ''.! !
